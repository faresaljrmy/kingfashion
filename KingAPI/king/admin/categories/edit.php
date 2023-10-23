<?php

include '../../connect.php';

$id = filterRequest("id");
$name = filterRequest("name");
$namear = filterRequest("namear");
$userid = filterRequest("userid");
$image = imageUpload("../../upload/categories","files");

$imageold = filterRequest("imageold");

if($resulte == "empty"){
    $data = array(
        "name" => $name,
        "name_ar" => $namear,
        
        );
}else{
    deleteFile("../../upload/categories", $imageold);
    $data = array(
        "name" => $name,
        "name_ar" => $namear,
        "image" => $image,
        
        );
}


updateData("categories", $data, "id = $id");