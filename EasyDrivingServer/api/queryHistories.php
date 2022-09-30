<?php
/**
 * Created by PhpStorm.
 * User: starjang
 * Date: 2018/12/21
 * Time: 19:11
 */
require_once '../includes/PdoConnect.php';

$response = array();

if($_SERVER['REQUEST_METHOD']=='POST') {

    $userId = $_POST['userId'];

    if ($userId != null) {

        $db = new PdoConnect();
        $pdo = $db->pdo();

        $sql = "SELECT id, latitude, longitude, create_time, history_name, history_address FROM histories WHERE user_id = '$userId' ORDER BY create_time DESC";
        $result = $pdo->query($sql);

        if ($result->rowCount() > 0) {

            $histories = null;
            $index = 0;
            $counts = $result->rowCount();

            foreach ($result as $row) {

                $histories[$index]['historyId'] = $row['id'];
                $histories[$index]['latitude'] = $row['latitude'];
                $histories[$index]['longitude'] = $row['longitude'];
                $histories[$index]['historyName'] = $row['history_name'];
                $histories[$index]['historyAddress'] = $row['history_address'];
                $histories[$index]['createTime'] = $row['create_time'];

                $index ++;
                if ($index >= $counts){
                    break;
                }
            }

            $response['count'] = $counts;
            $response['histories'] = $histories;
            $response['isSuccess'] = true;
            $response['message'] = '查询历史足迹成功';

        } else {

            $response['isSuccess'] = false;
            $response['message'] = '查询历史足迹失败';
        }
    } else {

        $response['isSuccess'] = false;
        $response['message'] = '无效参数';
    }
}

else {

    $response['isSuccess'] = false;
    $response['message'] = '操作未授权';
}

echo json_encode($response);
