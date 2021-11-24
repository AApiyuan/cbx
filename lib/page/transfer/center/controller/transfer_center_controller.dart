import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/substandard.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_status.dart';
import 'package:haidai_flutter_module/page/transfer/model/req/select_relation_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_count_param_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_list_count_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_list_do_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_page_param_entity.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:intl/intl.dart';

class TransferCenterController extends SuperController {
  // final state = Transfer_centerState();
  TransferListCountEntity countEntity = TransferListCountEntity();
  final int stockInDeptId = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();

  var groupValue = 0;
  var topIndex = 0;

  // 单据状态
  List<bool> docStateList = [false, false, false, false];

  // 是否撤销
  List<bool> revocationList = [true, false];

  // 是否差异
  List<bool> differencesList = [false, false];

  // 他店选择的id
  int? selectedHisShopId;

  // 货品选择的id
  int? selectedGoodId;

  // 开始日期
  DateTime? startDate;

  // 结束日期
  DateTime? endDate;

  //title
  var barTitle = "调拨中心";
  var data;

  List<TransferListDoEntity> directStockOutdata = [];
  List<TransferListDoEntity> distributeOutdata = [];
  List<TransferListDoEntity> applyStockOutdata = [];
  List<TransferListDoEntity> substandardOutdata = [];

  List<TransferListDoEntity> directStockIndata = [];
  List<TransferListDoEntity> distributeIndata = [];
  List<TransferListDoEntity> applyStockIndata = [];
  List<TransferListDoEntity> substandardIndata = [];

  var distributionInPage = 1;
  var directInPage = 1;
  var applyInPage = 1;
  var substandardInPage = 1;

  var distributionOutPage = 1;
  var directOutPage = 1;
  var applyOutPage = 1;
  var substandardOutPage = 1;
  var canceled;
  var difference;

  var lastListType;
  var lastCtr;

