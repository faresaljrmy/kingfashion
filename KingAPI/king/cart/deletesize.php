<?php

include '../connect.php';

$cartid = filterRequest("cartid");
$itmid = filterRequest("itmid");
$clrid = filterRequest("clrid");
$sizid = filterRequest("sizid");
$userid = filterRequest("userid");
$qty = filterRequest("qty");

if($qty > 0){
    updateData("cartcolorsizes",array("qty" => ($qty)),"cart_id=$cartid 
    and itm_id=$itmid and clr_id=$clrid and size_id=$sizid");
    // if ($count > 0) {
    //     echo json_encode(array("status" => "success","operation" => "editcart"));
    // } else {
    //     echo json_encode(array("status" => "failure"));
    // }
}else{
    $countsize = deleteData("cartcolorsizes","  cart_id=$cartid and itm_id=$itmid and clr_id=$clrid and size_id=$sizid",false);
    if($countsize > 0){
        $count = deleteData("cart"," id=$cartid and itm_id=$itmid and    (select countsize from viewcart where itm_id=$itmid and cart_id=$cartid) is null",false);
        if ($count > 0) {
            echo json_encode(array("status" => "success","operation" => "deletecart"));
        } else {
            echo json_encode(array("status" => "success"));
        }
    } else {
        echo json_encode(array("status" => "failure"));
    }
}

// $data = getMultiDataJson("SELECT clrsiz.id,clrsiz.qty from cartcolorsizes as clrsiz 
// where clrsiz.clr_id=$clrid and clrsiz.itm_id=$itmid and   clrsiz.cart_id=$cartid and  clrsiz.size_id=$sizid");

// if($data["status"] == "success" && $data["count"] > 0){
// //    echo json_encode($data["data"][0]["qty"]);
//     if($data["data"][0]["qty"] > 1){
//         updateData("cartcolorsizes",array("qty" => ($data["data"][0]["qty"] -1)),"cart_id=$cartid 
//         and itm_id=$itmid and clr_id=$clrid and size_id=$sizid");
//     }else{
//         deleteData("cartcolorsizes"," cart_id=$cartid and itm_id=$itmid and clr_id=$clrid and size_id=$sizid");

//     }
// }