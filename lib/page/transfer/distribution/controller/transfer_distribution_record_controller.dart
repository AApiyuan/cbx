import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/transfer/center/controller/transfer_center_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/substandard.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_list_do_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_page_param_entity.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

class TransferDistributionRecordController extends SuperController {
  var stockOutDeptId;
  var stockInDeptId;
  var orderSaleId;
  var customerId;
  var data = [];
  var pageNo = 1; //页码
  var pageSize = 60; //页数
  var count = 0; //页数
  var notPrint = false; //页数
  //title
  var barTitle = "调拨中心";
  var deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    stockOutDeptId = ArgUtils.getArgument2num(Constant.STOCK_OUT_DEPT_ID, def: -1)!.toInt();
    stockInDeptId = ArgUtils.getArgument2num(Constant.STOCK_IN_DEPT_ID, def: -1)!.toInt();
    orderSaleId = ArgUtils.getArgument2num(Constant.ORDER_SALE_ID, def: -1)!.toInt();
    customerId = ArgUtils.getArgument2num(Constant.CUSTOMER_ID, def: -1)!.toInt();
    loadListData();
  }

  void loadListData() {
    BasePage basePage = new BasePage();
    basePage.pageSize = 9999;
    var param = TransferPageParamEntity();
    if (stockOutDeptId != -1) {
      param.stockOutDeptId = stockOutDeptId;
    }
    if (stockInDeptId != -1) {
      param.stockInDeptId = stockInDeptId;
    }
    if (customerId != -1) {
      param.customerId = customerId;
      param.statusEnumList = ["WAIT_STOCK_IN", "STOCK_IN"];
      param.canceled = "ENABLE";
    }
    if (orderSaleId != -1) {
      param.orderSaleId = orderSaleId;
    }
    param.deptId = deptId;
    param.selectType = 'DISTRIBUTION';
    basePage.param = param;
    TransferApi.getTransferList(basePage).then((entity) {
      if (pageNo == 1) {
        data = entity;
      } else {
        data.addAll(entity);
      }
      update(["transferListSwitch"]);
      update(['TransferDistributionRecord']);
    });
  }

//跳转调拨单详情
  toTransferDetail(int orderTransferId) {
    Map<String, dynamic> param = new Map();
    if (stockInDeptId != -1) {
      param[Constant.DEPT_ID] = stockInDeptId;
    } else {
      param[Constant.DEPT_ID] = stockOutDeptId;
    }
    param[Constant.ORDER_TRANSFER_ID] = orderTransferId;
    Get.toNamed(ArgUtils.map2String(path: Routes.TRANSFER_DETAIL, arguments: param));
  }

  toTransferCreateOrUpdate(
      {String substandard = SubstandardEnum.NO,
      String orderTransferType = TransferOrderTypeEnum.APPLY,
      List<int>? stockIds,
      TransferListDoEntity? transfer}) {
    Map<String, dynamic> param = new Map();
    if (stockInDeptId != -1) {
      param[Constant.DEPT_ID] = stockInDeptId;
    } else {
      param[Constant.DEPT_ID] = stockOutDeptId;
    }
    // param[Constant.DEPT_ID] = stockOutDeptId;
    param[Constant.SUBSTANDARD] = substandard;
    if (transfer != null) {
      param[Constant.ORDER_TRANSFER_ID] = transfer.id;
    }
    if (stockIds != null) {
      param[Constant.COPY_STOCK_IDS] = stockIds;
    }
    param[Constant.ORDER_TRANSFER_TYPE] = orderTransferType;
    if (transfer != null) {
      if (transfer.orderSaleId != null) {
        param[Constant.DISTRIBUTE_DEPT_ID] = transfer.stockOutDeptId;
        param[Constant.ORDER_SALE_ID] = transfer.orderSaleId;
        Get.toNamed(ArgUtils.map2String(path: Routes.DISTRIBUTION, arguments: param))!.then((value) {
          if (value == 'Refresh') {
            loadListData();
          }
        });
        return;
      }
    }
    Get.toNamed(ArgUtils.map2String(path: Routes.TRANSFER, arguments: param))!.then((value) {
      if (value == 'Refresh') {
        loadListData();
      }
    });
  }

  //完成调拨单
  Future<bool> toFinish(int id, {bool isDelivery = false}) {
    return TransferApi.finishTransfer(id as int, isDelivery: isDelivery, showLoading: true).then((value) {
      loadListData();
      return value;
    }, onError: (t) {});
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
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

  init() {}
}
