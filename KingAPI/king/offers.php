<?php

include './connect.php';

$userid = filterRequest('userid');

$stmt = $con->prepare("SELECT itmesview.* ,1 AS favorit,(itmes_price - (itmes_price * itmes_discount/100)) AS itmespricediscount FROM itmesview 
INNER JOIN favorite ON favorite.favorite_userid = $userid AND favorite.favorite_itmesid= itmesview.itmes_id
WHERE itmes_discount != 0
UNION ALL
SELECT * ,0 AS favorit ,(itmes_price - (itmes_price * itmes_discount/100)) AS itmespricediscount FROM itmesview 
WHERE itmes_discount != 0 AND itmes_id NOT IN (SELECT itmesview.itmes_id FROM itmesview 
INNER JOIN favorite ON favorite.favorite_userid = $userid AND favorite.favorite_itmesid= itmesview.itmes_id)");
 $stmt->execute();
 $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
 $count  = $stmt->rowCount();
 if($count > 0 ){
    echo json_encode(array("status" => "success", "data" => $data));
 
} else {
    echo json_encode(array("status" => "failure"));
}
?>