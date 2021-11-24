import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/enum/order_stock_goods_type.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/page/stock/create/controller/confim_controller.dart';
import 'package:haidai_flutter_module/page/stock/model/res/order_stock_new_do.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

class StockController extends SuperController {
  ConfirmController confirmController = Get.find<ConfirmController>();

  ///参数===================
  ///正品 还是次品
  var orderStockGoodsType = OrderStockGoodsTypeEnum.NORMAL;

  ///订单 类型
  var orderStockType = OrderStockTypeEnum.ADJUST;

  /// 统计显示文字
  String staticTitle = '出库';
  String confirmButtonText = "出库";

  /// 是否可加可减
  bool negative = false;

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
  int minusNumTotal = 0;

  ///总款数
  int styleTotal = 0;
  int minusStyleTotal = 0;

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
      OrderStockNewDoGoods stockNewDoGoods = new OrderStockNewDoGoods();
      stockNewDoGoods.storeGoodsBaseDo = value.goods;
      stockNewDoGoods.addNum = 0;
      stockNewDoGoods.subtractNum = 0;
      stockNewDoGoods.goodsId = value.goods.id;
      data.add(stockNewDoGoods);
      //添加sku
      skuMap[value.goods.id as int] = value.storeGoodsVos.map((v) => v.toJson()).toList();
      selectMap[value.goods.id as int] = 0;
      eventBus.fire(new AddGoodsEvent(value.goods.id as int));

      //更新搜索
      updateSearchMap();
    }
    update(['noGoods']);
  }

  updateSearchMap() {
    searchParam[Constant.SELECT_MAP] = GoodsListController.map2String(selectMap);
  }

  deleteGoods(int goodsId) {
    selectMap.remove(goodsId);
    skuMap.remove(goodsId);
    updateSearchMap();
    //从新计算总数
    //更新总数
    numTotal = 0;
    styleTotal = 0;
    if (data.length > 0) {
      for (var item in data) {
        if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
          if (item.addNum != 0) {
            styleTotal += 1;
            numTotal += item.addNum as int;
          }
        }
      }
    }
    if (negative == true) {
      //证明是调整，要计算负数
      minusNumTotal = 0;
      minusStyleTotal = 0;
      for (var item in data) {
        if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
          if (item.subtractNum != 0) {
            minusStyleTotal += 1;
            minusNumTotal += item.subtractNum as int;
          }
        }
      }
    }
    update(['stockTotal', 'noGoods']);
  }

  //当数字变化  计算
  calculate(int goodsId, int index, int itemAdd, int itemMinus) {
    selectMap[goodsId] = itemAdd - itemMinus;
    //更新总数
    numTotal = 0;
    styleTotal = 0;
    if (data.length > 0) {
      for (var item in data) {
        if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
          if (item.goodsId == goodsId) {
            item.addNum = itemAdd;
          }
          if (item.addNum != 0) {
            styleTotal += 1;
            numTotal += item.addNum as int;
          }
        }
      }
    }
    if (negative == true) {
      //证明是调整，要计算负数
      minusNumTotal = 0;
      minusStyleTotal = 0;
      for (var item in data) {
        if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
          if (item.goodsId == goodsId) {
            item.subtractNum = itemMinus;
          }
          if (item.subtractNum != 0) {
            minusStyleTotal += 1;
            minusNumTotal += item.subtractNum.abs() as int;
          }
        }
      }
    }

    //更新货品ui,总数ui
    update(['goodsAddNum' + goodsId.toString(), 'stockTotal']);
    //更新搜索
    updateSearchMap();
  }

  /// 提交数据
  confirm() {
    List<OrderStockNewDoGoods> goods = [];
    for (var item in data) {
      if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
        if (item.addNum != 0 || item.subtractNum != 0) {
          goods.add(item);
        }
      }
    }
    confirmController.confirm(goods, skuMap).then((v) {
      if (v != -1) {
        //跳转到库存单详情
        if (confirmController.oldStock != null) {
          //证明是修改直接 返回
          Get.back(result: v);
        } else {
          //跳转到库存单详情
          Map<String, dynamic> param = new Map();
          param[Constant.DEPT_ID] = confirmController.deptId;
          param[Constant.ORDER_STOCK_ID] = v;
          Get.offAndToNamed(ArgUtils.map2String(path: Routes.STOCK_DETAIL, arguments: param));
        }
      }
      print(v);
    });
  }

  checkGoodsInit() {
    if (confirmController.goods != null) {
      //如果是 货品带入
      addGoods(confirmController.goods);
    }
  }

  init() async {
    await confirmController.init();
    negative = confirmController.negative;

    if (confirmController.oldStock != null) {
      numTotal = confirmController.oldStock!.addNum ?? 0;
      minusNumTotal = confirmController.oldStock!.subtractNum ?? 0;
      if (!negative) {
        minusNumTotal = -minusNumTotal;
      }

      //证明是 修改，那么要初始化数据
      for (var item in confirmController.oldStock!.goods!) {
        int stockNum = 0;
        int substandardNum = 0;
        var skus = item.orderGoodsVoList;

        if (skus != null) {
          for (int i = 0; i < skus.length; i++) {
            for (int j = 0; j < skus[i].sizes!.length; j++) {
              if (skus[i].sizes![j].data!.stockNum != null) {
                stockNum += skus[i].sizes![j].data!.stockNum ?? 0;
                substandardNum += skus[i].sizes![j].data!.substandardNum ?? 0;
              }
            }
          }
        }

        item.storeGoodsBaseDo!.stockNum = stockNum;
        item.storeGoodsBaseDo!.substandardNum = substandardNum;
        data.add(item);
        item.addNum = item.addNum ?? 0;
        if (item.addNum! > 0) {
          styleTotal += 1;
        }
        if (item.subtractNum! < 0) {
          minusStyleTotal += 1;
        }
        item.subtractNum = item.subtractNum ?? 0;

        selectMap[item.storeGoodsBaseDo!.id as int] = item.addNum! - item.subtractNum!;
        skuMap[item.storeGoodsBaseDo!.id as int] = skus!.map((v) => v.toJson()).toList();
        if (!negative && item.subtractNum != null) {
          item.subtractNum = -item.subtractNum!;
        }
      }
      //更新搜索
      updateSearchMap();
      update(['stockTotal']);
    }

    //初始化
    orderStockGoodsType = confirmController.orderStockGoodsType;
    orderStockType = confirmController.orderStockType;
    staticTitle = confirmController.staticTitle;
    confirmButtonText = confirmController.confirmButtonText;

    searchParam[Constant.DEPT_ID] = confirmController.deptId ?? 6;
    searchParam[Constant.GOODS_TYPE] =
        orderStockGoodsType == OrderStockGoodsTypeEnum.NORMAL || orderStockType == OrderStockTypeEnum.SUBSTANDARD_RECORD
            ? GoodsListController.TYPE_STOCK
            : GoodsListController.TYPE_STOCK_SUBSTANDARD;
    searchParam[GoodsListController.PARAM_SELECT_ALL] = orderStockType == OrderStockTypeEnum.DIRECT_IN;
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
