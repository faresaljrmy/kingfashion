<?php

include '../connect.php';

$orderid = filterRequest("orderid");

getAllData("ordersdetalisview","cart_orders = $orderid");