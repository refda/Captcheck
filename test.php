<?php

//header("Content-Type: application/json");
header("Content-Type: text/plain");

echo json_encode(["get" => $_GET, "api" => json_decode(file_get_contents("http://localhost/captcheck/api.php?action=verify&session_id=" . $_GET["captcheck_session_code"] . "&answer_id=".$_GET["captcheck_selected_answer"]), true)]);