<?php

include '../connect.php'; 

$catid = filterRequest("catid");

// getAllData("itmesview","categories_id = $catid");
$userid = filterRequest("userid");

$stmt = $con->prepare("SELECT itm.*,1 as isfav from viewitems as itm,favorite as fav 
where   fav.itm_id=itm.id and  fav.usr_id=$userid and itm.cat_id=$catid
union all 
select itm.*,0 as isfav from viewitems as itm where   
itm.id not in (select itms.id from viewitems as itms 
               INNER JOIN favorite as favo on favo.itm_id=itms.id and favo.usr_id=$userid)  and cat_id=$catid
");
 $stmt->execute();
 $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
 $count  = $stmt->rowCount();
 if($count > 0 ){
    for($i=0;$i<$count;$i++){
        $cartdata =  getOneDataJson("SELECT cart_id from viewcart where usr_id=$userid and itm_id=".$data[$i]["id"]);
        if($cartdata["count"] >0){
            $cartid = $cartdata["data"]["cart_id"];
        }else{
            $cartid="0";
        }
        $data[$i]["cartid"] = $cartid;
        $allimages =  getMultiDataJson("SELECT image_name from itemimages  where  itm_id=".$data[$i]["id"]);
     
        if($allimages["count"] > 0){
            $data[$i]["allimages"] = $allimages["data"];
        }else{
            $data[$i]["allimages"] = [];
        }
        }
    echo json_encode(array("status" => "success", "data" => $data));
 
} else {
    echo json_encode(array("status" => "failure"));
}


