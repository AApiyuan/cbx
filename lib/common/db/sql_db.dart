library sqldb;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:flustars/flustars.dart';
import 'package:haidai_flutter_module/common/oss/aliyun_oss.dart';
import 'package:haidai_flutter_module/model/customer_dept_offline_do.dart';
import 'package:haidai_flutter_module/model/enum/config_group_type.dart';
import 'package:haidai_flutter_module/model/enum/customer_dept_type.dart';
import 'package:haidai_flutter_module/model/enum/dicount_template.dart';
import 'package:haidai_flutter_module/model/enum/offline_type.dart';
import 'package:haidai_flutter_module/model/enum/status.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/customer_dept_offline_req.dart';
import 'package:haidai_flutter_module/model/rep/goods_page_param.dart';
import 'package:haidai_flutter_module/model/rep/store_goods_sku_req_entity.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/model/store/req/customer_dept_config_req.dart';
import 'package:haidai_flutter_module/model/store/req/dept_and_relation_req.dart';
import 'package:haidai_flutter_module/model/store/req/store_discount_template_req.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_config_do.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_detail_and_role_do.dart';
import 'package:haidai_flutter_module/model/store/res/store_discount_template_do.dart';
import 'package:haidai_flutter_module/model/store/res/store_remit_method_do.dart';
import 'package:haidai_flutter_module/page/customer/model/rep/store_customer_page_req_entity.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';
import 'package:haidai_flutter_module/repository/base/store.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';
import 'package:haidai_flutter_module/repository/offline_api.dart';
import 'package:haidai_flutter_module/repository/oss.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

part 'query/customer_query.dart';
part 'query/dept_config_query.dart';
part 'query/discount_query.dart';
part 'query/goods_query.dart';
part 'query/pull_log_query.dart';
part 'query/remit_query.dart';
part 'query/dept_query.dart';
part 'table/sql_table.dart';
part 'utils/db_util.dart';
part 'utils/file.dart';
part 'utils/read_utils.dart';

Database? db;

const dbTestMode = true;
Map<int, List<String>> dbDownload = {};

//初始化离线数据
Future<void> loadData(int deptId) async {
  dbDownload[deptId] = [];
  await GoodsQuery.init(deptId);
  await CustomerQuery.init(deptId);
  await DeptConfigQuery.init(deptId);
  await DiscountQuery.init(deptId);
  await RemitQuery.init(deptId);
}

Future<void> loadDataTest(int deptId) async {
  await GoodsQuery.init(deptId);
  testGoods(deptId);
  testSku(deptId,5);

  await CustomerQuery.init(deptId);
  testCustomer(deptId);

  await DeptConfigQuery.init(deptId);
  testConfig(deptId);

  await DiscountQuery.init(deptId);
  testDiscount(deptId);

  await RemitQuery.init(deptId);
  testRemit(deptId);
}

//测试 商品
testGoods(int deptId) async {
  BasePage basePage1 = new BasePage();
  List<Goods> data = await GoodsApi.page(basePage1, online: false);
  print("=============结果");
  print(data.toString());
  print(data.length);
  BasePage basePage = new BasePage();

  GoodsPageParam goodsPageParam = new GoodsPageParam();
  goodsPageParam.deptId = 6;
  goodsPageParam.goodsNameSerial = "1";
  basePage.param = goodsPageParam;
  basePage.pageSize = 10;
  basePage.pageNo = 1;
  basePage.param = goodsPageParam;
  List<Goods> data1 = await GoodsApi.page(basePage, online: false);
  print("=============结果");
  print(json.encode(data1));
  print(data1.length);
}

testSku(int deptId, int goodsId) async {
  var params = StoreGoodsSkuReqEntity();
  params.deptId = deptId;
  params.goodsId = goodsId;
  List<SkuInfoEntity> skus = await GoodsApi.getSkuList(params, online: false);
  print(skus);
}

//测试 客户
testCustomer(int deptId) async {
  BasePage basePage1 = new BasePage();
  List<Goods> data = await GoodsApi.page(basePage1, online: false);
  print("=============结果");
  print(data.toString());
  print(data.length);
  BasePage basePage = new BasePage();

  StoreCustomerPageReqEntity param = new StoreCustomerPageReqEntity();
  param.deptId = 6;
  basePage.param = param;
  basePage.pageSize = 10;
  basePage.pageNo = 1;
  basePage.param = param;
  List<StoreCustomerListItemDoEntity> data1 = await CustomerApi.customerPage(basePage, online: false);
  print("=============结果");
  print(json.encode(data1));
  print(data1.length);
}

//测试配置
testConfig(int deptId) async {
  CustomerDeptConfigReq param = new CustomerDeptConfigReq();
  param.customerDeptId = deptId;
  param.groupTypeList = [CustomerDeptConfigGroupEnum.PRINT];
  var result = await StoreApi.getDeptConfig(param, online: false);
  print(result);
}

//测试打折
testDiscount(int deptId) async {
  StoreDiscountTemplateReq param = new StoreDiscountTemplateReq();
  param.customerDeptId = deptId;
  param.style = StoreDiscountTemplateEnum.CLEARANCE;
  var result = await StoreApi.getDiscountTemp(param, online: false);
  print(result);
}

//测试支付方式
testRemit(int deptId) async {
  var result = await StoreApi.getRemitMethod(deptId, false, online: false);
  print(result);
}
