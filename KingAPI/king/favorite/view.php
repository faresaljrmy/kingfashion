<?php
include '../connect.php';

$userid = filterRequest('userid');

getAllData('viewfavorite ','fav_usr_id = ?',array($userid));