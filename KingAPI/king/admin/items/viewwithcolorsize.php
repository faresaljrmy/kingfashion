<?php
include '../../connect.php';


// $data = getAllData('viewcart',"usr_id = $userid" ,null ,false);
$stmt = $con->prepare("SELECT items.*,cat.name as cat_name,cat.name_ar as cat_name_ar 
from items,categories as cat  
where items.cat_id=cat.id
");

$stmt->execute();
$dataitem = $stmt->fetchAll(PDO::FETCH_ASSOC);
$countitem  = $stmt->rowCount();

for($i=0;$i<$countitem;$i++){
    $allimages =  getMultiDataJson("SELECT image_name from itemimages where itm_id=".$dataitem[$i]["id"]);
    if($allimages["count"] > 0){
        $dataitem[$i]["allimages"] = $allimages["data"];
    }else{
        $dataitem[$i]["allimages"] = [];
    }
        $stmt = $con->prepare("SELECT itemclr.itm_id,itemclr.clr_id as id,clr.name,clr.name_ar,clr.rgb ,itemclr.date,itemclr.usr_id
    from colors as clr,itemcolorsizes as itemclr 
    where itemclr.clr_id=clr.id and itemclr.itm_id=".$dataitem[$i]["id"]." 
    AND itemclr.itm_id=".$dataitem[$i]["id"]." 
     GROUP BY itemclr.clr_id");

    $stmt->execute();
    $datacolor = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $countcolor  = $stmt->rowCount();
    $dataitem[$i]["colors"] = $datacolor;


    for($j=0;$j<$countcolor;$j++){

            $stmt = $con->prepare("SELECT itemsiz.id,itemsiz.itm_id,itemsiz.clr_id,itemsiz.size_id as size_id,siz.name,siz.name_ar,
            siz.symbol,itemsiz.qty,itemsiz.price,itemsiz.descount,itemsiz.date,itemsiz.usr_id
            from sizes as siz,itemcolorsizes as itemsiz
            where itemsiz.size_id=siz.id and itemsiz.itm_id=".$dataitem[$i]["id"]." 
            and itemsiz.itm_id=".$dataitem[$i]["id"]." 
            and itemsiz.clr_id=".$datacolor[$j]["id"]."  GROUP BY itemsiz.size_id");

        $stmt->execute();
        $datasize = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $countsize  = $stmt->rowCount();
        $dataitem[$i]["colors"][$j]["sizes"] = $datasize;

    }
}





if( $dataitem != null){
    echo json_encode(array(
        "status" => "success", 
        "data" => $dataitem,
        
    ));
}else{
    echo json_encode(array("status" => "failure"));
}







