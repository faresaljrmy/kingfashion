<?php

include '../../connect.php';

$orderid = filterRequest("orderid");
$userid = filterRequest("userid");
$deliveryid = filterRequest("deliveryid");

$data = array(
    "orders_status" =>3,
    "orders_delivery" => $deliveryid
);

$count = updateData("orders",$data,"orders_id =$orderid AND orders_status = 2");
if($count > 0){
    insertNotifyandSend("إشعار","الطلب على الطريق",$userid,"user$userid","non","refreshorders");

    sendGCM("الطلب".$orderid,"تم الموافقة على الطلب من قبل عامل التوصيل" .$deliveryid ,"delivery", "none", "none");
    
    sendGCM("إشعار","تم الموافقة على الطلب من قبل عامل التوصيل" .$deliveryid ,"serveces", "none", "none");
}
    




