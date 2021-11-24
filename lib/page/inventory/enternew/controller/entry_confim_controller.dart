import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enter/inventory_record_create_req_entity.dart';
import 'package:haidai_flutter_module/model/enter/store_goods_base_do_entity.dart';
import 'package:haidai_flutter_module/model/enum/dict_type.dart';
import 'package:haidai_flutter_module/model/enum/order_stock_goods_type.dart';
import 'package:haidai_flutter_module/model/enum/select_type.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/inventory_record_update_req_entity.dart';
import 'package:haidai_flutter_module/model/rep/store_goods_sku_req_entity.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/stock/model/enum/order_stock_status.dart';
import 'package:haidai_flutter_module/page/stock/model/req/batch_stock_rep.dart';
import 'package:haidai_flutter_module/page/stock/model/res/order_stock_new_do.dart';
import 'package:haidai_flutter_module/repository/base/store.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';
import 'package:haidai_flutter_module/repository/order/inventory_api.dart';
import 'package:haidai_flutter_module/repository/order/stock_api.dart';
import 'package:haidai_flutter_module/page/inventory/enternew/controller/inventoryentry_controller.dart';
class EntryConfirmController extends SuperController {
  var orderStockId;
  var goods;
  OrderStockNewDo? oldStock;
  var deptId; // 店铺id
  var orderStockGoodsType;
  var orderId;
  var recordId;
  ///订单 类型
  var orderStockType;

  List<GoodsSkuEntity> goodsSkuEntityList = [];

  TextEditingController orderRemarkController = new TextEditingController();
  TextEditingController changeReasonController = new TextEditingController();

  /// 标签类型
  String tagName = "入库标签";
  String tagType = DictTypeEnum.WARE_HOUSING;
  List<StoreDictData> tagList = [];
  int? selectTagId = -1;

  /// 统计显示文字
  String staticTitle = '出库';
  String confirmButtonText = "出库";

  /// 是否可加可减
  bool negative = false;

  /// 日期
  DateTime? selectDate;

  //获取标签
  Future getTag() async {
    if (tagList.length == 0) {
      tagList = await StoreApi.getDeptDict(deptId!, tagType);
    }
  }

  choseTag(int id) {
    selectTagId = id;
    update(['tagView']);
  }

  ///创建订单
  ///订单id，人员id，店铺id，是否是次品
  Future createOrder(int orderId, int deptId, bool substandard, List<OrderStockNewDoGoods> goods, Map<int, List> skulist) {
    InventoryRecordCreateReqEntity createReq = InventoryRecordCreateReqEntity();
    createReq.deptId = deptId;
    createReq.orderInventoryId = orderId;
    // if(recordId != -1){
    //   createReq.id = recordId;
    // }
    createReq.orderGoodsType = substandard
        ? OrderStockGoodsTypeEnum.SUBSTANDARD
        : OrderStockGoodsTypeEnum.NORMAL;
    List<InventoryGoodsReq> goodsList = [];
    goods.forEach((element) {
      List<InventorySkuReq> skuList = [];
      for (int i = 0; i < skulist[element.goodsId]!.length; i++) {
        for (int j = 0; j < skulist[element.goodsId]![i]['sizes'].length; j++) {
          if (skulist[element.goodsId]![i]['sizes'][j]['data']['goodsNum'] != null && skulist[element.goodsId]![i]['sizes'][j]['data']['goodsNum'] != 0) {
            InventorySkuReq skuReq = InventorySkuReq();
            skuReq.goodsNum = skulist[element.goodsId]![i]['sizes'][j]['data']['goodsNum'];
            skuReq.skuId = skulist[element.goodsId]![i]['sizes'][j]['data']['skuId'];
            skuList.add(skuReq);
            print("flutter_tag==============${skuReq.skuId}===${skuReq.goodsNum}");
          }
        }
      }
      InventoryGoodsReq goodsReq = InventoryGoodsReq();
      goodsReq.goodsId = element.goodsId;
      goodsReq.skuList = skuList;
      goodsList.add(goodsReq);
    });
    createReq.goodsList = goodsList;

    if(recordId != -1){
      createReq.id = recordId;
    }
    return InventoryApi.createInventoryRecord(createReq)
        .then((value){
      toastMsg("创建成功");
      Get.back(result: "update");
    });
  }

  ///创建订单
  ///订单id，人员id，店铺id，是否是次品
  Future updateOrder(int orderId, int deptId, bool substandard, List<OrderStockNewDoGoods> goods, Map<int, List> skulist) {
    InventoryRecordUpdateReqEntity updateReq = InventoryRecordUpdateReqEntity();

    updateReq.id = recordId;
    List<InventoryRecordUpdateReqGoodsList> goodsList = [];
    goods.forEach((element) {
      List<InventoryRecordUpdateReqGoodsListSkuList> skuList = [];
      for (int i = 0; i < skulist[element.goodsId]!.length; i++) {
        for (int j = 0; j < skulist[element.goodsId]![i]['sizes'].length; j++) {
          if (skulist[element.goodsId]![i]['sizes'][j]['data']['goodsNum'] != null && skulist[element.goodsId]![i]['sizes'][j]['data']['goodsNum'] != 0) {
            InventoryRecordUpdateReqGoodsListSkuList skuReq =
            InventoryRecordUpdateReqGoodsListSkuList();
            skuReq.goodsNum = skulist[element.goodsId]![i]['sizes'][j]['data']['goodsNum'];
            skuReq.skuId = skulist[element.goodsId]![i]['sizes'][j]['data']['skuId'];
            skuList.add(skuReq);
            print("flutter_tag==============${skuReq.skuId}===${skuReq.goodsNum}");
          }
        }
      }
      InventoryRecordUpdateReqGoodsList goodsReq =
      InventoryRecordUpdateReqGoodsList();
      goodsReq.goodsId = element.goodsId;
      goodsReq.skuList = skuList;
      goodsList.add(goodsReq);
    });
    updateReq.goodsList = goodsList;
    return InventoryApi.updateInventoryRecord(updateReq)
        .then((value){
      toastMsg("创建成功");
      Get.back(result: "update");
    });
  }


