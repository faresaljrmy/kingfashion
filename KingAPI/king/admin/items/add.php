<?php

include '../../connect.php';

$name = filterRequest("name");
$namear = filterRequest("namear");
$descr = filterRequest("descr");
$descrar = filterRequest("descrar");
$price = filterRequest("price");
$descount = filterRequest("descount");
$catid = filterRequest("catid");
$userid = filterRequest("userid");
$image = imageUpload("../../upload/items","files");
$id = getMaxID("items","id");
$data = array(
    "id" => $id,
    "name" => $name,
    "name_ar" => $namear,
    "descr" => $descr,
    "descr_ar" => $descrar,
    "price" => $price,
    "descount" => $descount,
    "cat_id" => $catid,
    "usr_id" => $userid,
    "image" => $image

    );

$count = insertData("items", $data,false);
if ($count > 0) {
    echo json_encode(array("status" => "success","id" =>$id));
} else {
    echo json_encode(array("status" => "failure"));
}