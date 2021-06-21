<?php

/**
 * This file contains global settings and utility functions.
 */
ob_start(); // allow sending headers after content
//
// Unicode, solves almost all stupid encoding problems
header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');
header('Access-Control-Allow-Origin: *');


$session_length = (60 * 60) * 8; // 1 hour x 8 = 8 hours
session_set_cookie_params($session_length, "/", null, false, true);

session_start(); // stick some cookies in it
// renew session cookie
setcookie(session_name(), session_id(), time() + $session_length);

// Composer
// require __DIR__ . '/vendor/autoload.php';
require __DIR__ . '/medoo.php';

require __DIR__ . '/settings.php';

/**
 * Kill off the running process and spit out an error message
 * @param string $error error message
 * @param string $fault who's fault the error is: "server" (default) or "client".
 */
function sendError($error, $fault = "server") {
    if ($fault == "server") {
        header('HTTP/1.1 500 Internal Server Error');
        $code = 500;
    } else {
        header('HTTP/1.1 400 Bad Request');
        $code = 400;
    }
    die(json_encode(["error" => $error, "code" => $code]));
}

// Database settings
// Also inits database and stuff
use Medoo\Medoo;

$database;
try {
    $database = new Medoo([
        'database_type' => DB_TYPE,
        'database_name' => DB_NAME,
        'server' => DB_SERVER,
        'username' => DB_USER,
        'password' => DB_PASS,
        'charset' => DB_CHARSET
    ]);
} catch (Exception $ex) {
    sendError("Database error.  Try again later.");
}


if (!DEBUG) {
    error_reporting(0);
} else {
    error_reporting(E_ALL);
    ini_set('display_errors', 'On');
}


$VARS;
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $VARS = $_POST;
    define("GET", false);
} else {
    $VARS = $_GET;
    define("GET", true);
}

/**
 * Checks if a string or whatever is empty.
 * @param $str The thingy to check
 * @return boolean True if it's empty or whatever.
 */
function is_empty($str) {
    return (is_null($str) || !isset($str) || $str == '');
}


/**
 * Attempts to discover the user's IP address.
 * @return string IP string or "NOT FOUND".
 */
function getUserIP() {
    $ip = "";
    if (isset($_SERVER["HTTP_CF_CONNECTING_IP"])) {
        $ip = $_SERVER["HTTP_CF_CONNECTING_IP"];
    } else if (isset($_SERVER["HTTP_CLIENT_IP"])) {
        $ip = $_SERVER["HTTP_CLIENT_IP"];
    } else if (isset($_SERVER["HTTP_X_FORWARDED_FOR"])) {
        $ip = $_SERVER["HTTP_X_FORWARDED_FOR"];
    } else if (isset($_SERVER["HTTP_X_FORWARDED"])) {
        $ip = $_SERVER["HTTP_X_FORWARDED"];
    } else if (isset($_SERVER["HTTP_FORWARDED_FOR"])) {
        $ip = $_SERVER["HTTP_FORWARDED_FOR"];
    } else if (isset($_SERVER["HTTP_FORWARDED"])) {
        $ip = $_SERVER["HTTP_FORWARDED"];
    } else if (isset($_SERVER["REMOTE_ADDR"])) {
        $ip = $_SERVER["REMOTE_ADDR"];
    } else {
        $ip = "NOT FOUND";
    }
    return $ip;
}
