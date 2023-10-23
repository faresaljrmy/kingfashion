<?php

include '../connect.php';

$userid = filterRequest("userid");

getAllData("ordersview"," orders_userid = '$userid' AND orders_status = 4 ORDER BY orders_id DESC ");