  //提交数据
  Future<int> confirm(int orderId, List<OrderStockNewDoGoods> goods, Map<int, List> map) async {
    if (goods.length == 0) {
      toastMsg("数量不能为空");
      return -1;
    }
    //构建主数据
    BatchStockRep batchStockRep = new BatchStockRep();
    batchStockRep.deptId = deptId;
    batchStockRep.stockChangeType = orderStockType;
    batchStockRep.orderGoodsType = orderStockGoodsType;
    batchStockRep.status = OrderStockStatusEnum.FINISH;
    //构建sku
    if (map.isEmpty) {
      return -1;
    }
    if (orderStockId != -1) {
      batchStockRep.id = orderStockId;
    }

    List<BatchStockRepGoods> goodsData = [];

    BatchStockRepGoods batchStockRepGoods;
    BatchStockRepGoodsSkus batchStockRepGoodsSkus;
    goods.forEach((element) {
      batchStockRepGoods = new BatchStockRepGoods();
      batchStockRepGoods.goodsId = element.goodsId;
      batchStockRepGoods.remark = element.remark;
      List<BatchStockRepGoodsSkus>? skus = [];
      for (int i = 0; i < map[element.goodsId]!.length; i++) {
        for (int j = 0; j < map[element.goodsId]![i]['sizes'].length; j++) {
          if (map[element.goodsId]![i]['sizes'][j]['data']['goodsNum'] != null && map[element.goodsId]![i]['sizes'][j]['data']['goodsNum'] != 0) {
            batchStockRepGoodsSkus = new BatchStockRepGoodsSkus();
            batchStockRepGoodsSkus.num = map[element.goodsId]![i]['sizes'][j]['data']['goodsNum'];
            batchStockRepGoodsSkus.skuId = map[element.goodsId]![i]['sizes'][j]['data']['skuId'];
            skus.add(batchStockRepGoodsSkus);
          }
        }
        batchStockRepGoods.skus = skus;
      }
      goodsData.add(batchStockRepGoods);
    });

    batchStockRep.goods = goodsData;

    //构建附件数据
    BatchStockRepExtra batchStockRepExtra = new BatchStockRepExtra();
    if (negative) {
      //调整
      if (changeReasonController.text == "") {
        toastMsg("调整原因不能为空");
        return -1;
      }
      batchStockRepExtra.changeReason = changeReasonController.text;
    } else {
      //备注
      batchStockRepExtra.remark = orderRemarkController.text;
    }
    if (selectTagId != -1) {
      batchStockRepExtra.orderLabel = selectTagId;
    }
    if (selectDate == null) {
      batchStockRepExtra.customizeTime = DateUtil.getNowDateStr();
    } else {
      batchStockRepExtra.customizeTime = DateUtil.formatDate(selectDate);
    }
    batchStockRep.extra = batchStockRepExtra;

    return await StockApi.updateStock(batchStockRep, showLoading: true);
  }

  Future init() async {

    orderStockId = ArgUtils.getArgument2num(Constant.ORDER_STOCK_ID, def: -1)?.toInt();

    // if (recordId == -1) {
    //   //新建
    //   orderStockGoodsType = ArgUtils.getArgument(Constant.ORDER_STOCK_GOODS_TYPE) ?? OrderStockGoodsTypeEnum.NORMAL;
    //   orderStockType = ArgUtils.getArgument(Constant.ORDER_STOCK_TYPE) ?? OrderStockTypeEnum.ADJUST;
    // } else {
    //   // getOrderGoods(orderId: recordId);
    // }



    var goodsId = ArgUtils.getArgument2num(Constant.GOODS_ID, def: -1)?.toInt();
    if (goodsId != -1) {
      var page = new BasePage();
      Map<String, dynamic> param = new Map();
      page.pageNo = 1;
      page.pageSize = 10;
      param['deptId'] = deptId;
      param['goodsIds'] = [goodsId];
      param['selectType'] = SelectType.BASIC_STATIC;
      page.param = param;
      List<Goods> res = await GoodsApi.page(page);
      var params = StoreGoodsSkuReqEntity();
      params.goodsId = goodsId;
      params.deptId = deptId;
      params.returnStock = true;
      var value = await GoodsApi.getSkuList(params, showLoading: true);
      goods = GoodsSkuEntity(res[0], value, SaleDetailDoSaleGoodsList());
    }

  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
