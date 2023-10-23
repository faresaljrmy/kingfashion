<?php

include '../../connect.php';

$id        = filterRequest("id");


deleteData("sizes","id = $id");