part of '../sql_db.dart';

class SqlTable {
  //数据拉取记录表
  static final String sql_createTable_pull_log = """
    CREATE TABLE `pull_log` (
    `deptId` bigint(20) DEFAULT NULL ,
    `type` bigint(20) DEFAULT NULL ,
    `offlineTime` varchar(128) DEFAULT NULL,
    primary key(deptId,type)
    );
    """;

  //客户
  static final String sql_createTable_customer = """
    CREATE TABLE `customer` (
    `id` bigint(20) NOT NULL PRIMARY KEY ,
    `deptId` bigint(20) DEFAULT NULL ,
    `merchandiserId` bigint(20) DEFAULT NULL ,
    `managerUserName` varchar(128) DEFAULT NULL ,
    `customerName` varchar(128) DEFAULT NULL ,
    `customerNamePinYin` varchar(128) DEFAULT NULL ,
    `customerPhone` varchar(32) DEFAULT NULL ,
    `customerNamePhone` varchar(128) DEFAULT NULL,
    `star` tinyint(1) DEFAULT 0 ,
    `levelTag` tinyint(1) DEFAULT NULL,
    `userId` bigint(20) DEFAULT NULL ,
    `offline` int(1) DEFAULT 0
    );
    """;

  //商品
  static final String sql_createTable_goods = """
    CREATE TABLE `goods` (
  `id` bigint(20) NOT NULL ,
  `deptId` bigint(20) NOT NULL ,
  `topDeptId` bigint(20) DEFAULT NULL ,
  `goodsSerial` varchar(32) DEFAULT NULL ,
  `goodsName` varchar(256) DEFAULT NULL ,
  `goodsNameSerial` varchar(512) DEFAULT NULL ,
  `imgPath` varchar(512) DEFAULT NULL ,
  `sailingPrice` int(11) DEFAULT NULL ,
  `takingPrice` int(11) DEFAULT NULL ,
  `packagePrice` int(11) DEFAULT NULL ,
  `costPrice` int(11) DEFAULT NULL ,
  `cover` varchar(128) DEFAULT NULL ,
  `status` tinyint(1) DEFAULT NULL ,
  `sku` TEXT DEFAULT NULL,
   primary key(id, deptId)
  );
  """;

  //优惠模板
  static final String sql_createTable_discount = """
    CREATE TABLE `discount` (
  `id` bigint(20) NOT NULL ,
  `deptId` bigint(20) NOT NULL ,
  `topDeptId` bigint(20) DEFAULT NULL ,
  `style` varchar(128) DEFAULT NULL ,
  `status` varchar(128) DEFAULT NULL ,
  `enableNum` bigint(11) DEFAULT NULL ,
  `totalPrice` bigint(11) DEFAULT NULL ,
  `discountPrice` bigint(11) DEFAULT NULL ,
  primary key(id)
  );
  """;

  //收款方式
  static final String sql_createTable_remit = """
    CREATE TABLE `remit` (
  `id` bigint(20) NOT NULL ,
  `deptId` bigint(20) NOT NULL ,
  `topDeptId` bigint(20) DEFAULT NULL ,
  `remitMethodName` varchar(128) DEFAULT NULL ,
  primary key(id,deptId)
  );
  """;

  //店铺配置
  static final String sql_createTable_config = """
    CREATE TABLE `config` (
  `id` bigint(20) DEFAULT NULL,
  `deptId` bigint(20) NOT NULL,
  `groupType` varchar(128) DEFAULT NULL ,
  `type` varchar(128) DEFAULT NULL ,
  `configDateType` varchar(128) DEFAULT NULL ,
  `configDate` TEXT DEFAULT NULL ,
  primary  key(deptId,type)
  );
  """;

  //挂单数据
  static final String sql_createTable_hang_order = """
    CREATE TABLE `hang_order` (
  `id` bigint(20) NOT NULL,
  `saleReq` TEXT DEFAULT NULL ,
  `saleBeforeReq` TEXT DEFAULT NULL ,
  `saleGoodsList` TEXT DEFAULT NULL ,
  `saleGoodsSku` TEXT DEFAULT NULL ,
  `returnGoodsList` TEXT DEFAULT NULL ,
  `returnGoodsSku` TEXT DEFAULT NULL ,
  `oweGoodsList` TEXT DEFAULT NULL ,
  `oweGoodsSku` TEXT DEFAULT NULL ,
  `type` bigint(20) DEFAULT NULL,
  `customerId` bigint(20) DEFAULT NULL,
  `deptId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `updateTime` TEXT DEFAULT NULL ,
  `customer` TEXT DEFAULT NULL ,
  'remitAmountMap' TEXT DEFAULT NULL ,
  'remitMethodMap' TEXT DEFAULT NULL ,
  'offlineGatheringOrder' TEXT DEFAULT NULL ,
  primary  key(id)
  );
  """;

  //店铺数据
  static final String sql_createTable_dept = """
    CREATE TABLE `dept` (
  `id` bigint(20) DEFAULT NULL,
  `deptId` bigint(20) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `detail` TEXT NOT NULL ,
  primary  key(deptId, userId)
  );
  """;
}
