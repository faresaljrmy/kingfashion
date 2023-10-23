<?php

include '../../connect.php';

$id        = filterRequest("id");
$userid = filterRequest("userid");

deleteData("itemsizes","id = $id");