<?php

// Whether to show debugging data in output.
// DO NOT SET TO TRUE IN PRODUCTION!!!
define("DEBUG", false);

// Database connection settings
// See http://medoo.in/api/new for info
define("DB_TYPE", "mysql");
define("DB_NAME", "captcheck");
define("DB_SERVER", "localhost");
define("DB_USER", "");
define("DB_PASS", "");
define("DB_CHARSET", "utf8");

// Sessions more than this many minutes old will be automatically deleted.
define("SESSION_EXPIRE_MINUTES", 30);