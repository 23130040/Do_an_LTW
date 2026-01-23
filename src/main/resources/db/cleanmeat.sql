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

 Date: 23/01/2026 10:27:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_default` bit(1) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk1_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 33, 'NLU, TPHCM', b'1', '2026-01-23 08:04:13', '2026-01-23 08:04:13');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'Thịt bò', 'Các sản phẩm từ thịt heo sạch', '2025-12-26 17:07:10', '2026-01-02 22:23:50');
INSERT INTO `category` VALUES (2, 'Thịt heo', 'Các sản phẩm gà ta, gà thả vườn', '2025-12-27 20:56:03', '2026-01-23 10:20:53');
INSERT INTO `category` VALUES (3, 'Thịt gà', 'Thịt bò tươi sống, bò nhập khẩu', '2025-12-27 22:15:42', '2026-01-23 10:20:57');

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `response_id` int NOT NULL,
  `user_id` int NOT NULL,
  `item_id` int NULL DEFAULT NULL,
  `rating` int NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `response_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `item_id`(`item_id` ASC) USING BTREE,
  CONSTRAINT `fk1_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk2_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (1, 0, 29, 1, 4, 'Sản phẩm tươi', '2026-01-23 08:01:56', '2026-01-23 08:01:56');

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `long_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `category_id` int NOT NULL,
  `origin_id` int NOT NULL,
  `unit_id` int NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `discount` decimal(5, 2) NULL DEFAULT 0.00,
  `current_stock` int NULL DEFAULT 0,
  `min_stock` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  INDEX `origin_id`(`origin_id` ASC) USING BTREE,
  INDEX `unit_id`(`unit_id` ASC) USING BTREE,
  CONSTRAINT `fk1_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk1_origin` FOREIGN KEY (`origin_id`) REFERENCES `origin` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk1_unit` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `item` VALUES (1, '', 'Ba chỉ bò', NULL, NULL, 1, 1, 1, 50000.00, 0.00, 50, 5, '2026-01-02 16:29:12', '2026-01-02 22:24:19');
INSERT INTO `item` VALUES (2, '', 'Ba chỉ bò', NULL, NULL, 1, 1, 2, 72000.00, 0.00, 50, 5, '2026-01-02 17:08:27', '2026-01-02 22:24:20');
INSERT INTO `item` VALUES (3, '', 'Ba chỉ bò', NULL, NULL, 1, 1, 3, 90000.00, 0.00, 100, 5, '2026-01-02 17:08:36', '2026-01-02 22:24:21');
INSERT INTO `item` VALUES (4, '', 'Thịt bò tươi', NULL, NULL, 1, 1, 1, 50000.00, 0.00, 30, 5, '2026-01-02 17:08:41', '2026-01-02 22:24:49');
INSERT INTO `item` VALUES (5, '', 'Thịt bò tươi', NULL, NULL, 1, 1, 2, 72000.00, 0.00, 10, 5, '2026-01-02 17:08:46', '2026-01-02 22:24:50');
INSERT INTO `item` VALUES (6, '', 'Thịt bò tươi', NULL, NULL, 1, 1, 3, 90000.00, 0.00, 100, 5, '2026-01-02 17:08:53', '2026-01-02 22:24:54');
INSERT INTO `item` VALUES (7, '', 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.', 'Ba chỉ bò Mỹ (Shortplate) là phần thịt tại bụng bò, có những dải mỡ và thịt xen kẽ nhau giúp miếng thịt mềm, ngậy, ngọt.', 1, 1, 2, 72000.00, 0.00, 50, 5, '2026-01-02 22:33:36', '2026-01-02 22:33:57');
INSERT INTO `item` VALUES (8, '', 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.', 'Ba chỉ bò Mỹ (Shortplate) là phần thịt tại bụng bò, có những dải mỡ và thịt xen kẽ nhau giúp miếng thịt mềm, ngậy, ngọt.', 1, 1, 1, 50000.00, 0.00, 50, 5, '2026-01-02 22:33:36', '2026-01-02 22:33:59');
INSERT INTO `item` VALUES (9, '', 'Ba chỉ bò Mỹ', 'Thịt ba chỉ bò nhập khẩu, vân mỡ đều.', 'Ba chỉ bò Mỹ (Shortplate) là phần thịt tại bụng bò, có những dải mỡ và thịt xen kẽ nhau giúp miếng thịt mềm, ngậy, ngọt.', 1, 1, 3, 90000.00, 0.00, 100, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:01');
INSERT INTO `item` VALUES (10, '', 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.', 'Thăn ngoại bò là phần thịt nằm ở cuối dẻ sườn hai bên của con bò. Đặc điểm là thịt rất mềm và có một lớp mỡ mỏng phía trên.', 1, 1, 1, 120000.00, 0.00, 30, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:03');
INSERT INTO `item` VALUES (11, '', 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.', 'Thăn ngoại bò là phần thịt nằm ở cuối dẻ sườn hai bên của con bò. Đặc điểm là thịt rất mềm và có một lớp mỡ mỏng phía trên.', 1, 1, 2, 230000.00, 0.00, 30, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:04');
INSERT INTO `item` VALUES (12, '', 'Thăn ngoại bò Úc', 'Thịt thăn mềm, thích hợp làm steak.', 'Thăn ngoại bò là phần thịt nằm ở cuối dẻ sườn hai bên của con bò. Đặc điểm là thịt rất mềm và có một lớp mỡ mỏng phía trên.', 1, 1, 3, 350000.00, 0.00, 30, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:05');
INSERT INTO `item` VALUES (13, '', 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.', 'Bắp hoa bò là phần thịt bắp nhỏ nằm ở chân con bò, có nhiều đường gân xen kẽ, khi ăn rất giòn và thơm.', 1, 1, 1, 85000.00, 0.00, 40, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:07');
INSERT INTO `item` VALUES (14, '', 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.', 'Bắp hoa bò là phần thịt bắp nhỏ nằm ở chân con bò, có nhiều đường gân xen kẽ, khi ăn rất giòn và thơm.', 1, 1, 2, 160000.00, 0.00, 40, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:08');
INSERT INTO `item` VALUES (15, '', 'Bắp bò hoa', 'Bắp bò nhiều gân, giòn ngọt.', 'Bắp hoa bò là phần thịt bắp nhỏ nằm ở chân con bò, có nhiều đường gân xen kẽ, khi ăn rất giòn và thơm.', 1, 1, 3, 240000.00, 0.00, 40, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:09');
INSERT INTO `item` VALUES (16, '', 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.', 'Dẻ sườn bò là phần thịt nằm ở khoang sườn của bò, có vị ngọt đậm và hương thơm đặc trưng của mỡ bò.', 1, 1, 1, 95000.00, 0.00, 25, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:10');
INSERT INTO `item` VALUES (17, '', 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.', 'Dẻ sườn bò là phần thịt nằm ở khoang sườn của bò, có vị ngọt đậm và hương thơm đặc trưng của mỡ bò.', 1, 1, 2, 180000.00, 0.00, 25, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:11');
INSERT INTO `item` VALUES (18, '', 'Dẻ sườn bò Mỹ', 'Thịt dẻ sườn đậm đà, béo ngậy.', 'Dẻ sườn bò là phần thịt nằm ở khoang sườn của bò, có vị ngọt đậm và hương thơm đặc trưng của mỡ bò.', 1, 1, 3, 270000.00, 0.00, 25, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:13');
INSERT INTO `item` VALUES (19, '', 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.', 'Lõi vai bò (Top Blade) có một sợi gân mỏng ở giữa, thịt rất ngọt và mềm, thường dùng cho món nướng hoặc nhúng lẩu.', 1, 1, 1, 110000.00, 0.00, 35, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:14');
INSERT INTO `item` VALUES (20, '', 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.', 'Lõi vai bò (Top Blade) có một sợi gân mỏng ở giữa, thịt rất ngọt và mềm, thường dùng cho món nướng hoặc nhúng lẩu.', 1, 1, 2, 210000.00, 0.00, 35, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:16');
INSERT INTO `item` VALUES (21, '', 'Lõi vai bò Mỹ', 'Thịt lõi vai mềm, ít mỡ.', 'Lõi vai bò (Top Blade) có một sợi gân mỏng ở giữa, thịt rất ngọt và mềm, thường dùng cho món nướng hoặc nhúng lẩu.', 1, 1, 3, 310000.00, 0.00, 35, 5, '2026-01-02 22:33:36', '2026-01-02 22:34:19');
INSERT INTO `item` VALUES (22, 'NBU-010301', 'Nạm bò Úc', NULL, NULL, 1, 3, 1, 135000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (23, 'NBU-010302', 'Nạm bò Úc', NULL, NULL, 1, 3, 2, 243000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (24, 'NBU-010303', 'Nạm bò Úc', NULL, NULL, 1, 3, 3, 364500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (25, 'BTNM-010101', 'Bò tươi nguyên miếng', NULL, NULL, 1, 1, 1, 320000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (26, 'BTNM-010102', 'Bò tươi nguyên miếng', NULL, NULL, 1, 1, 2, 576000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (27, 'BTNM-010103', 'Bò tươi nguyên miếng', NULL, NULL, 1, 1, 3, 864000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (28, 'TMB-010101', 'Thịt má bò', NULL, NULL, 1, 1, 1, 175000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (29, 'TMB-010102', 'Thịt má bò', NULL, NULL, 1, 1, 2, 315000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (30, 'TMB-010103', 'Thịt má bò', NULL, NULL, 1, 1, 3, 472500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (31, 'NGBT-010101', 'Nạm gầu bò tơ', NULL, NULL, 1, 1, 1, 320000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (32, 'NGBT-010102', 'Nạm gầu bò tơ', NULL, NULL, 1, 1, 2, 576000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (33, 'NGBT-010103', 'Nạm gầu bò tơ', NULL, NULL, 1, 1, 3, 864000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (34, 'TVB-010101', 'Thăn vai bò', NULL, NULL, 1, 1, 1, 380000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (35, 'TVB-010102', 'Thăn vai bò', NULL, NULL, 1, 1, 2, 684000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (36, 'TVB-010103', 'Thăn vai bò', NULL, NULL, 1, 1, 3, 1026000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (37, 'TNMB-010101', 'Thịt nạc mông bò tươi', NULL, NULL, 1, 1, 1, 260000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (38, 'TNMB-010102', 'Thịt nạc mông bò tươi', NULL, NULL, 1, 1, 2, 468000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (39, 'TNMB-010103', 'Thịt nạc mông bò tươi', NULL, NULL, 1, 1, 3, 702000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (40, 'DB-010101', 'Đuôi bò', NULL, NULL, 1, 1, 1, 220000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (41, 'DB-010102', 'Đuôi bò', NULL, NULL, 1, 1, 2, 396000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (42, 'DB-010103', 'Đuôi bò', NULL, NULL, 1, 1, 3, 594000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (43, 'BCB-010101', 'Ba chỉ bò', NULL, NULL, 1, 1, 1, 195000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (44, 'BCB-010102', 'Ba chỉ bò', NULL, NULL, 1, 1, 2, 351000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (45, 'BCB-010103', 'Ba chỉ bò', NULL, NULL, 1, 1, 3, 526500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (46, 'PLCB-010101', 'Phi lê cổ bò', NULL, NULL, 1, 1, 1, 150000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (47, 'PLCB-010102', 'Phi lê cổ bò', NULL, NULL, 1, 1, 2, 270000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (48, 'PLCB-010103', 'Phi lê cổ bò', NULL, NULL, 1, 1, 3, 405000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (49, 'TBB-010101', 'Thịt bắp bò', NULL, NULL, 1, 1, 1, 275000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (50, 'TBB-010102', 'Thịt bắp bò', NULL, NULL, 1, 1, 2, 495000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (51, 'TBB-010103', 'Thịt bắp bò', NULL, NULL, 1, 1, 3, 742500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (52, 'LSBD-010101', 'Lá sách bò - đen', NULL, NULL, 1, 1, 1, 175000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (53, 'LSBD-010102', 'Lá sách bò - đen', NULL, NULL, 1, 1, 2, 315000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (54, 'LSBD-010103', 'Lá sách bò - đen', NULL, NULL, 1, 1, 3, 472500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (55, 'LSBT-010101', 'Lá sách bò - trắng', NULL, NULL, 1, 1, 1, 190000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (56, 'LSBT-010102', 'Lá sách bò - trắng', NULL, NULL, 1, 1, 2, 342000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (57, 'LSBT-010103', 'Lá sách bò - trắng', NULL, NULL, 1, 1, 3, 513000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (58, 'MHS-020101', 'Mỡ heo sạch', NULL, NULL, 2, 1, 1, 52000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (59, 'MHS-020102', 'Mỡ heo sạch', NULL, NULL, 2, 1, 2, 93600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (60, 'MHS-020103', 'Mỡ heo sạch', NULL, NULL, 2, 1, 3, 140400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (61, 'BRRS-020101', 'Ba rọi rút sườn CleanMeat', NULL, NULL, 2, 1, 1, 169000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (62, 'BRRS-020102', 'Ba rọi rút sườn CleanMeat', NULL, NULL, 2, 1, 2, 304200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (63, 'BRRS-020103', 'Ba rọi rút sườn CleanMeat', NULL, NULL, 2, 1, 3, 456300.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (64, 'SNH-020101', 'Sườn non heo CleanMeat', NULL, NULL, 2, 1, 1, 159000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (65, 'SNH-020102', 'Sườn non heo CleanMeat', NULL, NULL, 2, 1, 2, 286200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (66, 'SNH-020103', 'Sườn non heo CleanMeat', NULL, NULL, 2, 1, 3, 429300.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (67, 'SBH-020101', 'Sườn bẹ heo', NULL, NULL, 2, 1, 1, 175000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (68, 'SBH-020102', 'Sườn bẹ heo', NULL, NULL, 2, 1, 2, 315000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (69, 'SBH-020103', 'Sườn bẹ heo', NULL, NULL, 2, 1, 3, 472500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (70, 'THCL-020101', 'Thịt heo cốt lết', NULL, NULL, 2, 1, 1, 162000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (71, 'THCL-020102', 'Thịt heo cốt lết', NULL, NULL, 2, 1, 2, 291600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (72, 'THCL-020103', 'Thịt heo cốt lết', NULL, NULL, 2, 1, 3, 437400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (73, 'TNTH-020101', 'Thịt nạc thăn heo', NULL, NULL, 2, 1, 1, 185000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (74, 'TNTH-020102', 'Thịt nạc thăn heo', NULL, NULL, 2, 1, 2, 333000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (75, 'TNTH-020103', 'Thịt nạc thăn heo', NULL, NULL, 2, 1, 3, 499500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (76, 'NDH-020101', 'Nạc đùi heo', NULL, NULL, 2, 1, 1, 110000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (77, 'NDH-020102', 'Nạc đùi heo', NULL, NULL, 2, 1, 2, 198000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (78, 'NDH-020103', 'Nạc đùi heo', NULL, NULL, 2, 1, 3, 297000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (79, 'NVH-020101', 'Nạc vai heo', NULL, NULL, 2, 1, 1, 126000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (80, 'NVH-020102', 'Nạc vai heo', NULL, NULL, 2, 1, 2, 226800.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (81, 'NVH-020103', 'Nạc vai heo', NULL, NULL, 2, 1, 3, 340200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (82, 'NDHC-020101', 'Nạc dăm hữu cơ', NULL, NULL, 2, 1, 1, 135000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (83, 'NDHC-020102', 'Nạc dăm hữu cơ', NULL, NULL, 2, 1, 2, 243000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (84, 'NDHC-020103', 'Nạc dăm hữu cơ', NULL, NULL, 2, 1, 3, 364500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (85, 'TH-020101', 'Tai heo', NULL, NULL, 2, 1, 1, 75000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (86, 'TH-020102', 'Tai heo', NULL, NULL, 2, 1, 2, 135000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (87, 'TH-020103', 'Tai heo', NULL, NULL, 2, 1, 3, 202500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (88, 'CGI-020101', 'Chân giò', NULL, NULL, 2, 1, 1, 118000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (89, 'CGI-020102', 'Chân giò', NULL, NULL, 2, 1, 2, 212400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (90, 'CGI-020103', 'Chân giò', NULL, NULL, 2, 1, 3, 318600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (91, 'XCH-020101', 'Xương cổ heo', NULL, NULL, 2, 1, 1, 119000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (92, 'XCH-020102', 'Xương cổ heo', NULL, NULL, 2, 1, 2, 214200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (93, 'XCH-020103', 'Xương cổ heo', NULL, NULL, 2, 1, 3, 321300.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (94, 'DT-020101', 'Dồi trường', NULL, NULL, 2, 1, 1, 190000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (95, 'DT-020102', 'Dồi trường', NULL, NULL, 2, 1, 2, 342000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (96, 'DT-020103', 'Dồi trường', NULL, NULL, 2, 1, 3, 513000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (97, 'XONH-020101', 'Xương ống nạc heo', NULL, NULL, 2, 1, 1, 109000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (98, 'XONH-020102', 'Xương ống nạc heo', NULL, NULL, 2, 1, 2, 196200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (99, 'XONH-020103', 'Xương ống nạc heo', NULL, NULL, 2, 1, 3, 294300.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (100, 'GNC-030101', 'Gà nguyên con', NULL, NULL, 3, 1, 1, 170000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (101, 'GNC-030102', 'Gà nguyên con', NULL, NULL, 3, 1, 2, 306000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (102, 'GNC-030103', 'Gà nguyên con', NULL, NULL, 3, 1, 3, 459000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (103, 'CGA-030101', 'Cổ gà', NULL, NULL, 3, 1, 1, 65000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (104, 'CGA-030102', 'Cổ gà', NULL, NULL, 3, 1, 2, 117000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (105, 'CGA-030103', 'Cổ gà', NULL, NULL, 3, 1, 3, 175500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (106, 'SG-030101', 'Sụn gà', NULL, NULL, 3, 1, 1, 189000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (107, 'SG-030102', 'Sụn gà', NULL, NULL, 3, 1, 2, 340200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (108, 'SG-030103', 'Sụn gà', NULL, NULL, 3, 1, 3, 510300.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (109, 'CNG-030101', 'Cánh gà', NULL, NULL, 3, 1, 1, 98000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (110, 'CNG-030102', 'Cánh gà', NULL, NULL, 3, 1, 2, 176400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (111, 'CNG-030103', 'Cánh gà', NULL, NULL, 3, 1, 3, 264600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (112, 'PCG-030101', 'Phao câu gà', NULL, NULL, 3, 1, 1, 48000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (113, 'PCG-030102', 'Phao câu gà', NULL, NULL, 3, 1, 2, 86400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (114, 'PCG-030103', 'Phao câu gà', NULL, NULL, 3, 1, 3, 129600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (115, 'CGKG-030101', 'Cánh gà khúc giữa', NULL, NULL, 3, 1, 1, 101000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (116, 'CGKG-030102', 'Cánh gà khúc giữa', NULL, NULL, 3, 1, 2, 181800.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (117, 'CGKG-030103', 'Cánh gà khúc giữa', NULL, NULL, 3, 1, 3, 272700.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (118, 'CGCX-030101', 'Chân gà có xương', NULL, NULL, 3, 1, 1, 105000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (119, 'CGCX-030102', 'Chân gà có xương', NULL, NULL, 3, 1, 2, 189000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (120, 'CGCX-030103', 'Chân gà có xương', NULL, NULL, 3, 1, 3, 283500.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (121, 'MDG-030101', 'Má đùi gà', NULL, NULL, 3, 1, 1, 98000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (122, 'MDG-030102', 'Má đùi gà', NULL, NULL, 3, 1, 2, 176400.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (123, 'MDG-030103', 'Má đùi gà', NULL, NULL, 3, 1, 3, 264600.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (124, 'DTG-030101', 'Đùi tỏi gà', NULL, NULL, 3, 1, 1, 110000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (125, 'DTG-030102', 'Đùi tỏi gà', NULL, NULL, 3, 1, 2, 198000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (126, 'DTG-030103', 'Đùi tỏi gà', NULL, NULL, 3, 1, 3, 297000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (127, 'CMDKX-030101', 'Cơm má đùi không xương', NULL, NULL, 3, 1, 1, 60000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (128, 'CMDKX-030102', 'Cơm má đùi không xương', NULL, NULL, 3, 1, 2, 108000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (129, 'CMDKX-030103', 'Cơm má đùi không xương', NULL, NULL, 3, 1, 3, 162000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (130, 'MG-030101', 'Mề gà', NULL, NULL, 3, 1, 1, 104000.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (131, 'MG-030102', 'Mề gà', NULL, NULL, 3, 1, 2, 187200.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');
INSERT INTO `item` VALUES (132, 'MG-030103', 'Mề gà', NULL, NULL, 3, 1, 3, 280800.00, 0.00, 100, 10, '2026-01-23 11:00:00', '2026-01-23 11:00:00');

-- ----------------------------
-- Table structure for item_image
-- ----------------------------
DROP TABLE IF EXISTS `item_image`;
CREATE TABLE `item_image`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_primary` bit(1) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `item_id`(`item_id` ASC) USING BTREE,
  CONSTRAINT `fk2_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of item_image
-- ----------------------------
INSERT INTO `item_image` VALUES (1, 1, 'sp_1.jpg', b'1', '2026-01-02 23:02:29');
INSERT INTO `item_image` VALUES (2, 1, 'sp_1_1.jpg', b'0', '2026-01-02 23:02:42');
INSERT INTO `item_image` VALUES (3, 1, 'sp_1_2.jpg', b'0', '2026-01-02 23:03:05');
INSERT INTO `item_image` VALUES (4, 1, 'sp_1_3.jpg', b'0', '2026-01-02 23:03:16');
INSERT INTO `item_image` VALUES (5, 1, 'sp_1_4.jpg', b'0', '2026-01-02 23:03:37');
INSERT INTO `item_image` VALUES (6, 2, 'sp_1.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (7, 2, 'sp_1_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (8, 2, 'sp_1_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (9, 2, 'sp_1_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (10, 2, 'sp_1_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (11, 3, 'sp_1.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (12, 3, 'sp_1_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (13, 3, 'sp_1_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (14, 3, 'sp_1_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (15, 3, 'sp_1_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (16, 4, 'sp_2.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (17, 4, 'sp_2_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (18, 4, 'sp_2_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (19, 4, 'sp_2_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (20, 4, 'sp_2_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (21, 5, 'sp_2.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (22, 5, 'sp_2_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (23, 5, 'sp_2_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (24, 5, 'sp_2_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (25, 5, 'sp_2_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (26, 6, 'sp_2.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (27, 6, 'sp_2_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (28, 6, 'sp_2_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (29, 6, 'sp_2_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (30, 6, 'sp_2_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (31, 7, 'sp_3.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (32, 7, 'sp_3_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (33, 7, 'sp_3_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (34, 7, 'sp_3_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (35, 7, 'sp_3_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (36, 8, 'sp_3.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (37, 8, 'sp_3_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (38, 8, 'sp_3_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (39, 8, 'sp_3_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (40, 8, 'sp_3_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (41, 9, 'sp_3.jpg', b'1', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (42, 9, 'sp_3_1.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (43, 9, 'sp_3_2.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (44, 9, 'sp_3_3.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (45, 9, 'sp_3_4.jpg', b'0', '2026-01-03 17:01:31');
INSERT INTO `item_image` VALUES (46, 22, 'images/Bo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (47, 23, 'images/Bo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (48, 24, 'images/Bo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (49, 25, 'images/Bo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (50, 26, 'images/Bo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (51, 27, 'images/Bo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (52, 28, 'images/Bo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (53, 29, 'images/Bo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (54, 30, 'images/Bo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (55, 31, 'images/Bo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (56, 32, 'images/Bo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (57, 33, 'images/Bo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (58, 34, 'images/Bo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (59, 35, 'images/Bo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (60, 36, 'images/Bo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (61, 37, 'images/Bo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (62, 38, 'images/Bo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (63, 39, 'images/Bo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (64, 40, 'images/Bo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (65, 41, 'images/Bo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (66, 42, 'images/Bo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (67, 43, 'images/Bo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (68, 44, 'images/Bo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (69, 45, 'images/Bo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (70, 46, 'images/Bo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (71, 47, 'images/Bo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (72, 48, 'images/Bo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (73, 49, 'images/Bo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (74, 50, 'images/Bo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (75, 51, 'images/Bo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (76, 52, 'images/Bo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (77, 53, 'images/Bo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (78, 54, 'images/Bo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (79, 55, 'images/Bo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (80, 56, 'images/Bo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (81, 57, 'images/Bo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (82, 58, 'images/Heo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (83, 59, 'images/Heo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (84, 60, 'images/Heo1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (85, 61, 'images/Heo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (86, 62, 'images/Heo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (87, 63, 'images/Heo2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (88, 64, 'images/Heo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (89, 65, 'images/Heo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (90, 66, 'images/Heo3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (91, 67, 'images/Heo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (92, 68, 'images/Heo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (93, 69, 'images/Heo4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (94, 70, 'images/Heo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (95, 71, 'images/Heo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (96, 72, 'images/Heo5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (97, 73, 'images/Heo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (98, 74, 'images/Heo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (99, 75, 'images/Heo6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (100, 76, 'images/Heo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (101, 77, 'images/Heo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (102, 78, 'images/Heo7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (103, 79, 'images/Heo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (104, 80, 'images/Heo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (105, 81, 'images/Heo8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (106, 82, 'images/Heo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (107, 83, 'images/Heo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (108, 84, 'images/Heo9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (109, 85, 'images/Heo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (110, 86, 'images/Heo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (111, 87, 'images/Heo10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (112, 88, 'images/Heo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (113, 89, 'images/Heo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (114, 90, 'images/Heo11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (115, 91, 'images/Heo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (116, 92, 'images/Heo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (117, 93, 'images/Heo12.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (118, 94, 'images/Heo13.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (119, 95, 'images/Heo13.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (120, 96, 'images/Heo13.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (121, 97, 'images/Heo14.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (122, 98, 'images/Heo14.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (123, 99, 'images/Heo14.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (124, 100, 'images/Ga1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (125, 101, 'images/Ga1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (126, 102, 'images/Ga1.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (127, 103, 'images/Ga2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (128, 104, 'images/Ga2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (129, 105, 'images/Ga2.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (130, 106, 'images/Ga3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (131, 107, 'images/Ga3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (132, 108, 'images/Ga3.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (133, 109, 'images/Ga4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (134, 110, 'images/Ga4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (135, 111, 'images/Ga4.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (136, 112, 'images/Ga5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (137, 113, 'images/Ga5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (138, 114, 'images/Ga5.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (139, 115, 'images/Ga6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (140, 116, 'images/Ga6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (141, 117, 'images/Ga6.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (142, 118, 'images/Ga7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (143, 119, 'images/Ga7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (144, 120, 'images/Ga7.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (145, 121, 'images/Ga8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (146, 122, 'images/Ga8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (147, 123, 'images/Ga8.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (148, 124, 'images/Ga9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (149, 125, 'images/Ga9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (150, 126, 'images/Ga9.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (151, 127, 'images/Ga10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (152, 128, 'images/Ga10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (153, 129, 'images/Ga10.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (154, 130, 'images/Ga11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (155, 131, 'images/Ga11.png', b'1', '2026-01-23 11:30:00');
INSERT INTO `item_image` VALUES (156, 132, 'images/Ga11.png', b'1', '2026-01-23 11:30:00');
-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `picture_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `created_by` int NOT NULL,
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `created_by`(`created_by` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, 'Làm sao biết thịt luộc đã chín?', 'Bùi Thúy', 'images/news1.jpg', '\r\n<p>Một số người nội trợ có mẹo kiểm tra bằng cách cắm đũa xuyên vào phần dày nhất,\r\nnếu xiên được và không có nước đỏ hồng rỉ ra là thịt đã đạt độ chín cần thiết.</p>\r\n\r\n<p>Các đầu bếp phương Tây cũng dùng &quot;nhiệt kế thủ công&quot; này để kiểm tra độ chín của lõi thịt.</p>\r\n\r\n<p>Một số người nội trợ có kinh nghiệm còn chia sẻ cách nhận diện gián tiếp bằng quan sát thịt nổi, nước trong.\r\nKhi miếng thịt chín, protein đông tụ khiến thớ co lại, khối thịt nhẹ đi và nổi dần lên mặt nước.\r\nCách này đơn giản, nhưng không phải lúc nào cũng đúng.</p>\r\n\r\n<p>Thịt ba chỉ nổi nhanh hơn thịt nạc.</p>\r\n\r\n<img src=\"images/news/thit-luoc-2.jpg\" alt=\"Thịt ba chỉ nổi nhanh hơn thịt nạc\">\r\n\r\n<p>Xét dưới góc độ khoa học, khi luộc, nhiệt truyền vào thịt theo cơ chế đối lưu và dẫn nhiệt.\r\nBề mặt bên ngoài thịt tiếp xúc với nước sôi ở 100°C, nhưng phải cần một khoảng thời gian\r\nđể nhiệt đi dần vào lõi.</p>\r\n\r\n<p>Trong khi đó, protein trong thịt biến đổi theo từng ngưỡng nhiệt:\r\nmyosin bắt đầu đông đặc ở 40–50°C khiến thớ thịt săn lại;\r\nactin biến tính ở 70–80°C quyết định độ cứng;\r\ncollagen trong gân, bì chỉ thật sự mềm ở 68–80°C.</p>\r\n\r\n<p>Khi thịt nổi, lớp ngoài có thể đã co rút, tạo túi khí và làm miếng thịt nhẹ hơn,\r\nnhưng lõi vẫn chưa chín. Chỉ khi cắm đũa và không còn dịch hồng\r\n(do myoglobin chưa biến tính) rỉ ra,\r\nmới chắc chắn lõi đã đạt 70–75°C – mức nhiệt thịt chín an toàn.</p>\r\n\r\n<p>Myoglobin, sắc tố đỏ trong thịt, cũng là yếu tố để xác định thịt chín hay chưa.\r\nKhi lõi thịt dưới 70°C, myoglobin còn màu đỏ tím, dịch rỉ ra đỏ hồng.\r\nLên đến 70–75°C, myoglobin chuyển sang nâu xám, nước trong và không còn màu.</p>\r\n\r\n<p>Điều này lý giải vì sao kinh nghiệm &quot;cắm đũa thấy không ra nước hồng là thịt đã chín&quot;\r\ntừ xưa là hoàn toàn có cơ sở khoa học.</p>\r\n\r\n<p>Hiện tượng nổi của thịt cũng phản ánh phần nào cấu trúc miếng thịt.\r\nThịt ba chỉ xen kẽ mỡ nhẹ nên dễ nổi nhanh,\r\ncòn thịt nạc vai hay bắp có cấu trúc protein chắc đặc,\r\ntỷ trọng cao nên nổi chậm hơn.</p>\r\n\r\n<p>Bọt khí và mỡ bám quanh cũng có thể làm miếng thịt nổi sớm,\r\nđánh lừa người nội trợ nếu chỉ quan sát bằng mắt.\r\nVì vậy, chỉ dựa vào dấu hiệu thịt nổi rất dễ vớt thịt ra khi lõi chưa chín.</p>\r\n\r\n<img src=\"images/news/thit-luoc-1.jpg\" alt=\"Thịt ba chỉ chín tới mềm ngọt\">\r\n\r\n<p>Ngoài việc nhận biết độ chín, khâu sơ chế trước khi luộc cũng rất quan trọng.\r\nRửa thịt kỹ, trụng sơ giúp loại bỏ máu và protein dễ đông,\r\nnhờ đó nước luộc trong, ít bọt, dễ quan sát.</p>\r\n\r\n<p>Một số gia đình còn ngâm thịt qua nước muối loãng\r\nđể giảm thất thoát dịch tế bào khi nấu,\r\ngiúp thịt giữ vị ngọt tự nhiên và không bị khô xác.\r\nĐây là nguyên lý thẩm thấu đã được khoa học chứng minh.</p>\r\n\r\n<p>Một bí quyết khác là tận dụng nhiệt dư.\r\nSau khi tắt bếp, nên để thịt trong nồi ủ thêm 10–15 phút.\r\nPhần nhiệt còn lại tiếp tục lan tỏa vào lõi,\r\ngiúp thịt chín đều mà không bở.</p>\r\n\r\n<p>Đây chính là nguyên tắc &quot;carry over cooking&quot; trong ẩm thực hiện đại,\r\nnhưng dân gian đã áp dụng từ lâu.\r\nNhờ vậy, khi thái ra, miếng thịt vừa chín tới,\r\nmàu hồng nhạt đẹp mắt, mềm ngọt và giữ được trọn vị.</p>\r\n', 'published', '2026-01-10 18:50:22', 1, '2026-01-10 19:20:45');
INSERT INTO `news` VALUES (2, 'Xe tải chở gần 6 tấn thịt hôi thối', 'Hoàng Táo', 'images/news2.jpg', '\r\n<p><strong>QUẢNG TRỊ</strong> - Xe tải chở gần 6 tấn thịt bốc mùi, chảy nước, không giấy tờ kiểm dịch đang trên đường từ Hà Nội sang Lào thì bị cảnh sát phát hiện.</p>\r\n\r\n<p>11h20 ngày 8/2, tại Km37 quốc lộ 9, đoạn qua xã Hướng Hiệp, huyện Đakrong, Phòng Cảnh sát phòng, chống tội phạm về môi trường phối hợp với Trạm Cảnh sát Giao thông Đakrông dừng kiểm tra ôtô tải do tài xế Võ Tá Ý (36 tuổi, trú Hương Thủy, Thừa Thiên Huế) điều khiển.</p>\r\n\r\n<p>Cảnh sát môi trường kiểm tra số thịt động vật. Ảnh: Quang Hà</p>\r\n\r\n<p>Nhà chức trách phát hiện xe chở 172 bao tải chứa 5,9 tấn thịt bốc mùi hôi, màu sắc biến đổi, chảy nước. Trong đó, 80 bao lưỡi heo, 20 bao tai heo, 10 bao thịt nạc heo, 23 bao da heo, 10 bao chân gà, 15 bao thịt vụn, 15 bao nạm bò. Số thịt này không có giấy chứng nhận kiểm dịch sản phẩm động vật ra khỏi địa bàn cấp tỉnh, được vận chuyển bằng phương tiện không bảo đảm yêu cầu vệ sinh thú y.</p>\r\n\r\n<p>Chủ hàng là bà Nguyễn Thị Sương (44 tuổi, trú Hương Thủy, Thừa Thiên Huế) khai nhận số thịt này được lấy từ khu công nghiệp Quang Minh, Hà Nội (hàng nhập khẩu từ Nga, Italia, Mỹ...), sau đó vận chuyển bằng xe đông lạnh vào Thừa Thiên Huế rồi dùng xe tải đưa sang Lào tiêu thụ.</p>\r\n', 'published', '2023-02-09 14:49:00', 1, '2023-02-09 14:49:00');
INSERT INTO `news` VALUES (3, 'Lợi ích ít biết của thịt gà', 'Bảo Bảo', 'images/news3.jpg', '\r\n<p>Thịt gà rất giàu protein, ít calo, chất béo, hỗ trợ giảm cân, tăng cơ và thúc đẩy sức khỏe tim mạch, cải thiện tâm trạng.</p>\r\n\r\n<p>Thịt gà là một trong những loại thịt phổ biến trong bữa ăn hàng ngày. Thực phẩm này dễ chế biến, có thể làm thành nhiều món ăn khác nhau.</p>\r\n\r\n<h3>Giá trị dinh dưỡng</h3>\r\n<p>Thị gà rất nhiều chất dinh dưỡng quan trọng bao gồm protein, niacin, selen và phốt pho.</p>\r\n<p>Một khẩu phần ức gà 85 g chứa:</p>\r\n<ul>\r\n    <li>Calo: 122 kcal</li>\r\n    <li>Protein: 24 g</li>\r\n    <li>Chất béo: 3 g</li>\r\n    <li>Carb: 0 g</li>\r\n</ul>\r\n\r\n<p>Lượng dinh dưỡng cơ thể cần hàng ngày (DV):</p>\r\n<ul>\r\n    <li>Vitamin B3: 51%</li>\r\n    <li>Selen: 36%</li>\r\n    <li>Phốt pho: 17%</li>\r\n    <li>Vitamin B6: 16%</li>\r\n    <li>Vitamin B12: 10%</li>\r\n    <li>Vitamn B2: 9%</li>\r\n    <li>Kẽm: 7%</li>\r\n    <li>Vitmain B1: 6%</li>\r\n    <li>Kali: 5%</li>\r\n    <li>Đồng: 4%</li>\r\n</ul>\r\n\r\n<p>Protein trong thị gà rất cần thiết cho việc xây dựng và sửa chữa các mô và duy trì khối lượng cơ bắp. Trong khi đó, selen là khoáng chất vi lượng cần thiết cho chức năng miễn dịch, sức khỏe tuyến giáp cũng như khả năng sinh sản.</p>\r\n<p>Nhóm vitamin B như B3, B6 và B12 đóng vai trò quan trọng trong việc sản xuất năng lượng, tổng hợp DNA và sức khỏe não bộ.</p>\r\n\r\n<h3>Lợi ích sức khỏe</h3>\r\n<p>Thịt gà cung cấp một loạt các chất dinh dưỡng quan trọng và phù hợp cho chế độ ăn uống lành mạnh, toàn diện. Đây cũng là lựa chọn thay thế tốt cho thịt đỏ.</p>\r\n\r\n<p><strong>Hỗ trợ giảm cân:</strong> Thịt gà ít calo nhưng giàu protein nên nó có thể đặc biệt có lợi cho việc giảm cân. Việc tăng lượng protein nạp vào có thể tăng cảm giác no, thúc đẩy giảm cân và giúp duy trì khối lượng cơ nạc.</p>\r\n\r\n<p><strong>Hỗ trợ tập luyện:</strong> Với những người tập luyện sức bền, bổ sung thực phẩm giàu protein như thịt gà cũng có thể thúc đẩy tăng trưởng cơ bắp. Protein tham gia vào quá trình chuyển hóa canxi và quan trọng để tối ưu hóa sức khỏe xương.</p>\r\n\r\n<p><strong>Hỗ trợ xương và cơ chắc khỏe hơn:</strong> Protein nạc trong thịt gà là nguồn chứa axit amin dồi dào. Cơ thể sử dụng axit amin để xây dựng mô cơ, một yếu tố đặc biệt quan trọng khi một người già đi. Bổ sung nhiều protein hơn giúp duy trì mật độ khoáng chất của xương. Ăn thịt gà hỗ trợ xây dựng cơ bắp chắc, xương chắc khỏe hơn, giảm nguy cơ chấn thương và các bệnh như loãng xương.</p>\r\n\r\n<p><strong>Tăng cường sức khỏe tim mạch:</strong> Tác dụng thúc đẩy giảm cân và hiệu quả tập luyện của thịt gà dẫn đến cải thiện các yếu tố nguy cơ mắc các vấn đề về tim như nồng độ triglyceride và huyết áp cao. Thực phẩm giàu protein như thịt gà còn giúp giảm nguy cơ mắc bệnh tim.</p>\r\n\r\n<p><strong>Cải thiện tâm trạng:</strong> Gà chứa axit amin tryptophan, có liên quan đến tăng nồng độ serotonin (hormone mang đến cảm xúc vui vẻ) trong não. Nồng độ tryptophan trong thịt gà không đủ cao để khiến bạn cảm thấy hưng phấn ngay lập tức, nhưng nó có thể giúp tăng nồng độ serotonin khi kết hợp với các yếu tố thuận lợi khác.</p>\r\n\r\n<h3>Lưu ý khi ăn thịt gà</h3>\r\n<p>Thịt gà tốt nhưng cần ăn và chế biến đúng cách. Ví dụ, gà chiên và tẩm bột như gà viên, gà popcorn, gà rán giòn thường chứa nhiều chất béo, carbohydrate, calo không lành mạnh. Các phần thịt sẫm màu như đùi và cánh gà chứa hàm lượng calo cao hơn các phần thịt nhạt màu hơn như ức. Giữ nguyên da hoặc chiên gà cũng làm tăng thêm chất béo bão hòa.</p>\r\n\r\n<p>Một số phương pháp chế biến gà lành mạnh:</p>\r\n<ul>\r\n    <li><strong>Gà nướng:</strong> Gà nướng có thể là cách chế biến nhanh chóng và lành mạnh để tăng lượng protein nạp vào cơ thể. Thêm một ít rau củ lên vỉ nướng để bữa ăn thêm trọn vẹn.</li>\r\n    <li><strong>Gà hầm:</strong> Hầm gà là lựa chọn ngon miệng cho bữa tối trong tuần, đặc biệt nếu đang cố gắng giảm cân. Ngoài ít chất béo và calo, gà hầm còn giàu các chất dinh dưỡng quan trọng.</li>\r\n    <li><strong>Gà xào:</strong> Hãy thử xào gà với một chút dầu và các loại rau yêu thích để có một bữa ăn giàu chất xơ, protein.</li>\r\n</ul>\r\n', 'published', '2025-10-27 06:00:00', 1, '2026-01-10 19:51:52');
INSERT INTO `news` VALUES (4, 'Người Nhật Bản chuộng thịt gà chế biến của Việt Nam', 'Thu Hà', 'images/news4.jpg', '\r\n<p>Thịt gà chế biến của doanh nghiệp Việt đang được đón nhận tại thị trường Nhật Bản.</p>\r\n\r\n<p>Sau 3 năm kể từ khi xuất khẩu lô gà chế biến đầu tiên sang Nhật Bản, ông Pawalit Ua-Amornwanit, Tổng Giám đốc C.P Việt Nam cho biết, đến nay đơn vị này đã xuất khẩu thành công 10.000 tấn thịt gà chế biến sang thị trường này. Ông tin rằng điều này cho thấy Việt Nam ngày càng đủ năng lực đáp ứng các tiêu chuẩn xuất khẩu thực phẩm nghiêm ngặt, đặc biệt tại thị trường cao cấp như Nhật Bản.</p>\r\n\r\n<p>Tuy nhiên, doanh nghiệp cho biết, hiện các sản phẩm vẫn chưa bán trực tiếp cho người tiêu dùng Nhật Bản mà phải thông qua các kênh phân phối và đối tác địa phương. Đơn cử, nếu muốn bán sản phẩm qua hệ thống 7-Eleven của Nhật Bản, nhà máy phải hợp tác với công ty quản lý kênh này để phân phối sản phẩm theo đơn đặt hàng của đối tác.</p>\r\n\r\n<p>Dù vậy, theo ông Pawalit Ua-Amornwanit, gần đây Chính phủ Việt Nam và Nhật Bản đã tích cực hỗ trợ, thúc đẩy quá trình thiết lập mối quan hệ giữa hai nước trong lĩnh vực xuất khẩu gia cầm. Điều này giúp Việt Nam có thể chính thức đưa sản phẩm gà sang Nhật Bản, mở ra cơ hội cho cả ngành chăn nuôi Việt Nam.</p>\r\n\r\n<p>Tháng 9-2025, Việt Nam và Nhật Bản đã khởi động Giai đoạn 3 của Tầm nhìn Trung và Dài hạn về hợp tác nông nghiệp (2025-2030), sau nhiều năm hợp tác ổn định trong lĩnh vực nông - lâm - thủy sản, với giá trị thương mại tăng từ 3,02 tỉ USD năm 2015 lên khoảng 4,9 tỉ USD vào năm 2024.</p>\r\n\r\n<p>Bà Nguyễn Thị Hoàng, Phó Chủ tịch UBND tỉnh Đồng Nai đánh giá, việc doanh nghiệp xuất khẩu thịt gà chế biến sang Nhật Bản không chỉ đóng góp thiết thực vào sự phát triển của ngành chăn nuôi tỉnh, mà còn tạo ra nguồn thu nhập ổn định cho lao động địa phương.</p>\r\n\r\n<p>Theo bà Hoàng, Đồng Nai hiện là một trong những tỉnh dẫn đầu cả nước về phát triển chăn nuôi. Tỉnh có quy mô tổng đàn khoảng 3,84 triệu con heo và gần 36,2 triệu con gia cầm (chủ yếu là đàn gà với tổng đàn khoảng 33 triệu con). Ngoài ra còn có các loại vật nuôi khác như trâu, dê, chim cút và chim yến.</p>\r\n\r\n<p>Trong những năm gần đây, chăn nuôi trên địa bàn tỉnh đã dịch chuyển theo hướng từ nhỏ lẻ sang trang trại, đặc biệt đối với hai loại vật nuôi chủ lực là heo và gà. Các trang trại cũng chủ động ứng dụng khoa học kỹ thuật tiên tiến trong chăn nuôi. Bên cạnh đó, các doanh nghiệp trong tỉnh còn xây dựng 52 chuỗi liên kết trong sản xuất. Trong đó có hai chuỗi thịt gà chế biến xuất khẩu sang thị trường Nhật Bản, với sản lượng xuất khẩu gần 1.000 tấn/tháng.</p>\r\n\r\n<p>Phó Chủ tịch UBND tỉnh đề nghị: Thời gian tới, doanh nghiệp tiếp tục phát huy các thành quả đạt được, đẩy mạnh tính chuyên nghiệp, mở rộng liên kết chuỗi sản xuất, đặt tiêu chí an toàn thực phẩm, an toàn dịch bệnh, bảo vệ môi trường và phát triển xanh lên hàng đầu, hướng đến phát triển bền vững.</p>\r\n', 'published', '2025-10-24 17:54:00', 1, '2026-01-10 19:57:51');
INSERT INTO `news` VALUES (5, 'Tranh cãi vì sao giá thịt bò ở Mỹ ngày càng đắt đỏ', 'Phiên An', 'images/news5.jpg', '\r\n<p><strong>Tranh cãi vì sao giá thịt bò ở Mỹ ngày càng đắt đỏ</strong></p>\r\n<p>Ông Trump cáo buộc các doanh nghiệp thao túng khiến giá thịt bò tăng cao trong khi nhà chế biến nói nguồn cung trong nước và nhập khẩu siết chặt.</p>\r\n\r\n<p>Hôm thứ sáu (7/11), Tổng thống Mỹ Donald Trump lên tiếng cáo buộc cộng đồng các doanh nghiệp thịt đã cùng nhau đẩy giá thịt bò tại Mỹ lên mức kỷ lục. Theo Cục Thống kê Lao động, giá bán lẻ mỗi pound thịt bò xay (ground chuck) vào tháng 9 là khoảng 6,33 USD, tăng 13,5% so với cùng kỳ 2024.</p>\r\n\r\n<p>Trên mạng xã hội Truth Social, ông Trump cho biết đã chỉ đạo Bộ Tư pháp mở \"cuộc điều tra về việc các công ty chế biến đang đẩy giá thịt bò lên, bằng cách thông đồng bất hợp pháp, ấn định giá và thao túng giá\". Động thái diễn ra trong bối cảnh người dân Mỹ đang lo lắng về túi tiền, đặc biệt là giá thực phẩm tăng nhanh hơn lạm phát. Cuộc khảo sát Reuters/Ipsos cuối tháng 10 cho thấy 40% người được hỏi coi chi phí sinh hoạt là vấn đề quan trọng nhất.</p>\r\n\r\n<p>Tổng chưởng lý Pam Bondi cho biết cuộc điều tra đang được tiến hành, do Bộ trưởng Nông nghiệp Brooke Rollins cùng Trợ lý Tổng chưởng lý Gail Slater phụ trách. Bà Slater là người đứng đầu về chống độc quyền của Bộ Tư pháp, cơ quan điều tra các hành vi ấn định giá và kìm hãm cạnh tranh khác.</p>\r\n\r\n<p>Không công ty cụ thể nào bị Nhà Trắng nêu đích danh. Hiện ở Mỹ, Tyson Foods, Cargill, JBS USA và National Beef Packing Company đang giết mổ khoảng 85% số bò được vỗ béo bằng ngũ cốc, nguồn cung cấp thịt dùng làm bít tết (steak), thịt nướng và các loại thịt bò khác tại siêu thị.</p>\r\n\r\n<p>Trong những năm gần đây, lời kêu gọi siết chặt các biện pháp chống độc quyền trong ngành chế biến thịt ngày càng lớn. Chính quyền cựu Tổng thống Joe Biden cũng từng đổ lỗi cho các công ty chế biến thịt về việc giá thực phẩm tăng cao. Mới đây, tại một phiên điều trần tháng 6, Thượng nghị sĩ Josh Hawley của đảng Cộng hòa, và Cory Booker thuộc đảng Dân chủ tiếp tục kêu gọi áp dụng các biện pháp chống độc quyền trong lĩnh vực thịt bò.</p>\r\n\r\n<p>Trước đó, các chủ trang trại từ lâu đã phàn nàn về mức độ độc quyền quá lớn. Bill Bullard, CEO nhóm đại diện người chăn nuôi R-CALF USA nhận xét ngành chế biến thịt bò Mỹ đang \"có mức độ tập trung rất cao, vượt xa mức thường được coi là gây hại cho nền kinh tế\".</p>\r\n\r\n<p>\"Chúng ta cần minh bạch, trách nhiệm giải trình và thị trường công bằng, nơi những người thực sự nuôi và sản xuất thịt bò được hưởng lợi, chứ không phải các tập đoàn trung gian đang thao túng hệ thống\", Bộ trưởng Nông nghiệp Brooke Rollins tuyên bố.</p>\r\n\r\n<p>Cargill từ chối bình luận. Các công ty chế biến thịt còn lại chưa ra phản hồi về động thái của chính quyền Trump. Reuters cho biết Cargill, Tyson, và JBS đều từng trả hàng chục triệu USD để dàn xếp các vụ kiện cáo buộc họ thông đồng làm tăng giá thịt bò bằng cách hạn chế nguồn cung. Họ phủ nhận tất cả cáo buộc.</p>\r\n\r\n<p>Tương tự, Viện Thịt - tổ chức vận động chính sách đại diện các nhà chế biến - khẳng định ngành thịt bò được quản lý rất chặt chẽ và các giao dịch trên thị trường đều minh bạch. \"Dù giá thịt bò cao, các nhà chế biến vẫn đang thua lỗ vì giá bò hơi hiện ở mức kỷ lục\", Julie Anna Potts, CEO Viện Thịt khẳng định.</p>\r\n\r\n<p>Giới kinh doanh cho rằng giá thịt bò ở Mỹ lập đỉnh vào 2025 sau nhiều năm hạn hán thiêu rụi đồng cỏ và đẩy chi phí thức ăn chăn nuôi tăng cao, buộc các chủ trại phải cắt giảm đàn bò xuống mức thấp nhất gần 75 năm. Trong khi đó, nhu cầu thịt bò của người dân nhìn chung vẫn mạnh mẽ.</p>\r\n\r\n<p>Cùng với đó, vào tháng 8, Tổng thống Trump đã áp thuế 50% với hàng hóa Brazil, khiến nguồn cung lớn thịt bò từ nước này bị siết chặt. Nửa đầu 2025, Brazil xuất khẩu 156.000 tấn thịt bò tươi, ướp lạnh và đông lạnh sang Mỹ, tăng 132% so với cùng kỳ 2024, theo Cơ quan Ngoại thương Brazil (Secex). Nhưng quý III, khối lượng xuất khẩu chỉ còn 26.900 tấn, giảm 47% so với cùng kỳ do thuế tăng.</p>\r\n\r\n<p>Gần đây, để giải quyết giá và nguồn cung, Tổng thống Trump kêu gọi các chủ trang trại giảm giá bò hơi, khiến họ bất bình. Ông đồng thời muốn tăng nhập khẩu thịt bò Argentina với thuế suất thấp để hạ giá thịt bò trong nước. Theo đó, chính quyền sẽ nâng hạn ngạch thuế thấp với thịt bò Argentina lên 80.000 tấn để nước này xuất khẩu nhiều hơn.</p>\r\n\r\n<p>Dù vậy, các nhà kinh tế cho biết việc nhập khẩu thêm từ Argentina sẽ không làm giảm đáng kể giá bán lẻ thịt bò đến tay cho người tiêu dùng Mỹ. Nông dân chăn nuôi bò thì càng phản đối. \"Một thỏa thuận lớn với Argentina sẽ làm suy yếu nền tảng của ngành chăn nuôi gia súc của chúng ta\", Justin Tupper, Chủ tịch Hiệp hội Chăn nuôi Mỹ, nhà sản xuất gia súc ở Nam Dakota nhận định.</p>\r\n\r\n<p>Phát biểu trong chương trình \"Mornings with Maria\" của Fox Business Network tháng trước, Bộ trưởng Nông nghiệp Brooke Rollins nói chính quyền đang nỗ lực hỗ trợ cả người tiêu dùng và người chăn nuôi. Theo đó, Nhà Trắng đã công bố kế hoạch mở rộng đàn gia súc trong nước và hỗ trợ các chủ trang trại.</p>\r\n', 'published', '2025-11-09 00:03:00', 1, '2026-01-10 19:58:05');
INSERT INTO `news` VALUES (6, 'Người đàn ông suýt mất mạng sau chế biến thịt lợn sống', 'Thúy Quỳnh', 'images/news6.jpg', '\r\n<p><strong>QUẢNG NINH</strong> - Sau khi chế biến thịt lợn sống, người đàn ông 61 tuổi sốt cao, nổi vân tím toàn thân, đau bụng, bác sĩ phát hiện nhiễm liên cầu lợn, tiên lượng tử vong.</p>\r\n\r\n<p>Ngày 21/8, đại diện Bệnh viện Bãi Cháy cho biết bệnh nhân nhập viện trong tình trạng sốt cao, mệt mỏi nhiều, hội chứng nhiễm trùng, mất nước. Kết quả siêu âm, chụp CT có hình ảnh tràn dịch khoang màng phổi hai bên, xẹp phổi.</p>\r\n\r\n<p>Bác sĩ chẩn đoán sốc nhiễm khuẩn, nhiễm khuẩn huyết, viêm phổi trên nền tăng huyết áp, tiên lượng tử vong rất cao.</p>\r\n\r\n<p>Bệnh nhân được điều trị hồi sức tích cực chuyên sâu theo phác đồ với kháng sinh, an thần thở máy, lọc máu liên tục, truyền dịch, vận mạch. Sau 7 ngày, người bệnh có tình trạng đau đầu, ý thức chậm, được chọc dịch não tủy, làm xét nghiệm, chẩn đoán viêm màng não do liên cầu lợn, được điều trị theo phác đồ viêm màng não.</p>\r\n\r\n<p>Hiện, bệnh nhân thoát nguy kịch, sức khỏe ổn định, xét nghiệm chỉ số nhiễm trùng cải thiện.</p>\r\n\r\n<p><strong>Liên cầu khuẩn lợn</strong> là bệnh lây truyền từ động vật sang người, chưa có bằng chứng bệnh lây từ người sang người. Hầu hết bệnh nhân đều liên quan đến việc giết mổ, ăn tiết canh hoặc các món đồ chưa nấu chín. Một số trường hợp không ăn tiết canh, không giết mổ lợn vẫn mắc bệnh do ăn thịt lợn bệnh tái sống, hoặc nhiễm khuẩn qua các tổn thương, trầy xước trên da khi chế biến.</p>\r\n\r\n<p>Bệnh nặng có thể tiến triển nhanh chóng thành nhiễm khuẩn huyết sốc nhiễm khuẩn, trụy mạch, tụt huyết áp, rối loạn đông máu nặng, ban xuất huyết hoại tử toàn thân, tắc mạch, suy đa phủ tạng... hôn mê và tử vong.</p>\r\n\r\n<p>Hiện chưa có vaccine phòng ngừa liên cầu lợn ở người. Cơ quan y tế khuyến cáo chỉ ăn thịt lợn đã được nấu chín hoàn toàn, không ăn tiết canh và các món tái sống. Khi chế biến thịt lợn, cần sử dụng găng tay bảo hộ để tránh nguy cơ lây nhiễm, nhất là khi có vết xước trên da. Khi xuất hiện các triệu chứng nghi ngờ như sốt cao, đau đầu, buồn nôn, đến bệnh viện khám và điều trị kịp thời.</p>\r\n', 'published', '2025-08-21 13:55:00', 1, '2026-01-16 20:53:20');
INSERT INTO `news` VALUES (7, '5 sai lầm phổ biến khiến món thịt bò xào bị dai', 'Bùi Thủy', 'images/news7.jpg', '\r\n<p>Nhiều người nội trợ thắc mắc tại sao dù chọn miếng thịt bò tươi ngon, khi xào lên vẫn bị khô và dai cứng. Vấn đề không chỉ nằm ở miếng thịt mà còn ở cách chúng ta xử lý và kiểm soát nhiệt độ.</p>\r\n\r\n<h3>Tại sao thịt bò dễ bị dai khi xào?</h3>\r\n<p>Thịt bò có cấu trúc sợi cơ to và nhiều mô liên kết (collagen) hơn thịt heo, gà. Khi gặp nhiệt độ cao đột ngột và trong thời gian ngắn như lúc xào, các protein chính trong thịt (myosin và actin) sẽ co rút mạnh.</p>\r\n<p>Ở 50-60°C, myosin co lại, thịt bắt đầu săn chắc, nước bị ép ra. Trên 70°C, actin co rút mạnh hơn, sợi cơ siết chặt, thịt mất phần lớn nước, trở nên khô và dai.</p>\r\n<p>Collagen, thành phần giúp thịt sống đàn hồi, cũng co cứng lại khi xào nhanh thay vì kịp chuyển thành gelatin mềm như khi hầm, ninh lâu. Chính cấu trúc đặc biệt và phản ứng nhanh với nhiệt này khiến thịt bò đòi hỏi kỹ thuật xào tinh tế hơn.</p>\r\n\r\n<h3>Những sai lầm phổ biến khiến bò xào dai</h3>\r\n<ul>\r\n    <li><strong>Xào quá kỹ:</strong> Xào thịt bò quá lâu trên lửa lớn khiến protein co rút tối đa, nước bốc hơi hết, miếng thịt trở nên khô xác.</li>\r\n    <li><strong>Ướp muối, nước mắm quá sớm:</strong> Gia vị mặn sẽ rút nước ra khỏi thịt nhanh chóng, làm thịt dễ bị khô và dai hơn khi chế biến.</li>\r\n    <li><strong>Cho thịt vào chảo khô quá nóng:</strong> Nhiệt độ cao tác động trực tiếp làm bề mặt thịt co cứng và cháy xém tức thì, trong khi bên trong chưa chín tới. Điều này dễ dẫn đến việc phải xào lâu hơn, làm thịt càng dai.</li>\r\n    <li><strong>Thái thịt sai thớ:</strong> Thái thịt dọc theo sợi cơ khiến miếng thịt rất khó nhai và tạo cảm giác dai, dù nấu đúng cách.</li>\r\n</ul>\r\n\r\n<h3>Bí quyết để món bò xào luôn mềm mọng</h3>\r\n<p><strong>Thái thịt đúng cách:</strong> Luôn thái thịt ngang thớ (vuông góc với chiều sợi cơ). Thao tác này giúp các sợi cơ dễ dàng bị cắt đứt khi nhai, tạo cảm giác mềm mại.</p>\r\n\r\n<p><strong>Ướp thịt thông minh:</strong></p>\r\n<ul>\r\n    <li><strong>Tạo lớp bảo vệ:</strong> Ướp thịt với một ít dầu ăn, bột bắp (hoặc bột năng) hoặc lòng trắng trứng trước khi nêm gia vị. Lớp màng mỏng này giúp giữ nước, hạn chế thịt tiếp xúc trực tiếp với nhiệt độ cao quá nhanh.</li>\r\n    <li><strong>Nêm muối/nước mắm sau cùng:</strong> Chỉ nêm gia vị mặn khi thịt đã gần chín hoặc sau khi xào xong rau củ, cho thịt vào đảo lại. Muối sẽ thấm vào bề mặt mà không làm mất nước bên trong thịt.</li>\r\n</ul>\r\n\r\n<p><strong>Kiểm soát nhiệt độ và thời gian:</strong></p>\r\n<ul>\r\n    <li><strong>Lửa lớn, thời gian ngắn:</strong> Xào thịt bò trên lửa lớn thật nhanh tay. Khi bề mặt thịt vừa se lại, chuyển sang màu hồng sậm thì nhanh chóng trút ra đĩa.</li>\r\n    <li><strong>Xào riêng:</strong> Xào rau củ trước, sau đó mới cho thịt bò đã xào sơ vào đảo nhanh ở bước cuối cùng để làm nóng và hòa quyện gia vị. Cách này đảm bảo thịt vừa chín tới, giữ được độ mềm và ngọt.</li>\r\n</ul>\r\n\r\n<p><strong>Mẹo nhỏ từ đầu bếp (tùy chọn):</strong> Một số nhà hàng dùng một lượng rất nhỏ baking soda (khoảng 1/2 thìa cà phê cho 300g thịt) ướp trong 15-20 phút rồi rửa sạch trước khi chế biến. Baking soda giúp sợi cơ giãn nở, làm thịt mềm hơn. Tuy nhiên, cần cẩn thận liều lượng để tránh làm thay đổi vị thịt.</p>\r\n', 'published', '2025-10-25 17:41:00', 1, '2026-01-16 20:56:05');
INSERT INTO `news` VALUES (8, 'Trời lạnh, nhất định phải ăn 5 món hấp này: Vừa nhanh, dễ nấu lại thơm lừng và cực kỳ ngon miệng', 'Huệ Lan', 'images/news8.jpg', '\r\n<p>Mùa đông, tiết trời lạnh, bạn nhất định không thể bỏ qua 5 món hấp này. Vừa đơn giản, vừa tươi mát, thơm ngon, lại ấm áp. Thời gian nấu chỉ từ 15 phút là hoàn thành.</p>\r\n\r\n<p>Hấp chính là \"kỹ nghệ\" nấu nướng hoàn hảo giúp giữ được hương vị nguyên bản mà thao tác đơn giản, nấu cũng siêu nhanh, giải quyết mọi sự phức tạp mà vẫn đảm bảo dưỡng chất nhất của thực phẩm.</p>\r\n\r\n<h3>1. Đùi gà hấp đậu phụ và đậu nành Nhật Bản</h3>\r\n<p><strong>Nguyên liệu:</strong> 2 cái đùi gà, 1 hộp đậu phụ non, 1 bát con đậu nành Nhật Bản, gia vị (nước tương, dầu hào, muối, gừng, hành lá, rượu nấu ăn, tinh bột bắp).</p>\r\n<p><strong>Cách làm:</strong> Đùi gà rửa sạch, chặt miếng vừa ăn rồi ướp với gừng, hành, nước tương, dầu hào, tinh bột bắp trong 15 phút. Xếp đậu phụ cắt miếng và đậu nành Nhật vào đĩa sâu lòng, rải gà lên trên và hấp 20 phút kể từ khi nước sôi.</p>\r\n<p><strong>Thành phẩm:</strong> Đậu phụ mềm thấm vị ngọt của thịt gà, đậu nành dẻo giòn trung hòa chất béo, thịt gà chín tới không bị khô.</p>\r\n\r\n<h3>2. Sườn heo hấp nấm nhung hươu (nấm lộc nhung)</h3>\r\n<p><strong>Nguyên liệu:</strong> 400g sườn non, 50g nấm nhung hươu, tỏi, gừng, nước tương, tinh bột bắp, tinh chất cốt gà.</p>\r\n<p><strong>Cách làm:</strong> Nấm ngâm nở, rửa sạch. Sườn chặt miếng, ngâm nước 5 phút loại bỏ máu thừa rồi thấm khô. Ướp sườn với nước tương, gừng, tỏi, bột bắp và nấm trong 20 phút. Cho vào đĩa sâu lòng và hấp khoảng 30 phút kể từ khi nước sôi.</p>\r\n<p><strong>Thành phẩm:</strong> Sườn mềm dễ rút xương, nấm mềm ngọt thơm đặc trưng hòa quyện cùng nước dùng đậm đà.</p>\r\n\r\n<h3>3. Thịt gà hấp nấm</h3>\r\n<p><strong>Nguyên liệu:</strong> 2 phần đùi gà rút xương, 8-10 cây nấm hương, tỏi băm, nước tương, dầu hào, nước tương đen, tinh bột bắp.</p>\r\n<p><strong>Cách làm:</strong> Nấm hương thái lát mỏng. Thịt gà thái miếng vừa ăn, ướp với tỏi và các gia vị trong 15 phút. Xếp nấm hương xuống đáy đĩa, rải gà lên trên và hấp 30 phút từ khi nước sôi.</p>\r\n<p><strong>Thành phẩm:</strong> Hương nấm nồng nàn thấm vào thịt gà mịn màng, vị mặn ngọt hài hòa, tươi mát cho ngày lạnh.</p>\r\n\r\n<h3>4. Thịt bò hấp cải thảo non</h3>\r\n<p><strong>Nguyên liệu:</strong> 200g thịt bò, 1 cây cải thảo non, tỏi băm, nước tương, dầu hào, dầu ô liu, bột bắp, tiêu.</p>\r\n<p><strong>Cách làm:</strong> Thịt bò thái lát mỏng, ướp gia vị trong 15 phút. Cải thảo cắt miếng lót dưới đáy đĩa, rải thịt bò lên trên. Hấp trong khoảng 12-15 phút kể từ khi nước sôi.</p>\r\n<p><strong>Thành phẩm:</strong> Cải thảo giữ độ giòn ngọt, thịt bò mềm đậm đà không mùi tanh, hương vị thanh mát cân bằng.</p>\r\n\r\n<h3>5. Trứng hấp phi lê cá</h3>\r\n<p><strong>Nguyên liệu:</strong> 100g phi lê cá (cá trắm hoặc cá vược), 2 quả trứng gà, gừng, hành lá, 120ml nước ấm.</p>\r\n<p><strong>Cách làm:</strong> Cá thái mỏng, ướp gừng, hành, dầu ăn và bột bắp trong 10 phút. Trứng đánh đều với chút muối và nước ấm, lọc qua rây. Hấp trứng 8 phút cho đặc lại rồi đặt cá lên, hấp tiếp 10 phút. Rưới thêm nước tương và hành lá khi hoàn thành.</p>\r\n<p><strong>Thành phẩm:</strong> Cá mềm tan, không xương; trứng mịn như bánh pudding thấm vị cá tươi ngon.</p>\r\n', 'published', '2025-11-06 06:00:00', 1, '2026-01-16 20:56:08');

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notification
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `total_price` decimal(10, 2) NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `address_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `address_id`(`address_id` ASC) USING BTREE,
  CONSTRAINT `fk3_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, '101', 33, 250000.00, 'Đang Giao', '2026-01-23 08:04:43', '2026-01-23 10:10:44', 1);

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `order_id` int NOT NULL,
  `item_id` int NOT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `quantity` decimal(10, 2) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`order_id`, `item_id`) USING BTREE,
  INDEX `item_id`(`item_id` ASC) USING BTREE,
  CONSTRAINT `fk2_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk3_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_item
-- ----------------------------
INSERT INTO `order_item` VALUES (1, 1, 50000.00, 5.00, '2026-01-23 08:05:15');

-- ----------------------------
-- Table structure for origin
-- ----------------------------
DROP TABLE IF EXISTS `origin`;
CREATE TABLE `origin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of origin
-- ----------------------------
INSERT INTO `origin` VALUES (1, 'Việt Nam', NULL, '2025-12-26 17:35:37', '2025-12-26 17:35:37');
INSERT INTO `origin` VALUES (2, 'Mỹ', '', '2025-12-27 21:37:14', '2025-12-27 21:37:14');
INSERT INTO `origin` VALUES (3, 'Úc', '', '2025-12-27 21:45:51', '2025-12-27 21:45:51');
INSERT INTO `origin` VALUES (4, 'Hàn Quốc', '', '2025-12-27 21:54:49', '2026-01-23 10:21:34');

