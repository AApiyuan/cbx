import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/distribution/controller/confirm_controller.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_do.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

class DistributionController extends SuperController {
  ConfirmController confirmController = Get.put(ConfirmController());

  TransferDo? orderTransfer;

  ///参数===================

  String? handleTag;
  String? thirdTagName;
  String? thirdTag;
  bool handleOverThird = true;
  String? thirdTagExtra;
  String? thirdTagNameExtra;

  /// 统计显示文字
  String staticTitle = '出库';
  String confirmButtonText = "出库";

  var appBarTitle; //标题

  var autoFinish= true.obs;

  ///UI控制===================

  ///添加的每一个数据的量，
  Map<int, int> selectMap = new Map();

  ///搜索数据
  Map<String, dynamic> searchParam = new Map();

  ///列表数据
  List<dynamic> data = [];

  ///记录所有sku 键值是goodsId
  Map<int, List> skuMap = new Map();

  ///总件数
  int numTotal = 0;

  ///总款数
  int styleTotal = 0;

  List<dynamic> getData() {
    return data;
  }

  Future<dynamic> searchGoods() async {
    Get.toNamed(ArgUtils.map2String(path: Routes.GOODS_LIST, arguments: searchParam));
  }

  //从货品页面添加货品并展开
  addGoods(GoodsSkuEntity value) {
    if (skuMap[value.goods.id] != null) {
      //已经添加过，滑动到指定 位置
      eventBus.fire(new AddGoodsEvent(value.goods.id as int, fixGoodsId: value.goods.id as int));
    } else {
      //添加 货品
      TransferDoGoods transferDoGoods = new TransferDoGoods();
      transferDoGoods.storeGoodsBaseDo = value.goods;
      transferDoGoods.applyNum = 0;
      transferDoGoods.stockInNum = 0;
      transferDoGoods.stockOutNum = 0;
      transferDoGoods.goodsId = value.goods.id;
      data.add(transferDoGoods);
      //添加sku
      skuMap[value.goods.id as int] = value.storeGoodsVos.map((v) => v.toJson()).toList();
      selectMap[value.goods.id as int] = 0;
      eventBus.fire(new AddGoodsEvent(value.goods.id as int));

      //更新搜索
      updateSearchMap();
    }
  }

  updateSearchMap() {
    searchParam[Constant.SELECT_MAP] = GoodsListController.map2String(selectMap);
  }

  //当数字变化  计算
  calculate(int goodsId, int index, int itemAdd, int itemMinus) {
    selectMap[goodsId] = itemAdd - itemMinus;
    //更新总数
    numTotal = 0;
    styleTotal = 0;
    if (data.length > 0) {
      for (var item in data) {
        if (item.runtimeType.toString() == "TransferDoGoods") {
          if (handleTag == "stockOutNum") {
            if (item.goodsId == goodsId) {
              item.stockOutNum = itemAdd;
            }
            if (item.stockOutNum != 0) {
              styleTotal += 1;
              numTotal += item.stockOutNum as int;
            }
          }
          if (handleTag == "stockInNum") {
            if (item.goodsId == goodsId) {
              item.stockInNum = itemAdd;
            }
            if (item.stockInNum != 0) {
              styleTotal += 1;
              numTotal += item.stockInNum as int;
            }
          }
        }
      }
    }

    //更新货品ui,总数ui
    update(['goodsAddNum' + goodsId.toString(), 'transferTotal']);
    //更新搜索
    updateSearchMap();
  }

  //填充数据，
  fillData() {
    skuMap.clear();
    numTotal = 0;
    styleTotal = 0;
    for (var item in confirmController.orderTransfer!.goods!) {
      styleTotal += 1;
      if (thirdTagName == "待配") {
        item.stockOutNum = item.notDistributionNum;
        numTotal += item.notDistributionNum as int;
      } else if (thirdTagName == '配出') {
        item.stockInNum = item.stockOutNum;
        numTotal += item.stockOutNum as int;
      }
      var skus = item.orderGoodsVoList;
      skus!.forEach((element) {
        element.sizes!.forEach((size) {
          if (thirdTagName == "待配") {
            size.data!.stockOutNum = size.data!.notDistributionNum;
          } else if (thirdTagName == '配出') {
            size.data!.stockInNum = size.data!.stockOutNum;
          }
        });
      });
      skuMap[item.storeGoodsBaseDo!.id as int] = skus.map((v) => v.toJson()).toList();
    }

    data.forEach((element) {
      if (element.runtimeType.toString() == "_InternalLinkedHashMap<dynamic, dynamic>" && element['itemType'] == 'sku') {
        element['handleTag'] = element['thirdTag'];
      }
    });
    //计算
    update(['transferList', 'transferTotal']);
  }

  /// 提交数据
  confirm() {
    List<TransferDoGoods> goods = [];
    for (var item in data) {
      if (item.runtimeType.toString() == "TransferDoGoods") {
        goods.add(item);
      }
    }
    confirmController.confirm(goods, skuMap, styleTotal, numTotal,autoFinish.value).then((v) {
      if (v != -1) {
        //跳转到调拨单详情
        if (orderTransfer!.id != -1) {
          Get.back(result: 'Refresh');
        } else {
          Map<String, dynamic> param = new Map();
          param[Constant.DEPT_ID] = confirmController.deptId;
          param[Constant.ORDER_TRANSFER_ID] = orderTransfer!.id;
          Get.offAndToNamed(ArgUtils.map2String(path: Routes.TRANSFER_DETAIL, arguments: param));
        }
      }
    });
  }

  init() async {
    //初始化单据信息
    await confirmController.init();

    handleTag = confirmController.handleTag;
    thirdTag = confirmController.thirdTag;
    thirdTagName = confirmController.thirdTagName;
    staticTitle = confirmController.staticTitle;
    confirmButtonText = confirmController.confirmButtonText;
    orderTransfer = confirmController.orderTransfer;
    handleOverThird = confirmController.handleOverThird;
    thirdTagExtra = confirmController.thirdTagExtra;
    thirdTagNameExtra = confirmController.thirdTagNameExtra;
    appBarTitle = confirmController.appBarTitle ?? '';

    //这里就是各种编辑
    for (var item in confirmController.orderTransfer!.goods!) {
      var skus = item.orderGoodsVoList;
      data.add(item);

      if (handleTag == "stockOutNum") {
        numTotal = confirmController.orderTransfer!.stockOutNum ?? 0;
        item.stockOutNum = item.stockOutNum ?? 0;
        if (item.stockOutNum! > 0) {
          styleTotal += 1;
        }
        selectMap[item.storeGoodsBaseDo!.id as int] = item.stockOutNum!;
      }

      if (handleTag == "stockInNum") {
        numTotal = confirmController.orderTransfer!.stockInNum ?? 0;

        item.stockInNum = item.stockInNum ?? 0;
        if (item.stockInNum! > 0) {
          styleTotal += 1;
        }
        selectMap[item.storeGoodsBaseDo!.id as int] = item.stockInNum!;
      }
      skuMap[item.storeGoodsBaseDo!.id as int] = skus!.map((v) => v.toJson()).toList();
    }
    //更新搜索
    updateSearchMap();
    update(['transferTotal']);

    searchParam[Constant.DEPT_ID] = confirmController.deptId;
    searchParam[Constant.GOODS_TYPE] = GoodsListController.TYPE_TRANSFER;
    searchParam[Constant.SELECT_MAP] = GoodsListController.map2String(selectMap);
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
    print("onDetached");
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
    print("onInactive");
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
    print("onPaused");
  }

  @override
  void onResumed() {
    print("onResumed调用 了");
  }
}
