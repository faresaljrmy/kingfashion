<?php

include '../../connect.php';

$name = filterRequest("name");
$namear = filterRequest("namear");
$userid = filterRequest("userid");
$image = imageUpload("../../upload/categories","files");

$data = array(
"name" => $name,
"name_ar" => $namear,
"image" => $image,
"usr_id" => $userid

);

insertData("categories", $data);