-- ----------------------------
-- Table structure for stock_history
-- ----------------------------
DROP TABLE IF EXISTS `stock_history`;
CREATE TABLE `stock_history`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NULL DEFAULT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(10, 2) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `created_by` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`item_id` ASC) USING BTREE,
  INDEX `created_by`(`created_by` ASC) USING BTREE,
  CONSTRAINT `fk4_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stock_history
-- ----------------------------

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hotline` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tax_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `facebook` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `instagram` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `logo_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `created_by`(`created_by` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, 'Clean Meat', 'nmhau2410@gmail.com', '0962967942', '12344', 'https://www.facebook.com/nmhau2410', 'https://www.instagram.com/_nmh2410', 'Đai học Nông Lâm TP.HCM', '', 1);

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10, 2) NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of unit
-- ----------------------------
INSERT INTO `unit` VALUES (1, '250g', 250.00, '2025-12-29 19:55:45', '2025-12-29 19:55:45');
INSERT INTO `unit` VALUES (2, '500g', 500.00, '2025-12-29 00:00:00', '2025-12-29 21:25:58');
INSERT INTO `unit` VALUES (3, '1kg', 1000.00, '2025-12-29 00:00:00', '2025-12-29 21:26:00');
INSERT INTO `unit` VALUES (4, '2kg', 2000.00, '2025-12-29 00:00:00', '2025-12-29 21:32:01');
INSERT INTO `unit` VALUES (5, '3kg', 3000.00, '2025-12-29 00:00:00', '2025-12-29 21:31:51');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT ' ',
  `birthday` date NULL DEFAULT '2005-02-02',
  `role` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'user',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT ' ',
  `created_at` datetime NULL DEFAULT current_timestamp(),
  `updated_at` datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `status` bit(1) NULL DEFAULT b'0',
  `email_verified` tinyint(1) NULL DEFAULT 0,
  `verify_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (29, 'Nguyễn Văn A', 'admin@gmail.com', '123456', '0962967942', ' ', '2005-02-02', 'customer', '', '2025-12-24 13:17:11', '2026-01-23 08:01:40', b'0', 0, NULL);
INSERT INTO `user` VALUES (33, 'Nguyễn Minh Hậu', 'nmhau2410@gmail.com', 'f5f7d95f9e47cc35e188e0b076152faf', NULL, NULL, NULL, 'admin', NULL, '2026-01-23 01:25:43', '2026-01-23 01:26:46', b'1', 1, NULL);

SET FOREIGN_KEY_CHECKS = 1;
