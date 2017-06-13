<?php

require __DIR__ . '/required.php';
header("Content-Type: application/json");

// Oldest session allowed
$session_min_date = date("Y-m-d H:i:s", strtotime("-" . SESSION_EXPIRE_MINUTES . " minutes"));
// Delete old sessions
$old_sessions = $database->select("sessions", "sid", ["timestamp[<]" => $session_min_date]);
$database->delete("scrambled_answers", ["sid" => $old_sessions]);
$database->delete("sessions", ["sid" => $old_sessions]);

switch ($VARS['action']) {
    case "ping":
        $out = ["status" => "OK", "pong" => true];
        exit(json_encode($out));
    case "new":
        // generate unique session ID that has an essentially zero chance of being a duplicate.
        // Contains a hash of a secure random number, a hash of the user's IP, and 23 uniqid() characters.
        $skey = uniqid(substr(hash("md5", mt_rand()), 3, 5) . hash("md5", getUserIP()), true);
        
        // Image problem
        // 
        // Get five random options
        $answer_count = $database->count('answers');
        $answers = $database->select('answers', ['aid', 'aname'], ["LIMIT" => [mt_rand(0, $answer_count - 6), 5]]);
        shuffle($answers);
        // Pick a correct one at random
        $correct_answer = $answers[mt_rand(0, count($answers) - 1)];
        // Scramble the answer names so the client doesn't know the real answers.
        $scrambled = ["real" => [], "fake" => []];
        foreach ($answers as $a) {
            $scrambled["real"][] = $a['aid'];
            $scrambled["fake"][] = substr(hash("md5", mt_rand()), 0, 20);
        }
        
        // Text problem
        //
        // Get random question
        $access_count = $database->count('access_questions');
        $access_question = $database->select('access_questions', ['acqid', 'acqtext'], ["LIMIT" => [mt_rand(0, $access_count - 1), 1]])[0];
        
        // Save the session data
        $database->insert("sessions", ["skey" => $skey, "aid" => $correct_answer['aid'], "acqid" => $access_question['acqid'], "expired" => 0, "#timestamp" => "NOW()", "ipaddr" => getUserIP()]);
        $sid = $database->id();
        // Save the answer data
        $scrambled_insert = [];
        for ($i = 0; $i < count($scrambled['real']); $i++) {
            $scrambled_insert[] = ["sid" => $sid, "aid" => $scrambled['real'][$i], "acode" => $scrambled['fake'][$i]];
        }
        $database->insert("scrambled_answers", $scrambled_insert);
        
        // Vary question wording a little
        $questions = ["Please click on the [].", "Click the [].", "Find the []."];
        shuffle($questions);
        
        $resp = [
            "session" => $skey,
            "id_prefix" => substr(hash("md5", mt_rand()), 3, 5),
            "question_i" => str_replace("[]", $correct_answer['aname'], $questions[0]),
            "question_a" => $access_question['acqtext'],
            "answers" => $scrambled["fake"]
        ];
        exit(json_encode($resp));
    case "img":
        if (!$database->has('sessions', ['skey' => $VARS['s']])) {
            sendError("Missing or invalid session ID.", "client");
        }
        $sid = $database->get('sessions', 'sid', ['skey' => $VARS['s']]);
        if (!$database->has("scrambled_answers", ["AND" => ["sid" => $sid, "acode" => $VARS['c']]])) {
            sendError("Missing or invalid image code.", "client");
        }
        $imgid = $database->get("scrambled_answers", ["[>]answers" => ["aid" => "aid"]], 'aimg', ["AND" => ["sid" => $sid, "acode" => $VARS['c']]]);
        /* Load image, add some black/white noise, and send */
        header('Content-Type: image/png');
        $imgpath = __DIR__ . "/images/" . $imgid . ".png";
        if (DEBUG) {
            file_put_contents("debug", $imgpath . "\n", FILE_APPEND);
        }
        $img = imagecreatefrompng($imgpath);
        imageAlphaBlending($img, true);
        imageSaveAlpha($img, true);
        $black = imagecolorallocate($img, 0, 0, 0);
        $white = imagecolorallocate($img, 255, 255, 255);
        // Add static noise
        for ($i = 0; $i < 150; $i++) {
            imagesetpixel($img, mt_rand(0, 63), mt_rand(0, 63), $black);
        }
        for ($i = 0; $i < 75; $i++) {
            imagesetpixel($img, mt_rand(0, 63), mt_rand(0, 63), $white);
        }
        // Add lines
        for ($i = 0; $i < 2; $i++) {
            imageline($img, mt_rand(0, 63), mt_rand(0, 63), mt_rand(0, 63), mt_rand(0, 63), $black);
        }
        for ($i = 0; $i < 5; $i++) {
            imageline($img, mt_rand(0, 63), mt_rand(0, 63), mt_rand(0, 63), mt_rand(0, 63), $white);
        }
        imagepng($img);
        exit();
    case "verify":
        if (!$database->has('sessions', ['skey' => $VARS['session_id']])) {
            echo json_encode(["session" => $VARS['session_id'], "result" => false, "msg" => "Session invalid."]);
            exit();
        }
        $sid = $database->get('sessions', 'sid', ['skey' => $VARS['session_id']]);
        $expired = ($database->get('sessions', 'expired', ['skey' => $VARS['session_id']]) == 1 ? true : false);
        if ($expired) {
            echo json_encode(["session" => $VARS['session_id'], "result" => false, "msg" => "Session key already used."]);
            exit();
        }

        $image = false;
        if ($database->has("scrambled_answers", ["AND" => ["sid" => $sid, "acode" => $VARS['answer_id']]])) {
            // Image maybe correct
            $image = true;
        } else if ($database->has("sessions", ["[>]access_answers" => ["acqid" => "acqid"]], ["AND" => ["sid" => $sid, "OR" => ["acatext" => $VARS['answer_id'], "acahash" => hash('md5', $VARS['answer_id'])]]])) {
            // Accessible text correct
            $image = false;
        } else {
            // Invalid answer
            echo json_encode(["session" => $VARS['session_id'], "result" => false, "msg" => "Answer invalid."]);
            exit();
        }
        if ($image) {
            $aid = $database->get('scrambled_answers', 'aid', ["AND" => ["sid" => $sid, "acode" => $VARS['answer_id']]]);
            if ($database->has('sessions', ["AND" => ["sid" => $sid, "aid" => $aid]])) {
                echo json_encode(["session" => $VARS['session_id'], "result" => true]);
            } else {
                echo json_encode(["session" => $VARS['session_id'], "result" => false, "msg" => "Answer incorrect."]);
            }
        } else {
            echo json_encode(["session" => $VARS['session_id'], "result" => true]);
        }
        $database->update("sessions", ['expired' => 1], ["sid" => $sid]);
        exit();
    default:
        sendError("Bad Request", "client");
}