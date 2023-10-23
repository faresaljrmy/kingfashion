<?php

include '../connect.php';

$orderid = filterRequest('orderid');
$orderrating = filterRequest('orderrating');
$ordercoment = filterRequest('ordercoment');

$data = array(
    'orders_rating' => $orderrating,
    'orders_coment' => $ordercoment 
);

updateData("orders",$data,"orders_id = $orderid");