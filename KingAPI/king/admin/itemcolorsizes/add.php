<?php

include '../../connect.php';
$itmid = filterRequest("itmid");
$clrid = filterRequest("clrid");
$sizeid = filterRequest("sizeid");
$qty = filterRequest("qty");
$price = filterRequest("price");
$descount = filterRequest("descount");

$userid = filterRequest("userid");

$id = getMaxID("itemcolorsizes","id");
$data = array(
    "itm_id" => $itmid,
    "clr_id" => $clrid,
    "size_id" => $sizeid,
    "qty" => $qty,
    "price" => $price,
    "descount" => $descount,
    "usr_id" => $userid,
);

$count = insertData("itemcolorsizes", $data,false);
if ($count > 0) {
    echo json_encode(array("status" => "success","id" =>$id));
} else {
    echo json_encode(array("status" => "failure"));
}