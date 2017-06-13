<?php

/**
 * A simple script to scrape text CAPTCHAs from an online service.
 * 
 * Set your email address and the number of CAPTCHAs to download.
 * 
 * For security, this script will by default terminate itself, so comment out 
 * the die() command if you want to use it.
 */
die("Access denied.");


require __DIR__ . '/required.php';
header('Content-Type: text/plain');


$email = "changeme@example.com";
$rows = 20;
$url = "http://api.textcaptcha.com/$email.json";

for ($i = 0; $i < $rows; $i++) {
    $data = json_decode(file_get_contents($url), TRUE);
    $database->insert('access_questions', ["acqtext" => $data['q']]);
    $id = $database->id();
    foreach ($data['a'] as $a) {
        $database->insert('access_answers', ["acqid" => $id, "acahash" => $a]);
    }
    echo ".";
    ob_flush();
    sleep(1);
}
echo "\ndone\n";
