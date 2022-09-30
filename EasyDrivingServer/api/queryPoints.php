<?php
/**
 * Created by PhpStorm.
 * User: starjang
 * Date: 2018/12/21
 * Time: 19:06
 */

require_once '../includes/PdoConnect.php';

$response = array();

if($_SERVER['REQUEST_METHOD']=='POST') {

    $userId = $_POST['userId'];

    $db = new PdoConnect();
    $pdo = $db->pdo();

    $sql = "SELECT id, place_name, place_address, points FROM points WHERE user_id = '$userId'";
    $result = $pdo->query($sql);

    if ($result->rowCount() > 0) {

        $points = null;
        $index = 0;
        $counts = $result->rowCount();

        foreach ($result as $row) {

            $points[$index]['pointId'] = $row['id'];
            $points[$index]['placeName'] = $row['place_name'];
            $points[$index]['placeAddress'] = $row['place_address'];
            $points[$index]['points'] = $row['points'];

            $index ++;
            if ($index >= $counts){
                break;
            }
        }

        $response['count'] = $counts;
        $response['points'] = $points;
        $response['isSuccess'] = true;
        $response['message'] = '查询积分成功';

    } else {

        $response['isSuccess'] = false;
        $response['message'] = '查询积分失败';
    }
}

else {

    $response['isSuccess'] = false;
    $response['message'] = '操作未授权';
}

echo json_encode($response);
