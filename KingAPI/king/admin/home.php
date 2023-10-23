<?php

include '../connect.php';

// getAllData("viewitems",null,null,);
$data = array();
$data["items"] = getMultiDataJson("SELECT * from viewitems");
$data["categories"] = getMultiDataJson("SELECT * from categories");

    echo json_encode(array("status"=>"success","data"=>$data));
?>