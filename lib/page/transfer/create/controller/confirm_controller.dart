import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/customer_user_do.dart';
import 'package:haidai_flutter_module/model/remark.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/distribution.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/substandard.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_status.dart';
import 'package:haidai_flutter_module/page/transfer/model/req/transfer_req.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_do.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';

class ConfirmController extends SuperController {
  var deptId; // 店铺id
  var stockOutDeptId; //出库方店铺
  var stockInDeptId; //入库方店铺;
  CustomerUserDo? customerUserDo;
  var copyStockIds;
  var showAllSku;

  //当前页面处于什么状态 有 apply , stockOut ,stockIn
  var curPageState;
  var curPageOperation; // 操作有 createDirectStockOut，updateDirect ，createApply，updateApply，stockIn，applyStockOut

  //是否可以编辑对方店仓，决定了是否可以切换店铺；
  var isEditSelectDept;

  //是否显示*号，只有创建的或者发起人的时候才显示
  var showImportant = false;
  var showGoodsBar;

  var orderTransferId;
  TransferDo? orderTransfer;
  var selectDeptId; //选择的 关联店仓
  var selectDeptName = ""; //关联仓名称；
  List<Remark> remarks = [];

  var substandard; //正品还是次品
  var orderTransferType; //直接还是申请
  var handleTag; //操作标签
  var thirdTagName = '';
  var thirdTag = '';
  bool handleOverThird = true;
  String thirdTagExtra = '';
  String thirdTagNameExtra = '';

  /// 日期
  DateTime? selectDate;

  /// 确定标签显示文字
  String staticTitle = '出库';
  String confirmButtonText = "出库";
  String appBarTitle = "";


  TextEditingController orderRemarkController = new TextEditingController();

  Future init() async {
    if (orderTransferId != null) {
      //从打印 回原生，不处理
      return;
    }
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID, def: -1)?.toInt();
    // deptId = 6;
    orderTransferId = ArgUtils.getArgument2num(Constant.ORDER_TRANSFER_ID, def: -1)?.toInt();
    // orderTransferId = 33001;
    substandard = ArgUtils.getArgument(Constant.SUBSTANDARD) ?? SubstandardEnum.NO;
    orderTransferType = ArgUtils.getArgument(Constant.ORDER_TRANSFER_TYPE) ?? TransferOrderTypeEnum.APPLY;
    showAllSku = ArgUtils.getArgument(Constant.SHOW_ALL_SKU) ?? 'false';

    if (orderTransferId != -1) {
      orderTransfer =
          await TransferApi.orderTransferDetail(orderTransferId, deptId, getAllSku: showAllSku == 'false' ? false : true, showLoading: true);
      customerUserDo = await UserApi.getUser();

      stockOutDeptId = orderTransfer!.stockOutDeptId;
      stockInDeptId = orderTransfer!.stockInDeptId;
      remarks = orderTransfer!.remarks as List<Remark>;
      selectDate = DateUtil.getDateTime(orderTransfer!.customizeTime!);

      orderTransferType = orderTransfer!.orderType;
      substandard = orderTransfer!.substandard;
    }

    if (ArgUtils.getArgument(Constant.COPY_STOCK_IDS) != null) {
      //如果是复制库存单调拨单
      copyStockIds = jsonDecode(ArgUtils.getArgument(Constant.COPY_STOCK_IDS) as String).cast<int>();
      orderTransfer = await TransferApi.mergeOrderStockSku(copyStockIds, getAllSku: true, showLoading: true);
      orderTransferType = TransferOrderTypeEnum.DIRECT;
      substandard = orderTransfer!.substandard;
    }
    if (orderTransferType == TransferOrderTypeEnum.APPLY) {
      //如果是申请 ，则默认 是正品
      substandard = SubstandardEnum.NO;
    }

