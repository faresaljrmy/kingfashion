<?php
include '../connect.php';
$userid = filterRequest("userid");

getAllData("address", "usr_id = $userid");