<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/28
 * Time: 4:44 PM
 */

class  common {

    static function returnData ($msg, $code, $data) {
        $response = array();
        $response['message'] = $msg;
        $response['isSuccess'] = $code;
        if ($data) {
            $response['msgBody'] = $data;
        }

        echo json_encode($response);
    }

   static function returnMsg ($msg, $code) {
        $response = array();
        $response['message'] = $msg;
        $response['isSuccess'] = $code;

        echo json_encode($response);
    }
}

