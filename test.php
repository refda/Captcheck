<?php

header("Content-Type: text/plain");

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

echo "Form fields:\n";
var_export($_POST);
echo "\n\nAPI request fields:\n";
var_export($data);
echo "\n\nAPI response (JSON):\n";
echo json_encode(json_decode($result, TRUE), JSON_PRETTY_PRINT);

if (!$resp['result']) {
    exit("\n\nCAPTCHA did not verify: " . $resp['msg']);
} else {
    exit("\n\nCAPTCHA verified!");
}
