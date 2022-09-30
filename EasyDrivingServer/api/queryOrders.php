<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/12/20
 * Time: 2:57 PM
 */

require_once '../includes/PdoConnect.php';

$response = array();

if($_SERVER['REQUEST_METHOD']=='POST') {

    $userId = $_POST['userId'];

    $db = new PdoConnect();
    $pdo = $db->pdo();

    $sql = "SELECT id, place_name, place_address, create_time, state FROM orders WHERE user_id = '$userId' ORDER BY create_time DESC";
    $result = $pdo->query($sql);

    if ($result->rowCount() > 0) {

        $orders = null;
        $index = 0;
        $counts = $result->rowCount();

        foreach ($result as $row) {

            $orders[$index]['id'] = $row['id'];
            $orders[$index]['placeName'] = $row['place_name'];
            $orders[$index]['placeAddress'] = $row['place_address'];
            $orders[$index]['createTime'] = $row['create_time'];
            $orders[$index]['state'] = $row['state'];

            $index ++;
            if ($index >= $counts){
                break;
            }
        }

        $response['count'] = $counts;
        $response['orders'] = $orders;
        $response['isSuccess'] = true;
        $response['message'] = '查询预定成功';

    } else {

        $response['isSuccess'] = false;
        $response['message'] = '查询预定失败';
    }
}

else {

    $response['isSuccess'] = false;
    $response['message'] = '操作未授权';
}

echo json_encode($response);
