<?php

include '../../connect.php';

$id        = filterRequest("id");


deleteData("colors","id = $id");