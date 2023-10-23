<?php

include '../../connect.php';

$itmid = filterRequest("itmid");
$clrid = filterRequest("clrid");

$userid = filterRequest("userid");

$id = getMaxID("itemcolors","id");
$data = array(
    "id" => $id,
    "itm_id" => $itmid,
"clr_id" => $clrid,
"usr_id" => $userid,
);

$count = insertData("itemcolors", $data,false);
if ($count > 0) {
    echo json_encode(array("status" => "success","id" =>$id));
} else {
    echo json_encode(array("status" => "failure"));
}