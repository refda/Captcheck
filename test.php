<?php

header("Content-Type: text/plain");

var_dump($_POST);



$url = 'https://captcheck.netsyms.com/api.php';
$data = [
    'session_id' => $_POST['captcheck_session_code'],
    'answer_id' => $_POST['captcheck_selected_answer'],
    'action' => "verify"
];
$options = [
    'http' => [
        'header' => "Content-type: application/x-www-form-urlencoded\r\n",
        'method' => 'POST',
        'content' => http_build_query($data)
    ]
];
$context = stream_context_create($options);
$result = file_get_contents($url, false, $context);
$resp = json_decode($result, TRUE);
if (!$resp['result']) {
    exit("\n\nCAPTCHA did not verify:" . $resp['msg']);
} else {
    exit("\n\nCAPTCHA verified!");
}
