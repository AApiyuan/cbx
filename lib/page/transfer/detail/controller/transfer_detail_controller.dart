import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/customer_user_do.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/page/transfer/create/controller/confirm_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/substandard.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_status.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_do.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class TransferDetailController extends SuperController {
  var deptId; // 店铺id
  var orderTransferId; //调拨单id
  TransferDo? orderTransfer;
  CustomerUserDo? customerUserDo;

  ///参数===================
  ///正品 还是次品
  var substandard;

  ///订单 类型
  var handleTag;
  var thirdTagName;
  var thirdTag;
  var thirdTagColor;
  var fourTag;
  var fourTagName;
  var fourTagColor;
  var fiveTag;
  var fiveTagName;
  var fiveTagColor;
  var compareTag;
  var comparedTag;

  //title
  var barTitle = "调拨";
  var canceled = false;

  ///UI控制===================
  var showEdit = false;

  ///添加的每一个数据的量，
  Map<int, int> selectMap = new Map();

  ///搜索数据
  Map<String, dynamic> searchParam = new Map();

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

  //跳转编辑
  toEdit({bool showAllSku = false}) {
    Map<String, dynamic> param = new Map();
    param[Constant.DEPT_ID] = deptId;
    param[Constant.ORDER_TRANSFER_ID] = orderTransfer!.id;
    if (orderTransfer!.orderSaleId == null) {
      if (showAllSku) {
        param[Constant.SHOW_ALL_SKU] = "true";
      } else {
        param[Constant.SHOW_ALL_SKU] = "false";
      }
      Get.toNamed(ArgUtils.map2String(path: Routes.TRANSFER, arguments: param))!.then((value) {
        if (value != null) {
          update(['TransferPage']);
        }
      });
    } else {
      param[Constant.ORDER_SALE_ID] = orderTransfer!.orderSaleId;
      param[Constant.DISTRIBUTE_DEPT_ID] = orderTransfer!.stockOutDeptId;
      Get.toNamed(ArgUtils.map2String(path: Routes.DISTRIBUTION, arguments: param))!.then((value) {
        if (value != null) {
          update(['TransferPage']);
        }
      });
    }
  }

  //完成  调拨 单
  toFinish({bool isDelivery = false}) {
    TransferApi.finishTransfer(orderTransfer!.id as int, isDelivery: isDelivery, showLoading: true).then((v) {
      //完成调拨单后的操作
      update(['TransferPage']);
    });
  }

  init() async {
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID, def: -1)?.toInt();
    // deptId = 6;
    orderTransferId = orderTransferId != null ? orderTransferId : ArgUtils.getArgument2num(Constant.ORDER_TRANSFER_ID, def: -1)?.toInt();
    // orderTransferId = 33301;
    orderTransfer = await TransferApi.orderTransferDetail(orderTransferId, deptId, showLoading: true);
    if (orderTransfer!.canceled == CanceledEnum.CANCELED) {
      canceled = true;
    }
    customerUserDo = await UserApi.getUser();

    data.clear();
    skuMap.clear();
    for (var item in orderTransfer!.goods!) {
      var skus = item.orderGoodsVoList;
      data.add(item);
      skuMap[item.storeGoodsBaseDo!.id as int] = skus!.map((v) => v.toJson()).toList();
    }
    if (orderTransfer!.orderSaleId != null) {
      barTitle = "配货调拨";
      //这种是配货
      if (orderTransfer!.status == TransferStatusEnum.STOCK_IN || orderTransfer!.status == TransferStatusEnum.FINISH) {
        //如果处在已入库或者完成，那么，显示 出库数和入库数
        thirdTag = "stockOutNum";
        thirdTagName = "出库数";
        fourTag = "stockInNum";
        fourTagName = "入库数";
        compareTag = "fourTag";
        comparedTag = "thirdTag";
      } else if (orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_IN) {
        //等待入库
        thirdTag = "stockOutNum";
        thirdTagName = "出库数";
        thirdTagColor = ColorConfig.color_1678ff;
        if (orderTransfer!.stockOutDeptId == deptId) {
          //出库方
          showEdit = true;
        }
      }
    } else {
      //普通调拨单
      barTitle = orderTransfer!.substandard == SubstandardEnum.NO ? "正品直接调拨" : "次品直接调拨";
      //申请
      if (orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_OUT) {
        //等待出库
        thirdTag = "applyNum";
        thirdTagName = "申请数";
        thirdTagColor = ColorConfig.color_1678ff;
        barTitle = "申请调拨";
        if (orderTransfer!.stockInDeptId == deptId) {
          //申请方
          showEdit = true;
        }
      } else if (orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_IN) {
        //已出库等待入库
        if (orderTransfer!.orderType == TransferOrderTypeEnum.APPLY) {
          thirdTag = "applyNum";
          thirdTagName = "申请数";
          fourTag = "stockOutNum";
          fourTagName = "出库数";
          fourTagColor = ColorConfig.color_1678ff;
        } else {
          thirdTag = "stockOutNum";
          thirdTagName = "出库数";
          thirdTagColor = ColorConfig.color_1678ff;
          if (orderTransfer!.stockOutDeptId == deptId) {
            //出库方
            showEdit = true;
          }
        }
      } else if (orderTransfer!.status == TransferStatusEnum.STOCK_IN || orderTransfer!.status == TransferStatusEnum.FINISH) {
        //如果处在已入库或者完成，那么，显示 出库数和入库数
        if (orderTransfer!.orderType == TransferOrderTypeEnum.APPLY) {
          thirdTag = "applyNum";
          thirdTagName = "申请数";
          fourTag = "stockOutNum";
          fourTagName = "出库数";
          fiveTag = "stockInNum";
          fiveTagName = "入库数";
          compareTag = "fiveTag";
          comparedTag = "fourTag";
        } else {
          thirdTag = "stockOutNum";
          thirdTagName = "出库数";
          fourTag = "stockInNum";
          fourTagName = "入库数";
          compareTag = "fourTag";
          comparedTag = "thirdTag";
        }
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
