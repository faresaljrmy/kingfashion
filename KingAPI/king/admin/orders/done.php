<?php

include '../../connect.php';

$orderid = filterRequest("orderid");
$userid = filterRequest("userid");
$ordertype = filterRequest("ordertype");

if($ordertype == "1"){
    $data = array(
        "orders_status" =>2
    );
}else{
    $data = array(
        "orders_status" =>4
    );
}


$count = updateData("orders",$data,"orders_id =$orderid AND orders_status = 1");

if($ordertype == "1"){
    insertNotifyandSend("Notification","Your order will be delivered to the delivery worker",$userid,"user$userid","non","refreshorders");
 
 }else{
    insertNotifyandSend("Notification","Thank you for using our app",$userid,"user$userid","non","refreshorders");

 }
    insertNotifyandSend("success","The order approved",$userid,"user$userid","non","refreshorders");

    if($ordertype == "1"){
       sendGCM("طلب رقم" . $orderid,"يوجد طلب بإنتظار الموافقة","delivery","none","none");  
    }

?>