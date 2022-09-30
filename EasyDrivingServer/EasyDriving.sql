/*
 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 100136
 Source Host           : localhost:3306
 Source Schema         : easyDriving

 Target Server Type    : MySQL
 Target Server Version : 100136
 File Encoding         : 65001

 Date: 20/12/2018 16:38:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for histories
-- ----------------------------
DROP TABLE IF EXISTS `histories`;
CREATE TABLE `histories` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `user_id` int(32) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `latitude` varchar(32) NOT NULL,
  `longitude` varchar(32) NOT NULL,
  `history_name` varchar(200) NOT NULL,
  `history_address` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `uid` varchar(32) NOT NULL,
  `user_id` int(32) NOT NULL,
  `place_name` varchar(300) NOT NULL,
  `place_address` varchar(300) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` int(32) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for points
-- ----------------------------
DROP TABLE IF EXISTS `points`;
CREATE TABLE `points` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `uid` varchar(32) NOT NULL,
  `user_id` int(32) NOT NULL,
  `place_name` varchar(300) NOT NULL,
  `place_address` varchar(300) NOT NULL,
  `points` int(32) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `nickname` varchar(32) DEFAULT NULL,
  `car_id` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` varchar(600) NOT NULL,
  `image_url` varchar(200) DEFAULT NULL,
  `content_url` varchar(200) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news
-- ----------------------------
BEGIN;
INSERT INTO `news` VALUES (3, '国产全新标致508L新消息 最大功率155kW', '日前，东风标致官方公布了全新标志508L的配置信息，包括ACC自适应巡航、全自动智能泊车辅助等功能，全系标配12.3寸液晶仪表和电', 'https://img0.pcauto.com.cn/pcauto/1812/20/g_14100163_1545277535304_240x160.jpg', 'https://www.pcauto.com.cn/nation/1410/14100163.html', '2018-12-21 13:34:41');
INSERT INTO `news` VALUES (4, '吉利GE11实车图曝光 定位紧凑型纯电动车', '日前，我们获得了一组吉利GE11的实车图，该车为吉利旗下全新的紧凑型纯电动车，有望于2019年上市。', 'https://img0.pcauto.com.cn/pcauto/1812/18/g_14069783_1545126928844_240x160.jpg', 'https://www.pcauto.com.cn/nation/1406/14069783.html', '2018-12-21 13:35:12');
INSERT INTO `news` VALUES (5, '新款昂科威国六版上市 售21.99-31.99万', '12月18日，上汽通用汽车别克宣布推出2019款昂科威国六版车型，售价不变，区间为21.99-31.99万元。新车型在满足国六排放标准的基', 'https://img0.pcauto.com.cn/pcauto/1812/18/g_14066523_1545107210329_240x160.jpg', 'https://www.pcauto.com.cn/nation/1406/14066523.html', '2018-12-21 13:36:19');
INSERT INTO `news` VALUES (6, '天际ME7开启预订 补贴前售价30-50万元', '电咖汽车官方消息，旗下高端品牌天际汽车（ENOVATE）的首款车型ME7正式开启预订，并于2019上海车展开启预售。据悉，新车补贴前售', 'https://img0.pcauto.com.cn/pcauto/1812/17/g_14046063_1545041775716_240x160.jpg', 'https://www.pcauto.com.cn/nation/1404/14046063.html', '2018-12-21 13:38:17');
INSERT INTO `news` VALUES (7, '蔚来ES6上市 补贴前售35.80-54.80万元', '来旗下第二款量产车型——ES6在12月15日NIO DAY正式上市，新车官方定位为高性能长续航智能电动SUV，共推出基准版、性能版、首发……', 'https://img0.pcauto.com.cn/pcauto/1812/15/g_14017423_1544874443691_240x160.jpg', 'https://www.pcauto.com.cn/nation/1401/14017423.html', '2018-12-21 13:39:14');
INSERT INTO `news` VALUES (8, '日产GT-R推特别版 庆祝日本选手美网夺冠', '日产为庆祝2018美国网球公开赛女单决赛中，日本大坂娜奥米直落两盘击败塞雷娜·威廉姆斯，成功捧得生涯首座大满贯奖杯，推出GT-R ……', 'https://img0.pcauto.com.cn/pcauto/1812/20/g_14098929_1545292826079_240x160.jpg', 'https://www.pcauto.com.cn/nation/1409/14098929.html', '2018-12-21 13:40:22');
INSERT INTO `news` VALUES (9, '福特Mustang电动概念车效果图 840匹四驱', '日前，俄罗斯一家名为Aviar Motors的公司发布了一款纯电动概念车R67的效果图。此车以1967年款的福特Mustang为原型，内部植入一套……', 'https://img0.pcauto.com.cn/pcauto/1812/19/g_14072683_1545183009824_240x160.jpg', 'https://www.pcauto.com.cn/nation/1407/14072683.html', '2018-12-21 13:41:19');
INSERT INTO `news` VALUES (10, '新一代奔驰CLA首张预告图放出 蜂腰魅影', '近日，奔驰官方公布了全新一代奔驰CLA的首张预告图。该车预计将于2019年1月开幕的CES展上正式亮相。……', 'https://img0.pcauto.com.cn/pcauto/1812/18/g_14064924_1545104752921_240x160.png', 'https://www.pcauto.com.cn/nation/1406/14064924.html', '2018-12-21 13:42:27');
INSERT INTO `news` VALUES (11, '奥迪A4 allroad量子灰特别版官图发布', '近日，奥迪官方正式发布了五门跨界旅行车——奥迪A4 allroad absolute特别版车型官图。此次新车未来上市后将限量125台。外观新采用……', 'https://img0.pcauto.com.cn/pcauto/1812/17/g_14042422_1545014578233_240x160.png', 'https://www.pcauto.com.cn/nation/1404/14042422.html', '2018-12-21 13:43:59');
INSERT INTO `news` VALUES (12, '法拉利488 Pista Spider亚洲首秀 V8引擎', '继北京站、宁波站之后，法拉利巡回限时概念店将于12月6日至10日登陆海南三亚。为庆祝法拉利限时概念店于三亚热力开幕，跃马携旗……', 'https://img0.pcauto.com.cn/pcauto/1812/07/g_13908946_1544147059421_240x160.jpg', 'https://www.pcauto.com.cn/nation/1390/13908946.html', '2018-12-21 13:45:49');
INSERT INTO `news` VALUES (13, '玛莎拉蒂Edizione Nobile特别版官图发布', '玛莎拉蒂公布了旗下Ghibli、Levante、总裁三款车的Edizione Nobile特别版车型官图。特别版车型均搭载Edizione Nobile套件，针对……', 'https://img0.pcauto.com.cn/pcauto/1812/06/g_13904983_1544084829323_240x160.jpg', 'https://www.pcauto.com.cn/nation/1390/13904983.html', '2018-12-21 13:46:19');
INSERT INTO `news` VALUES (14, '阿斯顿·马丁为DB6车型推出电力驱动套件', '近日，阿斯顿·马丁为已停产的经典车型——DB6 MkII Volante推出采用现款Rapide E技术的辅助电力驱动套件，并采用便于安装和拆卸的……', 'https://img0.pcauto.com.cn/pcauto/1812/05/g_13883648_1544004730503_240x160.png', 'https://www.pcauto.com.cn/nation/1388/13883648.html', '2018-12-21 13:46:59');
INSERT INTO `news` VALUES (15, '新奥迪A6L e-tron谍照曝光 动力或提升', '日前，网上曝光了全新奥迪A6L 55 e-tron quattro车型的谍照。该车为全新一代奥迪A6L的插电混动版本，预计将继续搭载由2.0T发动机……', 'https://img0.pcauto.com.cn/pcauto/1812/03/g_13854283_1543832536844_240x160.jpg', 'https://www.pcauto.com.cn/nation/1385/13854283.html', '2018-12-21 13:48:39');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;