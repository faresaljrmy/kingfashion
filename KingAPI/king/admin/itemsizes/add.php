<?php

include '../../connect.php';

$itmclrid = filterRequest("itmclrid");
$sizeid = filterRequest("sizeid");
$qty = filterRequest("qty");
$price = filterRequest("price");
$descount = filterRequest("descount");

$userid = filterRequest("userid");

$id = getMaxID("itemsizes","id");
$data = array(
    "id" => $id,
    "itm_clr_id" => $itmclrid,
"size_id" => $sizeid,
"qty" => $qty,
"price" => $price,
"descount" => $descount,

"usr_id" => $userid,
);

$count = insertData("itemsizes", $data,false);
if ($count > 0) {
    echo json_encode(array("status" => "success","id" =>$id));
} else {
    echo json_encode(array("status" => "failure"));
}