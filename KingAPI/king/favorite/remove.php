<?php

include '../connect.php';

$userid = filterRequest('userid');
$itemid = filterRequest('itemid');

deleteData("favorite", "usr_id = $userid AND itm_id = $itemid");