  late TabController tabController;
  var distributionCtr;
  var directCtr;
  var applyCtr;
  var substandardCtr;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startDate = DateTime.now().add(new Duration(days: -29));
    endDate = DateTime.now();
    canceled = true;
    difference = false;
    if (ArgUtils.getArgument2num("TransferOrderType") != null) {
      groupValue = ArgUtils.getArgument2num("TransferOrderType")!.toInt();
      topIndex = ArgUtils.getArgument2num("TransferSelectType")!.toInt();
    }
  }

  void pageRefresh(String listType, EasyRefreshController ctr, {bool refresh = false}) {
    if (groupValue == 0) {
      if (listType == 'DISTRIBUTION') {
        distributionInPage = 1;
      }
      if (listType == 'DIRECT') {
        directInPage = 1;
      }
      if (listType == 'APPLY') {
        applyInPage = 1;
      }
      if (listType == 'SUBSTANDARD') {
        substandardInPage = 1;
      }
    } else {
      if (listType == 'DISTRIBUTION') {
        distributionOutPage = 1;
      }
      if (listType == 'DIRECT') {
        directOutPage = 1;
      }
      if (listType == 'APPLY') {
        applyOutPage = 1;
      }
      if (listType == 'SUBSTANDARD') {
        substandardOutPage = 1;
      }
    }
    loadListData(listType, ctr, 1, refresh: refresh);
  }

  void loadMore(String listType, EasyRefreshController ctr) {
    var page = 1;
    if (groupValue == 0) {
      if (listType == 'DISTRIBUTION') {
        distributionInPage++;
        page = distributionInPage;
      }
      if (listType == 'DIRECT') {
        directInPage++;
        page = directInPage;
      }
      if (listType == 'APPLY') {
        applyInPage++;
        page = applyInPage;
      }
      if (listType == 'SUBSTANDARD') {
        substandardInPage++;
        page = substandardInPage;
      }
    } else {
      if (listType == 'DISTRIBUTION') {
        distributionOutPage++;
        page = distributionOutPage;
      }
      if (listType == 'DIRECT') {
        directOutPage++;
        page = directOutPage;
      }
      if (listType == 'APPLY') {
        applyOutPage++;
        page = applyOutPage;
      }
      if (listType == 'SUBSTANDARD') {
        substandardOutPage++;
        page = substandardOutPage;
      }
    }
    loadListData(listType, ctr, page);
  }

  void loadListData(String listType, EasyRefreshController ctr, int page, {bool refresh = false}) {
    BasePage basePage = new BasePage();
    var status = [];
    if (docStateList[0] == true) {
      status.add("WAIT_STOCK_OUT");
    }
    if (docStateList[1] == true) {
      status.add("WAIT_STOCK_IN");
    }
    if (docStateList[2] == true) {
      status.add("STOCK_IN");
    }
    if (docStateList[3] == true) {
      status.add("FINISH");
    }

    TransferPageParamEntity param = new TransferPageParamEntity();
    param.statusEnumList = status.cast<String>();
    param.selectType = listType;
    param.goodsId = selectedGoodId;
    param.otherDeptId = selectedHisShopId;
    if (startDate != null) {
      String startDateString = DateFormat("yyyy-MM-dd").format(startDate!).toString();
      String endDateString = DateFormat("yyyy-MM-dd").format(endDate!).toString();
      param.startDate = startDateString;
      param.endDate = endDateString;
    }

    if ((differencesList[0] == true && differencesList[1] == true) || (differencesList[0] == false && differencesList[1] == false)) {
      param.difference = 'ALL';
    } else if (differencesList[0] == true) {
      param.difference = 'DIFFERENCE';
    } else {
      param.difference = 'NO_DIFFERENCE';
    }

    if ((revocationList[0] == true && revocationList[1] == true) || (revocationList[0] == false && revocationList[1] == false)) {
      param.canceled = 'ALL';
    } else if (revocationList[0] == true) {
      param.canceled = 'ENABLE';
    } else {
      param.canceled = 'CANCELED';
    }

    if (groupValue == 0) {
      param.stockInDeptId = stockInDeptId;
      basePage.pageNo = page;
    } else {
      param.stockOutDeptId = stockInDeptId;
      basePage.pageNo = page;
    }

    basePage.pageSize = 15;
    basePage.param = param;
    TransferApi.getTransferList(basePage).then((entity) {
      if (groupValue == 0) {
        if (listType == 'DISTRIBUTION') {
          if (basePage.pageNo == 1) {
            distributeIndata = [];
          }
          distributeIndata.addAll(entity);
        }
        if (listType == 'DIRECT') {
          if (basePage.pageNo == 1) {
            directStockIndata = [];
          }
          directStockIndata.addAll(entity);
        }
        if (listType == 'APPLY') {
          if (basePage.pageNo == 1) {
            applyStockIndata = [];
          }
          applyStockIndata.addAll(entity);
        }
        if (listType == 'SUBSTANDARD') {
          if (basePage.pageNo == 1) {
            substandardIndata = [];
          }
          substandardIndata.addAll(entity);
        }
      } else {
        if (listType == 'DISTRIBUTION') {
          if (basePage.pageNo == 1) {
            distributeOutdata = [];
          }
          distributeOutdata.addAll(entity);
        }
        if (listType == 'DIRECT') {
          if (basePage.pageNo == 1) {
            directStockOutdata = [];
          }
          directStockOutdata.addAll(entity);
        }
        if (listType == 'APPLY') {
          if (basePage.pageNo == 1) {
            applyStockOutdata = [];
          }
          applyStockOutdata.addAll(entity);
        }
        if (listType == 'SUBSTANDARD') {
          if (basePage.pageNo == 1) {
            substandardOutdata = [];
          }
          substandardOutdata.addAll(entity);
        }
      }
      lastListType = listType;
      lastCtr = ctr;
      ctr.resetLoadState();
      ctr.finishLoad(noMore: entity.length < 15);
      update(['TransferCenterController' + lastListType]);
      if (refresh == true) {
        loadTransferListCount();
      }
    });
  }

  void loadTransferListCount() {
    var status = [];
    if (docStateList[0] == true) {
      status.add("WAIT_STOCK_OUT");
    }
    if (docStateList[1] == true) {
      status.add("WAIT_STOCK_IN");
    }
    if (docStateList[2] == true) {
      status.add("STOCK_IN");
    }
    if (docStateList[3] == true) {
      status.add("FINISH");
    }

    TransferCountParamEntity countParam = new TransferCountParamEntity();
    countParam.deptId = stockInDeptId;
    countParam.goodsId = selectedGoodId;
    countParam.statusEnumList = status.cast<String>();
    countParam.otherDeptId = selectedHisShopId;

    if (startDate != null) {
      String startDateString = DateFormat("yyyy-MM-dd").format(startDate!).toString();
      String endDateString = DateFormat("yyyy-MM-dd").format(endDate!).toString();
      countParam.startDate = startDateString;
      countParam.endDate = endDateString;
    }
    if ((differencesList[0] == true && differencesList[1] == true) || (differencesList[0] == false && differencesList[1] == false)) {
      countParam.difference = 'ALL';
    } else if (differencesList[0] == true) {
      countParam.difference = 'DIFFERENCE';
    } else {
      countParam.difference = 'NO_DIFFERENCE';
    }

    if ((revocationList[0] == true && revocationList[1] == true) || (revocationList[0] == false && revocationList[1] == false)) {
      countParam.canceled = 'ALL';
    } else if (revocationList[0] == true) {
      countParam.canceled = 'ENABLE';
    } else {
      countParam.canceled = 'CANCELED';
    }

    TransferApi.getTransferListCount(countParam).then((value) {
      var countModel = TransferListCountEntity();
      countModel.stockOutNum = value['stockOutNum'];
      countModel.directStockOutNum = value['directStockOutNum'];
      countModel.distributeOutNum = value['distributeOutNum'];
      countModel.applyStockOutNum = value['applyStockOutNum'];
      countModel.substandardOutNum = value['substandardOutNum'];
      countModel.stockInNum = value['stockInNum'];
      countModel.distributeInNum = value['distributeInNum'];
      countModel.directStockInNum = value['directStockInNum'];
      countModel.applyStockInNum = value['applyStockInNum'];
      countModel.substandardInNum = value['substandardInNum'];
      countEntity = countModel;
      update(["TransferCenterPageTitle", "TransferCenterTop", 'TransferCenterController' + lastListType]);
    });
  }

  List<TransferListDoEntity> currentData(String listType) {
    if (groupValue == 0) {
      if (listType == 'DISTRIBUTION') {
        return distributeIndata;
      }
      if (listType == 'DIRECT') {
        return directStockIndata;
      }
      if (listType == 'APPLY') {
        return applyStockIndata;
      }
      if (listType == 'SUBSTANDARD') {
        return substandardIndata;
      }
    } else {
      if (listType == 'DISTRIBUTION') {
        return distributeOutdata;
      }
      if (listType == 'DIRECT') {
        return directStockOutdata;
      }
      if (listType == 'APPLY') {
        return applyStockOutdata;
      }
      if (listType == 'SUBSTANDARD') {
        return substandardOutdata;
      }
    }
    return [];
  }

  Future<List<SelectRelationEntity>> loadHisShop() {
    return TransferApi.getSelectRelationByCustomerDeptId(stockInDeptId);
  }

  // 日期 转 字符串
  String dateTurnString() {
    if (startDate == null) {
      return '全部';
    } else {
      return "${startDate!.month}.${startDate!.day}-${endDate!.month}.${endDate!.day}";
    }
  }

