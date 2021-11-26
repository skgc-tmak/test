USE salesworker;

SET CHARACTER_SET_CLIENT = utf8;
SET CHARACTER_SET_CONNECTION = utf8;

DROP TABLE IF EXISTS `estimates`;

CREATE TABLE `estimates` (
  `id` bigint NOT NULL AUTO_INCREMENT comment '見積ID',
  `name` varchar(255) DEFAULT NULL comment '案件名',
  `amount` bigint DEFAULT NULL comment '見積金額',
  `budgeted_amount` bigint DEFAULT NULL comment '予算金額',
  `customer_cd` bigint DEFAULT NULL comment '顧客コード',
  `employee_cd` bigint DEFAULT NULL comment '従業員コード',
  `date` datetime DEFAULT NULL comment '見積日',
  `status` varchar(255) DEFAULT NULL comment '見積ステータス',
  `order_id` bigint DEFAULT NULL comment '受注ID',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci 
comment = '見積'
;

insert into salesworker.estimates(amount,budgeted_amount,customer_cd,`date`,employee_cd,name,order_id,status) values 
(5378,1000,'1',null,'1','新規オフィス',0,'1'),
(129420,120000,'3',null,'3','仮店舗設営',0,'1'),
(259400,500000,'2',null,'6','直営エステサロンの新規出店（東片端）',0,'1'),
(70720,1600000,'3',null,'6','選挙事務所の備品購入',1,'1'),
(36336,720000,'4',null,'5','オフィスフロア拡張に伴う事務用品購入',2,'1'),
(261600,110000,'5',null,'2','デスク類の買い替え',3,'1')
;

DROP TABLE IF EXISTS `estimate_details`;

CREATE TABLE `estimate_details` (
  `id` bigint NOT NULL AUTO_INCREMENT comment '見積明細ID',
  `sub_id` varchar(255) DEFAULT NULL comment '見積明細枝番',
  `estimate_id` bigint DEFAULT NULL comment '見積ID',
  `product_cd` bigint DEFAULT NULL comment '商品コード',
  `quantity` bigint DEFAULT NULL comment '数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
comment='見積明細'
;

insert into salesworker.estimate_details(estimate_id,product_cd,quantity,sub_id) values 
(1,'2',2,'1'),
(1,'3',1,'2'),
(3,'6',4,'1'),
(3,'8',6,'2'),
(3,'2',20,'3'),
(2,'8',11,'2'),
(2,'5',2,'2'),
(1,'1',3,'3'),
(2,'3',5,'3'),
(3,'8',4,'4'),
(4,'4',4,'2'),
(4,'7',4,'2'),
(5,'8',2,'2'),
(5,'5',1,'2'),
(5,'3',2,'2'),
(6,'5',8,'2'),
(6,'4',12,'2')
;

DROP TABLE IF EXISTS `mst_products`;

CREATE TABLE `mst_products` (
  `cd` bigint NOT NULL AUTO_INCREMENT comment '商品コード',
  `name` varchar(255) DEFAULT NULL comment '商品名',
  `price` bigint DEFAULT NULL comment '価格',
  PRIMARY KEY (`cd`)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
comment='商品マスタ'
;

insert into salesworker.mst_products(name,price) values
('ふせん 75×25mm 4色アソート 20冊',610),
('3M ポスト・イット 見出し 再生紙 ミックス4色 700RP-K',280),
('コピーペーパーEX A4 500枚×10冊',2988),
('アイリスチトセ 平机 W1000×D700×H700 ホワイト RSD-H107',11800),
('不二貿易 平机100 W1000×D700×H700 ブラウン KH100',15000),
('プラス Try ローバック スモークブラックシェル×座ブラック アジャスト肘',44250),
('ナカバヤシ OAネットチェア肘付 ブラック CNN-003D',5880),
('アストロクロスパーティション H1200×W700 ライトグレー',7680)
;

DROP TABLE IF EXISTS `mst_customers`;

CREATE TABLE `mst_customers` (
  `cd` bigint NOT NULL AUTO_INCREMENT comment '顧客コード',
  `name` varchar(255) DEFAULT NULL comment '顧客名',
  PRIMARY KEY (`cd`)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
comment='顧客マスタ'
;

insert into salesworker.mst_customers(name) values 
('株式会社オースタイル'),
('ビッグアドバンス株式会社'),
('株式会社 日本井出オール'),
('キャットピープル株式会社'),
('片山一郎'),
('名古屋ドイツ大使館'),
('私立ひばりが丘中学校')
;

DROP TABLE IF EXISTS `mst_employees`;

CREATE TABLE `mst_employees` (
  `cd` bigint NOT NULL AUTO_INCREMENT comment '従業員コード',
  `name` varchar(255) DEFAULT NULL comment '従業員名',
  PRIMARY KEY (`cd`)
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
comment='従業員マスタ'
;

insert into salesworker.mst_employees(name) values 
('小野田真理子'),
('鳴海成子'),
('加賀諒介'),
('半沢龍二'),
('ニコライ・カサートキン'),
('湯山隆'),
('鬼塚恭平')
;

ALTER TABLE `estimates` ADD CONSTRAINT `estimates_ibfk_1` FOREIGN KEY (customer_cd) REFERENCES mst_customers(cd) ON DELETE CASCADE ON UPDATE CASCADE
;
ALTER TABLE `estimates` ADD CONSTRAINT `employees_ibfk_2` FOREIGN KEY (employee_cd) REFERENCES mst_employees(cd) ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE `estimate_details` ADD CONSTRAINT `estimate_details_ibfk_1` FOREIGN KEY (estimate_id) REFERENCES estimates(id) 
;
ALTER TABLE `estimate_details` ADD CONSTRAINT `estimate_details_ibfk_2` FOREIGN KEY (product_cd) REFERENCES mst_products(cd) 
;
