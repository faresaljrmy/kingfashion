<?php

include '../../connect.php';

$id        = filterRequest("id");
$imagename = filterRequest("imagename");
$userid = filterRequest("userid");


if(checkItemsHasRefernces($id) > 0){
    echo json_encode(array("status"=> "failure","message"=> "hasrefrences"));
}else{
    deleteFile("../../upload/items",$imagename);
    deleteData("items","id = $id");

}