<?php

include '../../connect.php';

$name = filterRequest("name");
$namear = filterRequest("namear");
$rgb = filterRequest("rgb");
$userid = filterRequest("userid");

$data = array(
"name" => $name,
"name_ar" => $namear,
"rgb" => $rgb,
"usr_id" => $userid

);

insertData("colors", $data);