
<?php

include '../connect.php';

$id = filterRequest("id");
$itmid = filterRequest("itmid");
$clrid = filterRequest("clrid");
$sizid = filterRequest("sizid");
$userid = filterRequest("userid");

   $data = getMultiDataJson("SELECT clrsiz.id from cart,cartcolorsizes as clrsiz 
   where clrsiz.cart_id=cart.id and  cart.id=$id and cart.status=1");

    if($data["status"] == "success"){
        deleteData("cartcolorsizes"," cart_id=$id");
    }else{
        deleteData("cart","cart.order_id=0 and cart.status=1 and id=$id");

    }
