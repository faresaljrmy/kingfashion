<?php

// include '../../connect.php';

// $id = filterRequest("id");
// $itmid = filterRequest("itmid");
// $clrid = filterRequest("clrid");
// $sizid = filterRequest("sizid");
// $qty = filterRequest("qty");
// $price = filterRequest("price");
// $descount = filterRequest("descount");
// $userid = filterRequest("userid");


//    if($id == null){
//       $id = getMaxID("cart","id");
//       $data = array(
//          "id" => $id,
//       "itm_id" => $itmid,
//       "usr_id" => $userid,
//       );
      
//       $count = insertData("cart", $data,false);
     
//    }
//       $datacartcolorsize = getDataJson("select id from cartcolorsizes where cart_id=$id and clr_id=$clrid and size_id=$sizid");  
//       if($datacartcolorsize["status"] ==  "success"){
//             $cartclrsizid = $datacartcolorsize["data"]["id"];
            
//                updateData("cartcolorsizes",array("qty" => $qty)," cart_id=$id and clr_id=$clrid and size_id=$sizid",false);
       
//       }else{
//             // $idcolor = getMaxID("cartcolors","id");
//             $data = array(
//                "cart_id" => $id,
//                "itm_id" => $itmid,
//                "clr_id" => $clrid,
//                "size_id" => $sizid,
//                "qty" => $qty,
//                "price" => $price,
//                "descount" => $descount,
//                "usr_id" => $userid
//             );
//             insertData("cartcolorsizes",$data,false);
   
//       }
//       if ($count > 0) {
//          echo json_encode(array("status" => "success","id" =>$id));
//       } else {
//          echo json_encode(array("status" => "failure"));
//       }    

