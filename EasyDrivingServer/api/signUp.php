<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/28
 * Time: 9:21 AM
 */

require_once '../includes/PdoConnect.php';

$response = array();

if($_SERVER['REQUEST_METHOD']=='POST') {

    $username = $_POST['username'];
    $password = $_POST['password'];
    $nickname = $_POST['nickname'];
    $carId = $_POST['carId'];

    $db = new PdoConnect();
    $pdo = $db->pdo();

    $sql = "SELECT id FROM `users` WHERE username = '$username'";

    $query = "set names utf8";
    $pdo->query($query);

    $result = $pdo->query($sql);

    if ($result->rowCount() > 0) {

        $response['isSuccess'] = false;
        $response['message']='用户已经存在';

    } else {

        $sql = "INSERT INTO users(username, password, nickname, car_id) VALUES(?,?,?,?)";
        $stmt = $pdo->prepare($sql);

        $stmt->bindParam(1,$username);
        $stmt->bindParam(2,$password);
        $stmt->bindParam(3,$nickname);
        $stmt->bindParam(4,$carId);

        $result = $stmt->execute();

        if ($result) {

            $response['isSuccess'] = true;
            $response['message']='用户注册成功';

        } else {

            $response['isSuccess'] = false;
            $response['message']='用户注册失败';

        }
    }
}

else {

    $response['isSuccess'] = false;
    $response['message']='操作未授权';
}

echo json_encode($response);