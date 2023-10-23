<?php
include '../connect.php';


$userid            =filterRequest("userid");
$addressid          =filterRequest("addressid");
$ordertype          =filterRequest("ordertype");
$pricedelivery      =filterRequest("pricedelivery");
$ordercuoponid      =filterRequest("cuoponid");
$cuopondiscuont     =filterRequest("cuopondiscuont");
$orderprice         =filterRequest("orderprice");
$orderpaymentmethod =filterRequest("orderpaymentmethod");

if($ordertype == "0"){
    $pricedelivery = 0; 
}

  $totleprice =$orderprice + $pricedelivery;
//cheack coupon
$now = date("Y-m-d H:i:s");

$cheackcoupon =getData("coupon","coupon_id = '$ordercuoponid' AND coupon_expiredate > '$now' AND 	coupon_count > 0",null,false);
if($cheackcoupon >0){
 $totleprice = $totleprice - $orderprice*$cuopondiscuont/100;
 $stmt = $con-> prepare(" UPDATE `coupon` SET `coupon_count`= `coupon_count` -1 WHERE `coupon_id` = '$ordercuoponid' ");
 $stmt->execute();
}
$data = array(
    "orders_userid"       => $userid,
    "orders_addressid"     => $addressid,
    "orders_type"          => $ordertype,
    "orders_pricedelivery" => $pricedelivery,
    "orders_cuopon"        => $ordercuoponid,
    "orders_price"         => $orderprice,
    "orders_totleprice"    => $totleprice,
    "orders_paymentmethod" => $orderpaymentmethod,
);

$count = insertData("orders",$data,false);

if($count >0){
    $stmt = $con->prepare("SELECT MAX(orders_id) FROM orders");
    $stmt->execute();
    $max = $stmt->fetchColumn();

    $ordercuont = array("cart_orders" =>$max);

    updateData("cart",$ordercuont, "cart_userid = $userid AND cart_orders = 0");
}