<?php

include '../../connect.php';

$id        = filterRequest("id");
$image = filterRequest("image");

if(checkCategoriesHasRefernces($id) > 0){
    echo json_encode(array("status"=> "failure","message"=> "hasrefrences"));
}else{
    deleteFile("../../upload/categories",$image);
    deleteData("categories","id = $id");
}