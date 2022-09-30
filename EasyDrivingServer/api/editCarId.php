<?php
/**
 * Created by PhpStorm.
 * User: starjang
 * Date: 2018/12/24
 * Time: 19:21
 */

require_once '../includes/PdoConnect.php';

$response = array();

if($_SERVER['REQUEST_METHOD']=='POST') {

    $userId = $_POST['userId'];
    $carId = $_POST['carId'];

    $db = new PdoConnect();
    $pdo = $db->pdo();

    if ($userId != null && $carId != null) {

        $sql="UPDATE users SET car_id='$carId' WHERE id ='$userId'";

        $query = "set names utf8";
        $pdo->query($query);

        $result = $pdo->query($sql);

        if ($result->rowCount() > 0) {

            $response['isSuccess'] = true;
            $response['message'] = '车牌号修改成功';

        } else {

            $response['isSuccess'] = true;
            $response['message'] = '车牌号修改失败';
        }
    }
}

else {

    $response['isSuccess'] = false;
    $response['message']='操作未授权';
}

echo json_encode($response);