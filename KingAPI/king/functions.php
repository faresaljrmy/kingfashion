<?php

// ==========================================================
//  Copyright Reserved Wael Wael Abo Hamza (Course Ecommerce)
// ==========================================================

define("MB", 1048576);

function filterRequest($requestname)
{
    return  htmlspecialchars(strip_tags($_POST[$requestname]));
}

function getAllData($table, $where = null, $values = null, $json = true)
{
    global $con;
    $data = array();
    if ($where == null) {
        $stmt = $con->prepare("SELECT  * FROM $table   ");
    } else {
        $stmt = $con->prepare("SELECT  * FROM $table WHERE   $where ");
    }
    $stmt->execute($values);
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success", "data" => $data));
        } else {
            echo json_encode(array("status" => "failure"));
        }
        return $count;
    } else {
        if ($count > 0) {
            return  $data;
        } else {
            return  json_encode(array("status" => "failure"));;
        }
    }
}

function getData($table, $where = null, $values = null, $json = true)   
{
    global $con;
    $data = array();
    $stmt = $con->prepare("SELECT  * FROM $table WHERE   $where ");
    $stmt->execute($values);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success", "data" => $data));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    } else {
        return $count;
    }
}

function getMultiDataJson( $query )
{
    global $con;
    $data = array();
    $stmt = $con->prepare($query);
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
   
        if ($count > 0) {
           return array("status" => "success", "data" => $data,"count" => $count);
        } else {
            return array("status" => "failure","count" => $count);
        }
   
}
function getOneDataJson( $query )
{
    global $con;
    $data = array();
    $stmt = $con->prepare($query);
    $stmt->execute();
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();
   
        if ($count > 0) {
           return array("status" => "success", "data" => $data,"count" => $count);
        } else {
            return array("status" => "failure","count" => $count);
        }
   
}
function getMaxID( $table,$column )
{
    $dataaccid = getOneDataJson("select max($column)+1  as id from $table ");
    if($dataaccid["status"]=="success"){
    // echo json_encode( $dataaccid);
    if($dataaccid["data"]["id"] == null){
        $newaccid = "1";
    }else{
        $newaccid = $dataaccid["data"]["id"];
    }
    return $newaccid;
}   
}


