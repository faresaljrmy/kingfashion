<?php

include '../../connect.php';

$orderid = filterRequest("orderid");
$userid = filterRequest("userid");


$data = array(
    "orders_status" =>4,
    
);

$count = updateData("orders",$data,"orders_id =$orderid AND orders_status = 3");

    insertNotifyandSend("إشعار","تم توصيل الطلب",$userid,"user$userid","non","refreshorders");

    sendGCM("إشعار","تم توصيل الطلب للعميل".$userid,"servoces", "none", "none");




?>