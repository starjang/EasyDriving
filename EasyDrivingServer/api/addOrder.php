<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/12/19
 * Time: 4:19 PM
 */

require_once '../includes/PdoConnect.php';

$response = array();

if($_SERVER['REQUEST_METHOD']=='POST') {

    // uid POI全局唯一ID
    $uid = $_POST['uid'];
    $userId = $_POST['userId'];
    $placeName = $_POST['placeName'];
    $placeAddress = $_POST['placeAddress'];

    if ($uid != null && $userId != null && $placeName != null && $placeAddress != null)  {

        $sql = "INSERT INTO orders (uid, user_id, place_name, place_address, state) VALUES ('$uid', '$userId', '$placeName', '$placeAddress', 1)";

        $db = new PdoConnect();
        $pdo = $db->pdo();
        $query = "set names utf8";
        $pdo->query($query);

        $result = $pdo->query($sql);

        if ($result->rowCount() > 0) { // 添加预约成功

            $ordersList = null;

            $sql2 = "SELECT * FROM points WHERE user_id = '$userId' AND uid = '$uid'";

            $result2 = $pdo->query($sql2);

            $points = null;

            if ($result2->rowCount() > 0) {

                foreach ($result2 as $row) {

                    $points = $row['points'];
                }

                $points += 10;
                $sql3 = "UPDATE points SET points='$points' WHERE user_id='$userId' AND uid = '$uid'";
                $result3 = $pdo->query($sql3);

            } else {

                $points = 30;
                $sql4 = "INSERT INTO points (uid, user_id, place_name, place_address, points) VALUES ('$uid', '$userId', '$placeName', '$placeAddress', '$points')";
                $result3 = $pdo->query($sql4);
            }

            $response['isSuccess'] = true;
            $response['message'] = '预约成功';

        } else {

            $response['isSuccess'] = false;
            $response['message'] = '预约失败';
        }

    } else {
            $response['isSuccess'] = false;
            $response['message'] = '传入参数错误';
        }

    } else {

    $response['isSuccess'] = false;
    $response['message'] = '操作未授权';
}


echo json_encode($response);