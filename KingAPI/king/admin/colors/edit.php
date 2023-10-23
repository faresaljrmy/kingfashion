<?php

include '../../connect.php';

$id = filterRequest("id");
$name = filterRequest("name");
$namear = filterRequest("namear");
$rgb = filterRequest("rgb");
$userid = filterRequest("userid");


    $data = array(
        "name" => $name,
        "name_ar" => $namear,
        "rgb" => $rgb
        
        );



updateData("colors", $data, "id = $id");