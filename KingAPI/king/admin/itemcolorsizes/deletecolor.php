<?php

include '../../connect.php';

$itmid        = filterRequest("itmid");
$clrid        = filterRequest("clrid");
$userid = filterRequest("userid");

$count = checkItemColorHasRefernces($itmid,$clrid);
if($count > 0){
    echo json_encode(array("status" => "failure","message"=>"hasrefrences"));
}else{
    deleteData("itemcolorsizes"," itm_id = $itmid and clr_id =$clrid");
}
