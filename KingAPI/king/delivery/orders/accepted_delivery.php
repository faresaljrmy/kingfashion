<?php

include '../../connect.php';
$deliveryid = filterRequest("deliveryid");

getAllData("ordersview","orders_status = 3 AND orders_delivery = $deliveryid");

?>