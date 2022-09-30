<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2018/11/23
 * Time: 2:21 PM
 */

class PdoConnect {

    public function pdo()
    {

        try {
//            $pdo = new PDO("mysql:host=localhost;dbname=easyDriving", "root", "");
            $pdo = new PDO("mysql:host=rdsinstance.csn7nyka36o2.us-east-2.rds.amazonaws.com;dbname=easyDriving", "root", "star.623661");
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            return $pdo;

        } catch (PDOException $e) {
            die("数据库连接失败" . $e->getMessage());
        }
    }
}