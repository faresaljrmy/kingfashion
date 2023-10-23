<?php
include '../connect.php';
$userid = filterRequest('userid');


// $data = getAllData('viewcart',"usr_id = $userid" ,null ,false);
$stmt = $con->prepare("SELECT * from viewcart where usr_id=$userid");

$stmt->execute();
$datacart = $stmt->fetchAll(PDO::FETCH_ASSOC);
$countcart  = $stmt->rowCount();

for($i=0;$i<$countcart;$i++){
    $allimages =  getMultiDataJson("SELECT image_name from itemimages where itm_id=".$datacart[$i]["itm_id"]);
    if($allimages["count"] > 0){
        $datacart[$i]["allimages"] = $allimages["data"];
    }else{
        $datacart[$i]["allimages"] = [];
    }
        $stmt = $con->prepare("SELECT cartclr.cart_id,cartclr.clr_id as id,clr.name,clr.name_ar,clr.rgb 
    from colors as clr,cartcolorsizes as cartclr 
    where cartclr.clr_id=clr.id and cartclr.cart_id=".$datacart[$i]["cart_id"]." 
    AND cartclr.itm_id=".$datacart[$i]["itm_id"]." 
    and cartclr.usr_id=$userid GROUP BY cartclr.clr_id");

    $stmt->execute();
    $datacolor = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $countcolor  = $stmt->rowCount();
    $datacart[$i]["colors"] = $datacolor;


    for($j=0;$j<$countcolor;$j++){

            $stmt = $con->prepare("SELECT cartsiz.cart_id,cartsiz.clr_id,cartsiz.size_id,siz.name,siz.name_ar,
            siz.symbol,cartsiz.qty,cartsiz.price,cartsiz.descount,cartsiz.date,cartsiz.usr_id
            from sizes as siz,cartcolorsizes as cartsiz
            where cartsiz.size_id=siz.id and cartsiz.cart_id=".$datacart[$i]["cart_id"]." 
            and cartsiz.itm_id=".$datacart[$i]["itm_id"]." and cartsiz.usr_id=$userid
            and cartsiz.clr_id=".$datacolor[$j]["id"]."  GROUP BY cartsiz.size_id");

        $stmt->execute();
        $datasize = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $countsize  = $stmt->rowCount();
        $datacart[$i]["colors"][$j]["sizes"] = $datasize;

    }
}
if($countcart > 0){
    $total = getOneDataJson("SELECT sum(totalprice) as totalprice from viewcart where usr_id=$userid group by usr_id");
    if($total["count"] > 0){
        $totalcart = $total["data"]["totalprice"];
    }
}else{
    $totalcart = 0;
}




if( $datacart != null){
    echo json_encode(array(
        "status" => "success", 
        "datacart" => $datacart,
        "totalcart" => $totalcart
    ));
}else{
    echo json_encode(array("status" => "failure"));
}







