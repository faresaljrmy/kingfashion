<?php
include 'connect.php';

$alldata = array();

$alldata['status'] = "success" ;
$categories = getAllData("categories", null , null,false);
$alldata['categories'] = $categories;

$itmes = getAllData("viewitems", "1 = 1 " , null, false);

$alldata['items'] = $itmes;

// $settingtxt = getAllData("settingstxt","1 = 1",null,false);
// $alldata['settingtxt'] = $settingtxt;
echo json_encode($alldata);





