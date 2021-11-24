import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/customer_user_do.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/order_stock_goods_type.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/page/stock/model/res/order_stock_new_do.dart';
import 'package:haidai_flutter_module/page/transfer/create/controller/confirm_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/substandard.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_status.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_do.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';
import 'package:haidai_flutter_module/repository/order/stock_api.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class StockDetailController extends SuperController {
  var deptId; // 店铺id
  var orderStockId; //库存单id
  OrderStockNewDo? oldStock;

  ///参数===================
  bool isAdjust = false;

  ///正品 还是次品
  var substandard;

  ///订单 类型
  var thirdTagName;
  var thirdTag;
  var thirdTagColor;
  var navigateThird = false;
  var fourTag;
  var fourTagName;
  var fourTagColor;
  var navigateFour = false;

  //title
  var barTitle = "调拨";
  var showCopy = false;
  var canceled = false;

  ///UI控制===================

  ///列表数据
  List<dynamic> data = [];

  ///记录所有sku 键值是goodsId
  Map<int, List> skuMap = new Map();

  Map<int, bool> openStatus = new Map();
  bool allOpenStatus = false;

  ///总件数
  int numTotal = 0;

  ///总款数
  int styleTotal = 0;

  List<dynamic> getData() {
    return data;
  }

  var editOrderId;

  //跳转编辑
  toEdit() {
    Map<String, dynamic> param = new Map();
    param[Constant.DEPT_ID] = deptId;
    param[Constant.ORDER_STOCK_ID] = oldStock!.id;
    Get.toNamed(ArgUtils.map2String(path: Routes.STOCK, arguments: param))!.then((value) {
      if (value != null) {
        editOrderId = value;
        update(['StockPage']);
      }
    });
  }

  init() async {
    // if (orderStockId != null && editOrderId == null) {
    //   //从打印 回原生，不处理
    //   return;
    // }
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID, def: -1)?.toInt();
    // deptId = 6;
    orderStockId = ArgUtils.getArgument2num(Constant.ORDER_STOCK_ID, def: -1)?.toInt();
    if (editOrderId != null) {
      orderStockId = editOrderId;
    }
    oldStock = await StockApi.orderStockDetail(orderStockId, getAllSku: false, showLoading: true);
    if (oldStock!.canceled == CanceledEnum.CANCELED) {
      canceled = true;
    }
    data.clear();
    skuMap.clear();
    for (var item in oldStock!.goods!) {
      var skus = item.orderGoodsVoList;
      data.add(item);
      skuMap[item.storeGoodsBaseDo!.id as int] = skus!.map((v) => v.toJson()).toList();
    }
    if (oldStock!.orderGoodsType == OrderStockGoodsTypeEnum.NORMAL) {
      thirdTag = "goodsNum";
      thirdTagName = "数量";
      thirdTagColor = ColorConfig.color_1678ff;
      if (oldStock!.orderType == OrderStockTypeEnum.DIRECT_IN) {
        barTitle = '入库';
        showCopy = true;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.DIRECT_OUT) {
        barTitle = '出库';
      }
      if (oldStock!.orderType == OrderStockTypeEnum.ADJUST) {
        barTitle = '库存调整';
        isAdjust = true;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.BACK_IN) {
        barTitle = '退货入库';
        showCopy = true;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.DELIVER_OUT) {
        barTitle = '发货出库';
      }
      if (oldStock!.orderType == OrderStockTypeEnum.TRANSFER_IN) {
        barTitle = '正品调入';
        showCopy = true;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.TRANSFER_OUT) {
        barTitle = '正品调出';
      }
      if (oldStock!.orderType == OrderStockTypeEnum.DISTRIBUTION_OUT) {
        barTitle = '配货出库';
      }
      if (oldStock!.orderType == OrderStockTypeEnum.DISTRIBUTION_IN) {
        barTitle = '配货入库 ';
        showCopy = true;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.INVENTORY_ADJUST) {
        barTitle = '正品盘点调整 ';
        isAdjust = true;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.EXCHANGE_ADJUST) {
        barTitle = '改码调整';
        isAdjust = true;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_RECORD) {
        barTitle = '记录次品';
        thirdTag = "goodsNum";
        thirdTagName = "正品";
        thirdTagColor = ColorConfig.color_1678ff;
        navigateThird = true;
        fourTag = "goodsNum";
        fourTagName = "次品";
        fourTagColor = ColorConfig.color_FA6400;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_RECOVER) {
        barTitle = '次品复原';
        thirdTag = "goodsNum";
        thirdTagName = "正品";
        thirdTagColor = ColorConfig.color_1678ff;
        fourTag = "goodsNum";
        fourTagName = "次品";
        navigateFour = true;
        fourTagColor = ColorConfig.color_FA6400;
        showCopy = true;
      }
    } else {
      thirdTag = "goodsNum";
      thirdTagName = "数量";
      thirdTagColor = ColorConfig.color_1678ff;
      if (oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_RECORD) {
        barTitle = '记录次品';
        thirdTag = "goodsNum";
        thirdTagName = "正品";
        navigateThird = true;
        thirdTagColor = ColorConfig.color_1678ff;
        fourTag = "goodsNum";
        fourTagName = "次品";
        fourTagColor = ColorConfig.color_FA6400;
        showCopy = true;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_RECOVER) {
        barTitle = '次品复原';
        thirdTag = "goodsNum";
        thirdTagName = "正品";
        thirdTagColor = ColorConfig.color_1678ff;
        fourTag = "goodsNum";
        fourTagName = "次品";
        navigateFour = true;

        fourTagColor = ColorConfig.color_FA6400;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_ADJUST) {
        barTitle = '次品调整';
        isAdjust = true;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_OUT) {
        barTitle = '次品出库';
      }
      if (oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_BACK) {
        barTitle = '次品退货';
        showCopy = true;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_TRANSFER_IN) {
        barTitle = '次品调入';
        showCopy = true;
      }
      if (oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_TRANSFER_OUT) {
        barTitle = '次品调出';
      }
      if (oldStock!.orderType == OrderStockTypeEnum.INVENTORY_SUBSTANDARD_ADJUST) {
        barTitle = '次品盘点调整';
        isAdjust = true;
      }
    }
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
    init();
  }
}
