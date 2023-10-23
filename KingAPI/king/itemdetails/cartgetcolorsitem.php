<?php

include '../connect.php'; 

$itmid = filterRequest("itmid");

// getAllData("itmesview","categories_id = $catid");
// $userid = filterRequest("userid");

$stmt = $con->prepare("SELECT itm.clr_id as id  ,clr.name ,clr.name_ar,clr.rgb,count(itm.size_id) as countsizes 
FROM colors as clr,itemcolorsizes as itm 
WHERE clr.id=itm.clr_id and itm.itm_id=$itmid GROUP BY itm.clr_id
");
 $stmt->execute();
 $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
 $count  = $stmt->rowCount();

 for( $i=0;$i < $count;$i++){
    $color = $data[$i];
    $dataSizes = getMultiDataJson("
    SELECT itm.size_id as id,siz.name,
    siz.name_ar,siz.symbol,itm.qty,itm.price,itm.descount,sum(cartclr.qty) as qty_cart 
    FROM sizes as siz,itemcolorsizes as itm,cartcolorsizes as cartclr 
    WHERE siz.id=cartclr.size_id and cartclr.clr_id=1 and cartclr.itm_id=1 and siz.id=itm.size_id and 
    itm.itm_id=1 and itm.clr_id=1 and cartclr.usr_id=3 
    and itm.size_id in 
    (select cartsiz.size_id from cartcolorsizes as cartsiz,cart where cartsiz.usr_id=3 and cartsiz.clr_id=1 
    and cartsiz.itm_id=1 and cartsiz.cart_id=cart.id and cart.order_id=0 and cart.status=0) 
    GROUP BY cartclr.size_id,itm.size_id
    union all 
    SELECT itm.size_id as id,siz.name,
    siz.name_ar,siz.symbol,itm.qty,itm.price,itm.descount,0 as qty_cart 
    FROM sizes as siz,itemcolorsizes as itm 
    WHERE siz.id=itm.size_id and itm.itm_id=1 and itm.clr_id=1 
    and itm.size_id not in (select cartsiz.size_id from cartcolorsizes as cartsiz,cart where cartsiz.usr_id=3 
    and cartsiz.clr_id=1 and cartsiz.itm_id=1 and cartsiz.cart_id=cart.id and cart.order_id=0 and cart.status=0) 
    GROUP BY itm.size_id    "
    //     "SELECT itm.size_id as id,siz.name,
    // siz.name_ar,siz.symbol,itm.qty,itm.price,itm.descount 
    // FROM sizes as siz,itemcolorsizes as itm 
    // WHERE siz.id=itm.size_id and itm.itm_id=$itmid and itm.clr_id=".$color["id"]." GROUP BY itm.size_id    "
);
    // echo json_encode(array("data" => $color["id"],"itm" => $itmid ));
    $data[$i]["sizes"] = $dataSizes["data"];
 }
 if($count > 0 ){
    echo json_encode(array("status" => "success", "data" => $data));
 
} else {
    echo json_encode(array("status" => "failure"));
}



/*

SELECT itm.size_id as id,siz.name,
    siz.name_ar,siz.symbol,itm.qty,itm.price,itm.descount,sum(cartclr.qty) as qty_cart 
    FROM sizes as siz,itemcolorsizes as itm,cartcolorsizes as cartclr 
    WHERE siz.id=cartclr.size_id and cartclr.clr_id=1 and cartclr.itm_id=1 and siz.id=itm.size_id and itm.itm_id=1 and itm.clr_id=1 and cartclr.usr_id=3 
    and itm.size_id in (select cartsiz.size_id from cartcolorsizes as cartsiz where cartsiz.usr_id=3 and cartsiz.clr_id=1 and cartsiz.itm_id=1) 
    GROUP BY cartclr.size_id,itm.size_id
    
union all 
SELECT itm.size_id as id,siz.name,
    siz.name_ar,siz.symbol,itm.qty,itm.price,itm.descount,0 as qty_cart 
    FROM sizes as siz,itemcolorsizes as itm 
    WHERE siz.id=itm.size_id and itm.itm_id=1 and itm.clr_id=1 
    and itm.size_id not in (select cartsiz.size_id from cartcolorsizes as cartsiz where cartsiz.usr_id=3 and cartsiz.clr_id=1 and cartsiz.itm_id=1) 
    GROUP BY itm.size_id
   

*/
