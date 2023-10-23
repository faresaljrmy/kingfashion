<?php

include '../../connect.php';

$id = filterRequest("id");
$name = filterRequest("name");
$namear = filterRequest("namear");
$descr = filterRequest("descr");
$descrar = filterRequest("descrar");
$price = filterRequest("price");
$descount = filterRequest("descount");
$catid = filterRequest("catid");
$active = filterRequest("active");
$userid = filterRequest("userid");
$image = imageUpload("../../upload/items","files");
$imageold = filterRequest("imageold");



if($image == "empty"){
    $data = array(
        "name" => $name,
        "name_ar" => $namear,
        "descr" => $descr,
        "descr_ar" => $descrar,
        "price" => $price,
        "descount" => $descount,
        "catid" => $catid,
        "active"=> $active,
        "usr_id" => $userid,
        "image" => $imageold
        
        );   
        
}else{
    deleteFile("../../upload/items", $imageold);
    $data = array(
        "name" => $name,
        "name_ar" => $namear,
        "descr" => $descr,
        "descr_ar" => $descrar,
        "price" => $price,
        "descount" => $descount,
        "catid" => $catid,
        "active"=> $active,
        "usr_id" => $userid,
        "image" => $image
        
        );
}


updateData("items", $data, "id = $id");