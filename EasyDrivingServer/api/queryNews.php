<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/12/24
 * Time: 2:09 PM
 */

require_once '../includes/PdoConnect.php';

$response = array();

if($_SERVER['REQUEST_METHOD']=='POST') {

    $startIndex = $_POST['startIndex'];
    $pageCount = $_POST['pageCount'];

    $db = new PdoConnect();
    $pdo = $db->pdo();

    $sql = "SELECT * FROM news ORDER BY create_time DESC limit $startIndex, $pageCount";
    $result = $pdo->query($sql);
    $counts = $result->rowCount();

    if ($counts > 0) {

        $news = null;
        $index = 0;

        foreach ($result as $row) {

            $news[$index]['id'] = $row['id'];
            $news[$index]['title'] = $row['title'];
            $news[$index]['content'] = $row['content'];
            $news[$index]['imageUrl'] = $row['image_url'];
            $news[$index]['contentUrl'] = $row['content_url'];
            $news[$index]['createTime'] = $row['create_time'];

            $index ++;
            if ($index >= $counts){
                break;
            }
        }

        $response['count'] = $counts;
        $response['news'] = $news;
        $response['isSuccess'] = true;
        $response['message'] = '查询新闻成功';

    } else {

        $response['isSuccess'] = false;
        $response['message'] = '查询新闻失败';
    }
}

else {

    $response['isSuccess'] = false;
    $response['message'] = '操作未授权';
}

echo json_encode($response);
