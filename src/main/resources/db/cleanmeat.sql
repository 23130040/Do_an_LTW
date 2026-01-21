/*
 Navicat Premium Dump SQL

 Source Server         : cleanmeat
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : cleanmeat

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 14/01/2026 11:02:17
*/

SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`
(
    `id`         int NOT NULL AUTO_INCREMENT,
    `user_id`    int NOT NULL,
    `address`    text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `is_default` bit(1) NULL DEFAULT NULL,
    `created_at` datetime NULL DEFAULT current_timestamp(),
    `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX        `user_id`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- ----------------------------
-- Records of address
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`
(
    `id`          int                                                           NOT NULL AUTO_INCREMENT,
    `name`        varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `created_at`  datetime NULL DEFAULT current_timestamp(),
    `updated_at`  datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category`
VALUES (1, 'Thịt bò', 'Thịt nạt', '2025-12-26 17:07:10', '2026-01-02 22:23:50');
INSERT INTO `category`
VALUES (3, 'Thịt heo', '', '2025-12-27 20:56:03', '2026-01-02 22:23:30');
INSERT INTO `category`
VALUES (4, 'Thịt gà', '', '2025-12-27 22:15:42', '2025-12-27 22:15:42');

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `response_id` int NOT NULL,
    `user_id`     int NOT NULL,
    `item_id`     int NULL DEFAULT NULL,
    `rating`      int NULL DEFAULT NULL,
    `comment`     text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `created_at`  datetime NULL DEFAULT current_timestamp(),
    `updated_at`  datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`, `response_id`) USING BTREE,
    INDEX         `user_id`(`user_id`) USING BTREE,
    INDEX         `item_id`(`item_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback`
VALUES (1, 0, 22, 1, 4, 'Sản phẩm tươi ngon, đóng gói cẩn thận', '2025-12-16 21:29:51', '2025-12-18 21:38:11');
INSERT INTO `feedback`
VALUES (2, 1, 29, 1, 0, 'Cảm ơn', '2025-12-17 18:35:10', '2025-12-18 21:56:48');

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item`
(
    `id`                int                                                           NOT NULL AUTO_INCREMENT,
    `sku`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `name`              varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `short_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `long_description`  text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `category_id`       int                                                           NOT NULL,
    `origin_id`         int                                                           NOT NULL,
    `unit_id`           int                                                           NOT NULL,
    `price`             decimal(10, 2)                                                NOT NULL,
    `discount`          decimal(5, 2) NULL DEFAULT 0.00,
    `current_stock`     int NULL DEFAULT 0,
    `min_stock`         int NULL DEFAULT NULL,
    `created_at`        datetime NULL DEFAULT current_timestamp(),
    `updated_at`        datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX               `category_id`(`category_id`) USING BTREE,
    INDEX               `origin_id`(`origin_id`) USING BTREE,
    INDEX               `unit_id`(`unit_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 133 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `item`
VALUES (1, '', 'Ba chỉ bò', NULL, NULL, 1, 1, 1, 50000.00, 0.00, 50, 5, '2026-01-02 16:29:12', '2026-01-02 22:24:19');
INSERT INTO `item`
VALUES (2, '', 'Ba chỉ bò', NULL, NULL, 1, 1, 2, 72000.00, 0.00, 50, 5, '2026-01-02 17:08:27', '2026-01-02 22:24:20');
INSERT INTO `item`
VALUES (3, '', 'Ba chỉ bò', NULL, NULL, 1, 1, 3, 90000.00, 0.00, 100, 5, '2026-01-02 17:08:36', '2026-01-02 22:24:21');
INSERT INTO `item`
VALUES (4, '', 'Thịt bò tươi', NULL, NULL, 1, 1, 1, 50000.00, 0.00, 30, 5, '2026-01-02 17:08:41',
        '2026-01-02 22:24:49');
INSERT INTO `item`
VALUES (5, '', 'Thịt bò tươi', NULL, NULL, 1, 1, 2, 72000.00, 0.00, 10, 5, '2026-01-02 17:08:46',
        '2026-01-02 22:24:50');
INSERT INTO `item`
VALUES (6, '', 'Thịt bò tươi', NULL, NULL, 1, 1, 3, 90000.00, 0.00, 100, 5, '2026-01-02 17:08:53',
        '2026-01-02 22:24:54');
INSERT INTO `item`
VALUES (7, '', 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.',
        'Ba chỉ bò Mỹ (Shortplate) là phần thịt tại bụng bò, có những dải mỡ và thịt xen kẽ nhau giúp miếng thịt mềm, ngậy, ngọt.',
        1, 1, 2, 72000.00, 0.00, 50, 5, '2026-01-02 22:33:36', '2026-01-02 22:33:57');
INSERT INTO `item`
VALUES (8, '', 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.',
        'Ba chỉ bò Mỹ (Shortplate) là phần thịt tại bụng bò, có những dải mỡ và thịt xen kẽ nhau giúp miếng thịt mềm, ngậy, ngọt.',
        1, 1, 1, 50000.00, 0.00, 50, 5, '2026-01-02 22:33:36', '2026-01-02 22:33:59');
INSERT INTO `item`
VALUES (9, '', 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.',
        'Ba chỉ bò Mỹ (Shortplate) là phần thịt tại bụng bò, có những dải mỡ và thịt xen kẽ nhau giúp miếng thịt mềm, ngậy, ngọt.',
        1, 1, 3, 90000.00, 0.00, 100, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:01');
INSERT INTO `item`
VALUES (10, '', 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.',
        'Thăn ngoại bò là phần thịt nằm ở cuối dẻ sườn hai bên của con bò. Đặc điểm là thịt rất mềm và có một lớp mỡ mỏng phía trên.',
        1, 1, 1, 120000.00, 0.00, 30, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:03');
INSERT INTO `item`
VALUES (11, '', 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.',
        'Thăn ngoại bò là phần thịt nằm ở cuối dẻ sườn hai bên của con bò. Đặc điểm là thịt rất mềm và có một lớp mỡ mỏng phía trên.',
        1, 1, 2, 230000.00, 0.00, 30, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:04');
INSERT INTO `item`
VALUES (12, '', 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.',
        'Thăn ngoại bò là phần thịt nằm ở cuối dẻ sườn hai bên của con bò. Đặc điểm là thịt rất mềm và có một lớp mỡ mỏng phía trên.',
        1, 1, 3, 350000.00, 0.00, 30, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:05');
INSERT INTO `item`
VALUES (13, '', 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.',
        'Bắp hoa bò là phần thịt bắp nhỏ nằm ở chân con bò, có nhiều đường gân xen kẽ, khi ăn rất giòn và thơm.', 1, 1,
        1, 85000.00, 0.00, 40, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:07');
INSERT INTO `item`
VALUES (14, '', 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.',
        'Bắp hoa bò là phần thịt bắp nhỏ nằm ở chân con bò, có nhiều đường gân xen kẽ, khi ăn rất giòn và thơm.', 1, 1,
        2, 160000.00, 0.00, 40, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:08');
INSERT INTO `item`
VALUES (15, '', 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.',
        'Bắp hoa bò là phần thịt bắp nhỏ nằm ở chân con bò, có nhiều đường gân xen kẽ, khi ăn rất giòn và thơm.', 1, 1,
        3, 240000.00, 0.00, 40, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:09');
INSERT INTO `item`
VALUES (16, '', 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.',
        'Dẻ sườn bò là phần thịt nằm ở khoang sườn của bò, có vị ngọt đậm và hương thơm đặc trưng của mỡ bò.', 1, 1, 1,
        95000.00, 0.00, 25, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:10');
INSERT INTO `item`
VALUES (17, '', 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.',
        'Dẻ sườn bò là phần thịt nằm ở khoang sườn của bò, có vị ngọt đậm và hương thơm đặc trưng của mỡ bò.', 1, 1, 2,
        180000.00, 0.00, 25, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:11');
INSERT INTO `item`
VALUES (18, '', 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.',
        'Dẻ sườn bò là phần thịt nằm ở khoang sườn của bò, có vị ngọt đậm và hương thơm đặc trưng của mỡ bò.', 1, 1, 3,
        270000.00, 0.00, 25, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:13');
INSERT INTO `item`
VALUES (19, '', 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.',
        'Lõi vai bò (Top Blade) có một sợi gân mỏng ở giữa, thịt rất ngọt và mềm, thường dùng cho món nướng hoặc nhúng lẩu.',
        1, 1, 1, 110000.00, 0.00, 35, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:14');
INSERT INTO `item`
VALUES (20, '', 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.',
        'Lõi vai bò (Top Blade) có một sợi gân mỏng ở giữa, thịt rất ngọt và mềm, thường dùng cho món nướng hoặc nhúng lẩu.',
        1, 1, 2, 210000.00, 0.00, 35, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:16');
INSERT INTO `item`
VALUES (21, '', 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.',
        'Lõi vai bò (Top Blade) có một sợi gân mỏng ở giữa, thịt rất ngọt và mềm, thường dùng cho món nướng hoặc nhúng lẩu.',
        1, 1, 3, 310000.00, 0.00, 35, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:19');

-- ----------------------------
-- Table structure for item_image
-- ----------------------------
DROP TABLE IF EXISTS `item_image`;
CREATE TABLE `item_image`
(
    `id`         int NOT NULL AUTO_INCREMENT,
    `item_id`    int NOT NULL,
    `url`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `is_primary` bit(1) NULL DEFAULT NULL,
    `created_at` datetime NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE,
    INDEX        `item_id`(`item_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of item_image
-- ----------------------------
INSERT INTO `item_image`
VALUES (45, 9, 'sp_3_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (44, 9, 'sp_3_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (43, 9, 'sp_3_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (42, 9, 'sp_3_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (41, 9, 'sp_3.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (40, 8, 'sp_3_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (39, 8, 'sp_3_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (38, 8, 'sp_3_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (37, 8, 'sp_3_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (36, 8, 'sp_3.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (35, 7, 'sp_3_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (34, 7, 'sp_3_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (33, 7, 'sp_3_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (32, 7, 'sp_3_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (31, 7, 'sp_3.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (30, 6, 'sp_2_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (29, 6, 'sp_2_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (28, 6, 'sp_2_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (27, 6, 'sp_2_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (26, 6, 'sp_2.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (25, 5, 'sp_2_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (24, 5, 'sp_2_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (23, 5, 'sp_2_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (22, 5, 'sp_2_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (21, 5, 'sp_2.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (20, 4, 'sp_2_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (19, 4, 'sp_2_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (18, 4, 'sp_2_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (17, 4, 'sp_2_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (16, 4, 'sp_2.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (15, 3, 'sp_1_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (14, 3, 'sp_1_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (13, 3, 'sp_1_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (12, 3, 'sp_1_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (11, 3, 'sp_1.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (10, 2, 'sp_1_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (9, 2, 'sp_1_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (8, 2, 'sp_1_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (7, 2, 'sp_1_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (6, 2, 'sp_1.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image`
VALUES (5, 1, 'sp_1_4.jpg', b'0', '2026-01-02 23:03:37');
INSERT INTO `item_image`
VALUES (4, 1, 'sp_1_3.jpg', b'0', '2026-01-02 23:03:16');
INSERT INTO `item_image`
VALUES (3, 1, 'sp_1_2.jpg', b'0', '2026-01-02 23:03:05');
INSERT INTO `item_image`
VALUES (2, 1, 'sp_1_1.jpg', b'0', '2026-01-02 23:02:42');
INSERT INTO `item_image`
VALUES (1, 1, 'sp_1.jpg', b'1', '2026-01-02 23:02:29');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`
(
    `id`          int                                                           NOT NULL AUTO_INCREMENT,
    `title`       varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `author`      varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `picture_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `content`     text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `status`      varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `created_at`  datetime NULL DEFAULT current_timestamp(),
    `created_by`  int                                                           NOT NULL,
    `updated_at`  datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX         `created_by`(`created_by`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news`
VALUES (1, 'Thịt bò', 'Nguyễn Văn A', NULL, 'abc', NULL, '2025-12-29 15:13:39', 1, '2025-12-29 15:13:39');

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification`
(
    `id`         int NOT NULL AUTO_INCREMENT,
    `user_id`    int NOT NULL,
    `content`    text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `email`      varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `url`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `created_at` datetime NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`) USING BTREE,
    INDEX        `user_id`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notification
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`
(
    `id`             int                                                          NOT NULL AUTO_INCREMENT,
    `code`           varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `user_id`        int                                                          NOT NULL,
    `total_price`    decimal(10, 2) NULL DEFAULT NULL,
    `status`         varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `transport_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `payment_type`   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `created_at`     datetime NULL DEFAULT current_timestamp(),
    `updated_at`     datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
    `address_id`     int                                                          NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `code`(`code`) USING BTREE,
    INDEX            `user_id`(`user_id`) USING BTREE,
    INDEX            `address_id`(`address_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
ALTER TABLE `order`
DROP
COLUMN `transport_type`;

ALTER TABLE `order`
DROP
COLUMN `payment_type`;
-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`
(
    `order_id`   int NOT NULL,
    `item_id`    int NOT NULL,
    `price`      decimal(10, 2) NULL DEFAULT NULL,
    `quantity`   decimal(10, 2) NULL DEFAULT NULL,
    `created_at` datetime NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`order_id`, `item_id`) USING BTREE,
    INDEX        `item_id`(`item_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;
-- ----------------------------
-- Records of order_item
-- ----------------------------

-- ----------------------------
-- Table structure for origin
-- ----------------------------
DROP TABLE IF EXISTS `origin`;
CREATE TABLE `origin`
(
    `id`          int                                                           NOT NULL AUTO_INCREMENT,
    `name`        varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `created_at`  datetime NULL DEFAULT current_timestamp(),
    `updated_at`  datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of origin
-- ----------------------------
INSERT INTO `origin`
VALUES (1, 'Việt Nam', NULL, '2025-12-26 17:35:37', '2025-12-26 17:35:37');
INSERT INTO `origin`
VALUES (2, 'Mỹ', '', '2025-12-27 21:37:14', '2025-12-27 21:37:14');
INSERT INTO `origin`
VALUES (3, 'Úc', '', '2025-12-27 21:45:51', '2025-12-27 21:45:51');
INSERT INTO `origin`
VALUES (5, 'Hàn Quốc', '', '2025-12-27 21:54:49', '2025-12-27 21:54:49');

-- ----------------------------
-- Table structure for stock_history
-- ----------------------------
DROP TABLE IF EXISTS `stock_history`;
CREATE TABLE `stock_history`
(
    `id`         int                                                          NOT NULL AUTO_INCREMENT,
    `item_id`    int NULL DEFAULT NULL,
    `type`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `quantity`   decimal(10, 2) NULL DEFAULT NULL,
    `created_at` datetime NULL DEFAULT current_timestamp(),
    `created_by` int                                                          NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX        `product_id`(`item_id`) USING BTREE,
    INDEX        `created_by`(`created_by`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- ----------------------------
-- Records of stock_history
-- ----------------------------

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`
(
    `id`         int                                                          NOT NULL AUTO_INCREMENT,
    `name`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `email`      varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `hotline`    varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `tax_code`   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `facebook`   varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `instagram`  varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `address`    text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `logo_url`   text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `created_by` int NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX        `created_by`(`created_by`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config`
VALUES (1, 'Clean Meat', 'nmhau2410@gmail.com', '0962967942', '12344', 'https://www.facebook.com/nmhau2410',
        'https://www.instagram.com/_nmh2410', 'Đai học Nông Lâm TP.HCM', '', 1);

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit`
(
    `id`         int                                                           NOT NULL AUTO_INCREMENT,
    `name`       varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `amount`     decimal(10, 2) NULL DEFAULT NULL,
    `created_at` datetime NULL DEFAULT current_timestamp(),
    `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of unit
-- ----------------------------
INSERT INTO `unit`
VALUES (1, '250g', 250.00, '2025-12-29 19:55:45', '2025-12-29 19:55:45');
INSERT INTO `unit`
VALUES (2, '500g', 500.00, '2025-12-29 00:00:00', '2025-12-29 21:25:58');
INSERT INTO `unit`
VALUES (3, '1kg', 1000.00, '2025-12-29 00:00:00', '2025-12-29 21:26:00');
INSERT INTO `unit`
VALUES (4, '2kg', 2000.00, '2025-12-29 00:00:00', '2025-12-29 21:32:01');
INSERT INTO `unit`
VALUES (5, '3kg', 3000.00, '2025-12-29 00:00:00', '2025-12-29 21:31:51');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    `id`         int                                                           NOT NULL AUTO_INCREMENT,
    `name`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    `email`      varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `password`   text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `phone`      varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `gender`     varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT ' ',
    `birthday`   date NULL DEFAULT '2005-02-02',
    `role`       varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'user',
    `avatar`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT ' ',
    `created_at` datetime NULL DEFAULT current_timestamp(),
    `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
    `status`     bit(1) NULL DEFAULT b'0',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
ALTER TABLE `user`
    ADD COLUMN email_verified BOOLEAN DEFAULT FALSE;
ALTER TABLE `user`
    ADD COLUMN verify_token VARCHAR(255);
-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user`
VALUES (29, 'Nguyễn Văn A', 'admin@gmail.com', '123456', '0962967942', '', NULL, 'admin', '', '2025-12-24 13:17:11',
        '2026-01-04 02:42:28', b'0');
INSERT INTO `user`
VALUES (22, 'Nguyễn Văn A', 'nmhau2410@gmail.com', '123', '0962967942', '', NULL, 'customer', '', '2025-12-13 13:27:47',
        '2025-12-13 21:54:14', b'0');

SET
FOREIGN_KEY_CHECKS = 1;
ALTER TABLE user ENGINE=InnoDB;
ALTER TABLE category ENGINE=InnoDB;
ALTER TABLE origin ENGINE=InnoDB;
ALTER TABLE unit ENGINE=InnoDB;
ALTER TABLE system_config ENGINE=InnoDB;
ALTER TABLE address ENGINE=InnoDB;
ALTER TABLE item ENGINE=InnoDB;
ALTER TABLE item_image ENGINE=InnoDB;
ALTER TABLE feedback ENGINE=InnoDB;
ALTER TABLE `order` ENGINE=InnoDB;
ALTER TABLE order_item ROW_FORMAT = DYNAMIC;
ALTER TABLE order_item ENGINE=InnoDB;
ALTER TABLE stock_history ENGINE=InnoDB;
ALTER TABLE notification ENGINE=InnoDB;
ALTER TABLE news ENGINE=InnoDB;

ALTER TABLE `address`
    ADD CONSTRAINT fk1_user FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE;
ALTER TABLE feedback
    ADD CONSTRAINT fk2_user Foreign key (user_id) references user (id);
ALTER TABLE `feedback`
    ADD CONSTRAINT fk1_item FOREIGN KEY (item_id) REFERENCES item (id) ON DELETE CASCADE;
ALTER TABLE `item`
    ADD CONSTRAINT fk1_category FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE CASCADE;
ALTER TABLE `item`
    ADD CONSTRAINT fk1_origin FOREIGN KEY (origin_id) REFERENCES origin (id) ON DELETE CASCADE;
ALTER TABLE `item`
    ADD CONSTRAINT fk1_unit FOREIGN KEY (unit_id) REFERENCES unit (id) ON DELETE CASCADE;
ALTER TABLE `item_image`
    ADD CONSTRAINT fk2_item FOREIGN KEY (item_id) REFERENCES item (id) ON DELETE CASCADE;
ALTER TABLE `order`
    ADD CONSTRAINT fk3_user FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE;
ALTER TABLE `order_item`
    ADD CONSTRAINT fk2_order FOREIGN KEY (order_id) REFERENCES `order` (id) ON DELETE CASCADE;
ALTER TABLE `order_item`
    ADD CONSTRAINT fk3_item FOREIGN KEY (item_id) REFERENCES item (id) ON DELETE CASCADE;
ALTER TABLE `stock_history`
    ADD CONSTRAINT fk4_item FOREIGN KEY (item_id) REFERENCES item (id) ON DELETE CASCADE;
