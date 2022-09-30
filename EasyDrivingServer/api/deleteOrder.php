<?php
/**
 * Created by PhpStorm.
 * User: starjang
 * Date: 2018/12/21
 * Time: 19:28
 */

require_once '../includes/PdoConnect.php';

$response = array();

if($_SERVER['REQUEST_METHOD']=='POST') {

    $id = $_POST['id'];
    $userId = $_POST['userId'];

    $db = new PdoConnect();
    $pdo = $db->pdo();

    if ($id != null && $userId != null) {

        $sql = "DELETE FROM orders WHERE id = '$id' AND user_id = '$userId'";
        $result = $pdo->query($sql);

        if ($result->rowCount() > 0) {

            $response['isSuccess'] = true;
            $response['message'] = '预定订单删除成功';

        } else {

            $response['isSuccess'] = false;
            $response['message'] = '预定订单删除失败';
        }

    } else {

        $response['isSuccess'] = flase;
        $response['message'] = '请求参数不完整';

    }
}

else {

    $response['isSuccess'] = false;
    $response['message'] = '操作未授权';
}

echo json_encode($response);
