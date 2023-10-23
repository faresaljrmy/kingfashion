<?php

include '../../connect.php';

$name = filterRequest("name");
$namear = filterRequest("namear");
$symbol = filterRequest("symbol");
$userid = filterRequest("userid");

$data = array(
"name" => $name,
"name_ar" => $namear,
"symbol" => $symbol,
"usr_id" => $userid

);

insertData("sizes", $data);