    //直接调拨
    if (orderTransferType == TransferOrderTypeEnum.DIRECT) {
      if (stockOutDeptId == null) {
        //出库方是空，那么证明是创建直接调拨单
        staticTitle = '出库';
        handleTag = "stockOutNum";
        isEditSelectDept = true;
        showImportant = true;
        showGoodsBar = true;
        curPageState = "stockOut";
        curPageOperation = "createDirectStockOut";
        if (substandard == SubstandardEnum.NO) {
          thirdTag = "stockNum";
          thirdTagName = "正品库存";
          confirmButtonText = "调拨出库";
          appBarTitle = "直接调拨出库";
        } else {
          thirdTag = "substandardNum";
          thirdTagName = "次品库存";
          confirmButtonText = "调拨出库";
          appBarTitle = "次品调拨出库";
        }
      } else {
        if (deptId == stockOutDeptId) {
          //说明这个是创建完直接调拨单的编辑
          staticTitle = '出库';
          handleTag = "stockOutNum";
          //需要判断单据状态，如果对方已经入库，则 不能修改入库方
          if (orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_IN) {
            isEditSelectDept = true;
            showImportant = true;
            showGoodsBar = true;
          } else {
            isEditSelectDept = false;
            showImportant = false;
            showGoodsBar = false;
          }
          curPageState = "stockOut";
          curPageOperation = "updateDirect";
          selectDeptId = orderTransfer!.stockInDeptId;
          selectDeptName = orderTransfer!.stockInDeptName as String;

          if (substandard == SubstandardEnum.NO) {
            thirdTag = "stockNum";
            thirdTagName = "正品库存";
            confirmButtonText = "调拨出库";
            appBarTitle = "直接调拨出库";
          } else {
            thirdTag = "substandardNum";
            thirdTagName = "次品库存";
            confirmButtonText = "调拨出库";
            appBarTitle = "次品调拨出库";
          }
        } else {
          //这个是入库方入库界面
          staticTitle = '入库';
          handleTag = "stockInNum";
          //需要判断单据状态，如果对方已经入库，则 不能修改入库方
          isEditSelectDept = false;
          showImportant = false;
          showGoodsBar = false;
          curPageState = "stockIn";
          curPageOperation = "stockIn";
          thirdTag = "stockOutNum";
          thirdTagName = "出库";
          // handleOverThird = false; //入库数不能大于出库数
          if (substandard == SubstandardEnum.NO) {
            confirmButtonText = "调拨入库";
            appBarTitle = "调拨入库";
          } else {
            confirmButtonText = "次品调拨入库";
            appBarTitle = "调拨入库";
          }
          selectDeptId = orderTransfer!.stockOutDeptId;
          selectDeptName = orderTransfer!.stockOutDeptName as String;
        }
      }
    } else {
      //申请调拨
      if (stockOutDeptId == null) {
        //出库方是空，那么证明是创建申请调拨单
        staticTitle = '申请';
        handleTag = "applyNum";
        isEditSelectDept = true;
        showImportant = true;
        showGoodsBar = true;
        curPageState = "apply";
        curPageOperation = "createApply";

        thirdTag = "stockNum";
        thirdTagName = "正品库存";
        confirmButtonText = "申请调拨";
        appBarTitle = "申请调拨";
      } else {
        if (deptId == stockOutDeptId) {
          //说明在出库界面
          staticTitle = '出库';
          handleTag = "stockOutNum";
          isEditSelectDept = false;
          showImportant = false;
          showGoodsBar = false;
          curPageState = "stockOut";
          curPageOperation = "applyStockOut";
          thirdTag = "applyNum";
          thirdTagName = "申请";
          thirdTagExtra = "stockNum";
          thirdTagNameExtra = "库存";
          confirmButtonText = "调拨出库";
          appBarTitle = "调拨出库";
          selectDeptId = orderTransfer!.stockInDeptId;
          selectDeptName = orderTransfer!.stockInDeptName as String;
        } else if (deptId == stockInDeptId) {
          if (orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_OUT) {
            //如果对方已经出库，则 不能修改出库方
            staticTitle = '申请';
            handleTag = "applyNum";
            isEditSelectDept = true;
            showImportant = true;
            showGoodsBar = true;
            curPageState = "apply";
            curPageOperation = "updateApply";
            thirdTag = "stockNum";
            thirdTagName = "正品库存";
            confirmButtonText = "申请调拨";
            appBarTitle = "申请调拨";
            selectDeptId = orderTransfer!.stockOutDeptId;
            selectDeptName = orderTransfer!.stockOutDeptName as String;
          } else if (orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_IN || orderTransfer!.status == TransferStatusEnum.STOCK_IN) {
            //如入库
            staticTitle = '入库';
            handleTag = "stockInNum";
            isEditSelectDept = false;
            showImportant = false;
            showGoodsBar = false;
            curPageState = "stockIn";
            curPageOperation = "stockIn";
            thirdTag = "stockOutNum";
            thirdTagName = "出库";
            thirdTagExtra = "applyNum";
            thirdTagNameExtra = "申请";
            confirmButtonText = "调拨入库";
            appBarTitle = "调拨入库";
            // handleOverThird = false;
            selectDeptId = orderTransfer!.stockOutDeptId;
            selectDeptName = orderTransfer!.stockOutDeptName as String;
          }
        }
      }
    }
  }

  //提交数据
  Future<int> confirm(List<TransferDoGoods> goods, Map<int, List> skuMap, int styleTotal, int numTotal, bool autoFinish) async {
    if (numTotal == 0) {
      toastMsg("数量不能为空");
      return -1;
    }
    //构建sku
    if (skuMap.isEmpty) {
      return -1;
    }
    if (curPageOperation == "createDirectStockOut" || curPageOperation == "updateDirect" || curPageOperation == "applyStockOut") {
      return await updateDirectStockOut(goods, skuMap, styleTotal, numTotal, curPageOperation);
    } else if (curPageOperation == "createApply" || curPageOperation == "updateApply") {
      return await updateApply(goods, skuMap, styleTotal, numTotal);
    } else if (curPageOperation == "stockIn") {
      return await stockIn(goods, skuMap, styleTotal, numTotal, autoFinish);
    }
    return -1;
  }

  /// 创建直接调拨单或修改直接调拨单
  Future<int> updateDirectStockOut(List<TransferDoGoods> goods, Map<int, List> map, int styleTotal, int numTotal, String curPageOperation) async {
    TransferReq transferReq = new TransferReq();
    transferReq.stockOutDeptId = deptId;
    if (selectDeptId == null) {
      toastMsg("请选择入库店仓");
      return -1;
    }
    transferReq.stockInDeptId = selectDeptId;
    transferReq.stockOutNum = numTotal;
    transferReq.stockOutStyleNum = styleTotal;

    transferReq.customizeTime = DateUtil.formatDate(selectDate);

    transferReq.distribution = DistributionEnum.NO;
    transferReq.substandard = substandard;

    if (orderTransferId != -1) {
      transferReq.id = orderTransferId;
    }

    List<TransferReqGoods> goodsData = [];

    TransferReqGoods transferRepGoods;
    TransferReqGoodsSkus transferReqGoodsSkus;
    goods.forEach((element) {
      if (element.stockOutNum == 0) {
        return;
      }
      transferRepGoods = new TransferReqGoods();
      transferRepGoods.goodsId = element.goodsId;
      transferRepGoods.id = element.id;
      transferRepGoods.stockOutNum = element.stockOutNum;
      transferRepGoods.remark = element.remark;

      List<TransferReqGoodsSkus>? skus = [];
      for (int i = 0; i < map[element.goodsId]!.length; i++) {
        for (int j = 0; j < map[element.goodsId]![i]['sizes'].length; j++) {
          if ((map[element.goodsId]![i]['sizes'][j]['data']['stockOutNum'] != null &&
                  map[element.goodsId]![i]['sizes'][j]['data']['stockOutNum'] != 0) ||
              (map[element.goodsId]![i]['sizes'][j]['data']['stockInNum'] != null &&
                  map[element.goodsId]![i]['sizes'][j]['data']['stockInNum'] != 0)) {
            transferReqGoodsSkus = new TransferReqGoodsSkus();
            transferReqGoodsSkus.id = map[element.goodsId]![i]['sizes'][j]['data']['id'];
            transferReqGoodsSkus.stockOutNum = map[element.goodsId]![i]['sizes'][j]['data']['stockOutNum'];
            transferReqGoodsSkus.skuId = map[element.goodsId]![i]['sizes'][j]['data']['skuId'];
            transferReqGoodsSkus.goodsId = element.goodsId;
            skus.add(transferReqGoodsSkus);
          }
        }
        transferRepGoods.skus = skus;
      }
      goodsData.add(transferRepGoods);
    });

    transferReq.goods = goodsData;
    transferReq.remark = orderRemarkController.text;

    if (curPageOperation == "applyStockOut" ) {
      return await TransferApi.applyStockOut(transferReq, showLoading: true);
    } else {
      return await TransferApi.updateDirectStockOut(transferReq, showLoading: true);
    }
  }

  /// 创建申请调拨单或修改申请调拨单
  Future<int> updateApply(List<TransferDoGoods> goods, Map<int, List> map, int styleTotal, int numTotal) async {
    TransferReq transferReq = new TransferReq();
    if (selectDeptId == null) {
      toastMsg("请选择出库店仓");
      return -1;
    }
    transferReq.stockOutDeptId = selectDeptId;
    transferReq.stockInDeptId = deptId;
    transferReq.applyNum = numTotal;
    transferReq.applyStyleNum = styleTotal;
    transferReq.distribution = DistributionEnum.NO;
    transferReq.substandard = SubstandardEnum.NO;

    if (orderTransferId != -1) {
      transferReq.id = orderTransferId;
    }

    List<TransferReqGoods> goodsData = [];
    transferReq.customizeTime = DateUtil.formatDate(selectDate);

    TransferReqGoods transferRepGoods;
    TransferReqGoodsSkus transferReqGoodsSkus;
    goods.forEach((element) {
      if (element.applyNum == 0) {
        return;
      }
      transferRepGoods = new TransferReqGoods();
      transferRepGoods.goodsId = element.goodsId;
      transferRepGoods.applyNum = element.applyNum;
      transferRepGoods.id = element.id;
      transferRepGoods.remark = element.remark;

      List<TransferReqGoodsSkus>? skus = [];
      for (int i = 0; i < map[element.goodsId]!.length; i++) {
        for (int j = 0; j < map[element.goodsId]![i]['sizes'].length; j++) {
          if ((map[element.goodsId]![i]['sizes'][j]['data']['applyNum'] != null && map[element.goodsId]![i]['sizes'][j]['data']['applyNum'] != 0) ||
              (map[element.goodsId]![i]['sizes'][j]['data']['stockOutNum'] != null &&
                  map[element.goodsId]![i]['sizes'][j]['data']['stockOutNum'] != 0) ||
              (map[element.goodsId]![i]['sizes'][j]['data']['stockInNum'] != null &&
                  map[element.goodsId]![i]['sizes'][j]['data']['stockInNum'] != 0)) {
            transferReqGoodsSkus = new TransferReqGoodsSkus();
            transferReqGoodsSkus.id = map[element.goodsId]![i]['sizes'][j]['data']['id'];
            transferReqGoodsSkus.applyNum = map[element.goodsId]![i]['sizes'][j]['data']['applyNum'];
            transferReqGoodsSkus.skuId = map[element.goodsId]![i]['sizes'][j]['data']['skuId'];
            transferReqGoodsSkus.goodsId = element.goodsId;
            skus.add(transferReqGoodsSkus);
          }
        }
        transferRepGoods.skus = skus;
      }
      goodsData.add(transferRepGoods);
    });

    transferReq.goods = goodsData;
    transferReq.remark = orderRemarkController.text;

    return await TransferApi.updateApply(transferReq, showLoading: true);
  }

  /// 入库
  Future<int> stockIn(List<TransferDoGoods> goods, Map<int, List> map, int styleTotal, int numTotal, bool autoFinish) async {
    TransferReq transferReq = new TransferReq();
    transferReq.autoFinish = autoFinish;
    transferReq.id = orderTransferId;

    transferReq.stockInNum = numTotal;
    transferReq.stockInStyleNum = styleTotal;
    transferReq.importUnSaleGoods = false;
    transferReq.autoFinish = autoFinish;

    transferReq.customizeTime = DateUtil.formatDate(selectDate);

    List<TransferReqGoods> goodsData = [];

    TransferReqGoods transferRepGoods;
    TransferReqGoodsSkus transferReqGoodsSkus;
    goods.forEach((element) {
      transferRepGoods = new TransferReqGoods();
      transferRepGoods.goodsId = element.goodsId;
      transferRepGoods.stockInNum = element.stockInNum;
      transferRepGoods.id = element.id;
      transferRepGoods.remark = element.remark;

      List<TransferReqGoodsSkus>? skus = [];
      for (int i = 0; i < map[element.goodsId]!.length; i++) {
        for (int j = 0; j < map[element.goodsId]![i]['sizes'].length; j++) {
          if ((map[element.goodsId]![i]['sizes'][j]['data']['applyNum'] != null && map[element.goodsId]![i]['sizes'][j]['data']['applyNum'] != 0) ||
              (map[element.goodsId]![i]['sizes'][j]['data']['stockOutNum'] != null &&
                  map[element.goodsId]![i]['sizes'][j]['data']['stockOutNum'] != 0) ||
              (map[element.goodsId]![i]['sizes'][j]['data']['stockInNum'] != null &&
                  map[element.goodsId]![i]['sizes'][j]['data']['stockInNum'] != 0)) {
            transferReqGoodsSkus = new TransferReqGoodsSkus();
            transferReqGoodsSkus.id = map[element.goodsId]![i]['sizes'][j]['data']['id'];
            transferReqGoodsSkus.stockInNum = map[element.goodsId]![i]['sizes'][j]['data']['stockInNum'];
            transferReqGoodsSkus.skuId = map[element.goodsId]![i]['sizes'][j]['data']['skuId'];
            transferReqGoodsSkus.goodsId = element.goodsId;
            skus.add(transferReqGoodsSkus);
          }
        }
        transferRepGoods.skus = skus;
      }
      goodsData.add(transferRepGoods);
    });

    transferReq.goods = goodsData;
    transferReq.remark = orderRemarkController.text;

    return await TransferApi.stockIn(transferReq, showLoading: true);
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
