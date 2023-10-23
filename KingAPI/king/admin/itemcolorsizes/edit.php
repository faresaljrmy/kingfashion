<?php

include '../../connect.php';

$id = filterRequest("id");
$itmid = filterRequest("itmid");
$clrid = filterRequest("clrid");
$sizeid = filterRequest("sizeid");
$qty = filterRequest("qty");
$price = filterRequest("price");
$descount = filterRequest("descount");

$userid = filterRequest("userid");


$data = array(
    // "id" => $id,
    "itm_id" => $itmid,
    "clr_id" => $clrid,
    "size_id" => $sizeid,
    "qty" => $qty,
    "price" => $price,
    "descount" => $descount,
);



updateData("itemcolorsizes", $data, "id = $id");