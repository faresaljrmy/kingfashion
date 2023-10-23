<?php

include '../connect.php';

$id = filterRequest("id");
$itmid = filterRequest("itmid");
$clrid = filterRequest("clrid");
$sizid = filterRequest("sizid");
$qty = filterRequest("qty");
$price = filterRequest("price");
$descount = filterRequest("descount");
$userid = filterRequest("userid");

if($id == 0){
   $hasCart = getMultiDataJson("SELECT cartclr.cart_id from  cartcolorsizes as cartclr,cart  
where cartclr.cart_id=cart.id and cartclr.itm_id=$itmid and cartclr.usr_id=$userid and cart.order_id=0 
and cart.status=0");
if($hasCart["count"] >0){
   $id = $hasCart["data"][0]["cart_id"];
}
}
$hasQty = 0;

/*
select itm.id as itm_id ,itm.name as itm_name,
siz.id as siz_id ,siz.name as siz_name, sum(crt.qty)
from cartsizes as crt,sizes as siz,items as itm 
where crt.size_id=siz.id and crt.itm_id=itm.id
GROUP BY size_id,itm_id

*/
if($hasQty != 0){

}else{
   // echo json_encode(array("id" => $id));
   if($id == null || $id == ""){
      $id = getMaxID("cart","id");
      // echo json_encode(array("id" => $id));
      $data = array(
         "id" => $id,
      "itm_id" => $itmid,
      "usr_id" => $userid,
      );
      
      $count = insertData("cart", $data,false);
     
   }
      $datacartcolorsize = getMultiDataJson("select id from cartcolorsizes where cart_id=$id and clr_id=$clrid and size_id=$sizid");  
      if($datacartcolorsize["status"] ==  "success"){
            $cartclrsizid = $datacartcolorsize["data"][0]["id"];
            
            $count =    updateData("cartcolorsizes",array("qty" => $qty)," cart_id=$id and clr_id=$clrid and size_id=$sizid",false);
       
      }else{
            // $idcolor = getMaxID("cartcolors","id");
            $data = array(
               "cart_id" => $id,
               "itm_id" => $itmid,
               "clr_id" => $clrid,
               "size_id" => $sizid,
               "qty" => $qty,
               "price" => $price,
               "descount" => $descount,
               "usr_id" => $userid
            );
          $count =  insertData("cartcolorsizes",$data,false);
   
      }
      if ($count > 0) {
         echo json_encode(array("status" => "success","id" => $id));
      } else {
         echo json_encode(array("status" => "failure"));
      }    
}
