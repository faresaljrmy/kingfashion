<?php

include '../../connect.php';

$itmid        = filterRequest("itmid");
$clrid        = filterRequest("clrid");
$sizeid        = filterRequest("sizeid");
$userid = filterRequest("userid");

$count = checkItemColorSizesHasRefernces($itmid,$clrid,$sizeid);
if($count > 0){
    echo json_encode(array("status" => "failure","message"=>"hasrefrences"));
}else{
    deleteData("itemcolorsizes"," itm_id = $itmid and clr_id =$clrid and size_id=$sizeid");

}

