<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/28
 * Time: 4:34 PM
 */

require_once '../includes/PdoConnect.php';

$response = array();

if($_SERVER['REQUEST_METHOD']=='POST') {


    $username = $_POST['username'];
    $password = $_POST['password'];


    $db = new PdoConnect();
    $pdo = $db->pdo();

    $sql = "SELECT id, username, password, nickname,car_id FROM `users` WHERE username = '$username'";
    $result = $pdo->query($sql);

    if ($result->rowCount() > 0) {

        foreach ($result as $row) {

            if ($row['password'] == $password) {

                $response['userId'] = $row['id'];
                $response['username'] = $row['username'];
                $response['password'] = $row['password'];
                $response['nickname'] = $row['nickname'];
                $response['carId'] = $row['car_id'];

                $response['isSuccess'] = true;
                $response['message']='用户登录成功';

            } else {

                $response['isSuccess'] = false;
                $response['message']='用户名或密码错误';
            }
        }

    } else {

        $response['isSuccess'] = false;
        $response['message']='账号不存在';
    }
}

else {

    $response['isSuccess'] = false;
    $response['message']='操作未授权';
}

echo json_encode($response);
