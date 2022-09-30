<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/29
 * Time: 4:23 PM
 */


require_once '../includes/PdoConnect.php';

$response = array();

if($_SERVER['REQUEST_METHOD']=='POST') {

    $userId = $_POST['userId'];
    $latitude = $_POST['latitude'];
    $longitude = $_POST['longitude'];
    $historyName = $_POST['historyName'];
    $historyAddress = $_POST['historyAddress'];


    if ($userId != null && $latitude !=null && $longitude != null && $historyName != null && $historyAddress != null)  {

        $sql = "INSERT INTO histories (user_id, latitude, longitude, history_name, history_address) VALUES ('$userId', '$latitude', '$longitude', '$historyName', '$historyAddress')";

        $db = new PdoConnect();
        $pdo = $db->pdo();

        $query = "set names utf8";
        $pdo->query($query);

        $result = $pdo->query($sql);

        if ($result->rowCount() > 0) {

            $response['isSuccess'] = true;
            $response['message']='历史足迹添加成功';

        } else {

            $response['isSuccess'] = false;
            $response['message']='历史足迹添加失败';
        }

    } else {

        $response['isSuccess'] = false;
        $response['message']='获取到的参数不完整';

    }

} else {

    $response['isSuccess'] = false;
    $response['message']='操作未授权';
}

echo json_encode($response);
