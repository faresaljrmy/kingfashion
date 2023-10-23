<?php

include '../../connect.php';
$deliveryid = filterRequest("deliveryid");

getAllData("ordersview","orders_status = 4 AND orders_delivery = $deliveryid");

?>