//跳转到创建或者修改调拨单
  toTransferCreateOrUpdate(
      {String substandard = SubstandardEnum.NO,
      String orderTransferType = TransferOrderTypeEnum.APPLY,
      List<int>? stockIds,
      TransferListDoEntity? transfer,bool showAllSku = false}) {
    Map<String, dynamic> param = new Map();
    param[Constant.DEPT_ID] = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();
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
            pageRefresh(lastListType, lastCtr, refresh: true);
          }
        });
        return;
      }
    }
    if(showAllSku){
      param[Constant.SHOW_ALL_SKU] = 'true';
    }else{
      param[Constant.SHOW_ALL_SKU] = 'false';
    }
    Get.toNamed(ArgUtils.map2String(path: Routes.TRANSFER, arguments: param))!.then((value) {
      if (value == 'Refresh' || value == 0) {
        pageRefresh(lastListType, lastCtr, refresh: true);
      }
    });
  }

  toSelectStock() {
    Map<String, dynamic> param = new Map();
    param[Constant.DEPT_ID] = stockInDeptId;
    Get.toNamed(ArgUtils.map2String(path: Routes.STOCK_SELECT, arguments: param))!.then((value) {
      if (value != null) {
        toTransferCreateOrUpdate(substandard: SubstandardEnum.NO, orderTransferType: TransferOrderTypeEnum.DIRECT, stockIds: value);
      }
    });

    // Get.toNamed(ArgUtils.map2String(path: Routes.HELP,arguments: {Constant.DEPT_ID: stockInDeptId}));
    // Get.toNamed(ArgUtils.map2String(path: Routes.BI_DEPT_SALE, arguments: {Constant.DEPT_ID: stockInDeptId}));
  }

  //跳转调拨单详情
  toTransferDetail(int orderTransferId) {
    Map<String, dynamic> param = new Map();
    param[Constant.DEPT_ID] = stockInDeptId;
    param[Constant.ORDER_TRANSFER_ID] = orderTransferId;
    Get.toNamed(ArgUtils.map2String(path: Routes.TRANSFER_DETAIL, arguments: param));
  }

  //完成调拨单
  Future<bool> toFinish(int id, {bool isDelivery = false}) {
    return TransferApi.finishTransfer(id as int, isDelivery: isDelivery, showLoading: true).then((value) {
      pageRefresh(lastListType, lastCtr, refresh: true);
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

// init() {}
}
