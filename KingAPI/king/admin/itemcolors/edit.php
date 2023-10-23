<?php

include '../../connect.php';

$id = filterRequest("id");
$itmid = filterRequest("itmid");
$clrid = filterRequest("clrid");

$userid = filterRequest("userid");


$data = array(
    "itm_id" => $itmid,
    "clr_id" => $clrid,
    );



updateData("itemcolors", $data, "id = $id");