function checkItemsHasRefernces($itmid){
    global $con;
  
    $stmt = $con->prepare("
    SELECT  itm_id from itemcolorsizes where itm_id=$itmid
    union all 
    SELECT  itm_id FROM cart where itm_id=$itmid
    union all 
    SELECT  itm_id FROM cartcolorsizes  where itm_id=$itmid
    union all 
    SELECT  itm_id FROM salesback  where itm_id=$itmid
    union all 
    SELECT  itm_id FROM salesbackcolorsizes  where itm_id=$itmid
    union all 
    SELECT  itm_id FROM  favorite  where itm_id=$itmid
    ");
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();

    return $count;

    
}

function checkCategoriesHasRefernces($catid){
    global $con;
  
    $stmt = $con->prepare("
    SELECT  cat_id from items where cat_id=$catid
    
    ");
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();

    return $count;

    
}
function checkItemColorHasRefernces($itmid,$clrid){
    global $con;
  
    $stmt = $con->prepare("
    SELECT  itm_id FROM cartcolorsizes  where itm_id=$itmid and clr_id=$clrid
    union all 
    SELECT  itm_id FROM salesbackcolorsizes  where itm_id=$itmid and clr_id=$clrid
    ");
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();

    return $count;

    
}
function checkItemColorSizesHasRefernces($itmid,$clrid,$sizid){
    global $con;
  
    $stmt = $con->prepare("
    SELECT  itm_id FROM cartcolorsizes  where itm_id=$itmid and clr_id=$clrid and size_id=$sizid
    union all 
    SELECT  itm_id FROM salesbackcolorsizes  where itm_id=$itmid and clr_id=$clrid and size_id=$sizid
    ");
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count  = $stmt->rowCount();

    return $count;

    
}

function insertData($table, $data, $json = true)
{
    global $con;
    foreach ($data as $field => $v)
        $ins[] = ':' . $field;
    $ins = implode(',', $ins);
    $fields = implode(',', array_keys($data));
    $sql = "INSERT INTO $table ($fields) VALUES ($ins)";

    $stmt = $con->prepare($sql);
    foreach ($data as $f => $v) {
        $stmt->bindValue(':' . $f, $v);
    }
    $stmt->execute();
    $count = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $count;
}


function updateData($table, $data, $where, $json = true)
{
    global $con;
    $cols = array();
    $vals = array();

    foreach ($data as $key => $val) {
        $vals[] = "$val";
        $cols[] = "`$key` =  ? ";
    }
    $sql = "UPDATE $table SET " . implode(', ', $cols) . " WHERE $where";

    $stmt = $con->prepare($sql);
    $stmt->execute($vals);
    $count = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $count;
}

function deleteData($table, $where, $json = true)
{
    global $con;
    $stmt = $con->prepare("DELETE FROM $table WHERE $where");
    $stmt->execute();
    $count = $stmt->rowCount();
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success"));
        } else {
            echo json_encode(array("status" => "failure"));
        }
    }
    return $count;
}

function imageUpload($dir,$imageRequest)
{
    global $msgError;
    if(isset($_FILES[$imageRequest])){
        $imagename  = rand(1000, 10000) . $_FILES[$imageRequest]['name'];
        $imagetmp   = $_FILES[$imageRequest]['tmp_name'];
        $imagesize  = $_FILES[$imageRequest]['size'];
        $allowExt   = array("jpg", "png", "gif", "mp3", "pdf","svg");
        $strToArray = explode(".", $imagename);
        $ext        = end($strToArray);
        $ext        = strtolower($ext);
    
        if (!empty($imagename) && !in_array($ext, $allowExt)) {
            $msgError = "EXT";
        }
        if ($imagesize > 2 * MB) {
            $msgError = "size";
        }
        if (empty($msgError)) {
            move_uploaded_file($imagetmp,$dir . "/" . $imagename);
            return $imagename;
        } else {
            return "fail";
        }
    }else{
        return "empty";
    }
    
}



function deleteFile($dir, $imagename)
{
    if (file_exists($dir . "/" . $imagename)) {
        unlink($dir . "/" . $imagename);
    }
}

function checkAuthenticate()
{
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
        if ($_SERVER['PHP_AUTH_USER'] != "fares" ||  $_SERVER['PHP_AUTH_PW'] != "faresking") {
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }

    // End 
}


function   printFailure($message = "none")
{
    echo     json_encode(array("status" => "failure", "message" => $message));
}
function   printSuccess($message = "none")
{
    echo     json_encode(array("status" => "success", "message" => $message));
}

function result($count)
{
    if ($count > 0) {
        printSuccess();
    } else {
        printFailure();
    }
}

function sendEmail($to, $title, $body)
{
    $header = "From: support@waelabohamza.com " . "\n" . "CC: waeleagle1243@gmail.com";
    mail($to, $title, $body, $header);
}


function sendGCM($title ,$message ,$topic,$pageid, $pagename){

    $url = 'https://fcm.googleapis.com/fcm/send';

    $fields = array(
        "to" => '/topics/'. $topic,
        "priority" => 'high',
        "content_available" => true,
        'notification' => array(
         "body" =>$message,
         "title" => $title,
        "click_action" => "FLUTTER_NOTIFICATION_CLICK",
        "sound" => "default"
        ),

        'data' => array(
            "pageid" =>$pageid,
            "pagename" =>$pagename
        )
        
    );

    $fields = json_encode($fields);

    $headers = array(
        'Authorization: key=' . "AAAAVDvqlfU:APA91bEnwio9Aszi5M7y1HVdYRWK5FbuISkHuxcIlCUjTgguCDuakkFt9VRtoVSooYXd33Dx1Iarst1Uk6YuDuiHW0k91ZhPkh_MwEW7hTFLPhQB3tILFrImiPnOUcZ7-_Vb0nQ3fYcV",
        'Content-Type: application/json'

    );

    $ch = curl_init();
    curl_setopt($ch,CURLOPT_URL,$url);
    curl_setopt($ch,CURLOPT_POST,true);
    curl_setopt($ch,CURLOPT_HTTPHEADER,$headers);
    curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
    curl_setopt($ch,CURLOPT_POSTFIELDS,$fields);

    $result = curl_exec($ch);
    return $result;
    curl_close($ch);


}


function insertNotifyandSend($title,$body,$userid,$topic,$pageid,$pagename){

    global $con;

    $stmt = $con->prepare("INSERT INTO `notification`( `notification_title`, `notification_body`, `notification_userid`) VALUES (?,?,?)");
     $stmt->execute(array($title,$body,$userid));
     sendGCM($title,$body,$topic,$pageid,$pagename);

    $count = $stmt->rowCount();

    return $count;
}