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
import 'package:haidai_flutter_module/page/transfer/model/req/distribution_sale_req.dart';
import 'package:haidai_flutter_module/page/transfer/model/req/transfer_req.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_do.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';

class ConfirmController extends SuperController {
  var deptId; // 店铺id
  var distributeDeptId; //配货仓
  var otherDeptName; //他仓名称;
  var appBarTitle; //标题

  var orderTransferId;
  TransferDo? orderTransfer;
  CustomerUserDo? customerUserDo;

  var orderSaleId;
  List<Remark> remarks = [];

  var handleTag; //操作标签
  var thirdTagName;
  var thirdTag;
  bool handleOverThird = true;
  String thirdTagExtra = '';
  String thirdTagNameExtra = '';

  /// 日期
  DateTime? selectDate;

  /// 确定标签显示文字
  String staticTitle = '出库';
  String confirmButtonText = "出库";

  TextEditingController orderRemarkController = new TextEditingController();

  Future init() async {
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID, def: -1)?.toInt();
    // deptId = 6;
    orderTransferId = ArgUtils.getArgument2num(Constant.ORDER_TRANSFER_ID, def: -1)?.toInt();
    // orderTransferId = 33301;
    orderSaleId = ArgUtils.getArgument2num(Constant.ORDER_SALE_ID, def: -1)?.toInt();
    distributeDeptId = ArgUtils.getArgument2num(Constant.DISTRIBUTE_DEPT_ID, def: -1)?.toInt();
    // distributeDeptId = 8801;
    // orderSaleId = 39308;

    if (orderTransferId == -1) {
      //调拨单 id为空，证明是去配货
      DistributionSaleReq distributionSaleReq = new DistributionSaleReq();
      distributionSaleReq.customerDeptId = deptId;
      distributionSaleReq.orderSaleId = orderSaleId;

      orderTransfer = await TransferApi.distributionSale(distributionSaleReq);
      customerUserDo = await UserApi.getUser();

      staticTitle = '配货';
      handleTag = "stockOutNum";
      confirmButtonText = "配货调拨出库";
      thirdTag = "notDistributionNum";
      thirdTagName = "待配";
      thirdTagExtra = "stockNum";
      thirdTagNameExtra = "库存";
      handleOverThird = false; //出库数不能大于待配
      appBarTitle = "配货调拨出库";
      otherDeptName = orderTransfer!.stockInDeptName;
    } else {
      if (distributeDeptId == deptId) {
        //如果出库方是当前店铺，则是配货编辑
        DistributionSaleReq distributionSaleReq = new DistributionSaleReq();
        distributionSaleReq.customerDeptId = deptId;
        distributionSaleReq.orderSaleId = orderSaleId;
        distributionSaleReq.orderTransferId = orderTransferId;

        orderTransfer = await TransferApi.distributionSale(distributionSaleReq);
        staticTitle = '配货';
        handleTag = "stockOutNum";
        confirmButtonText = "出库";
        thirdTag = "notDistributionNum";
        thirdTagName = "待配";
        thirdTagExtra = "stockNum";
        thirdTagNameExtra = "库存";
        appBarTitle = "配货调拨出库";
        handleOverThird = false;
        otherDeptName = orderTransfer!.stockInDeptName;
      } else {
        orderTransfer = await TransferApi.orderTransferDetail(orderTransferId, deptId);

        staticTitle = '入库';
        handleTag = "stockInNum";
        confirmButtonText = "接收配货";
        thirdTag = "stockOutNum";
        thirdTagName = "配出";
        thirdTagExtra = "shortageNum";
        thirdTagNameExtra = "欠货";
        appBarTitle = "入库";
        otherDeptName = orderTransfer!.stockOutDeptName;
      }
      remarks = orderTransfer!.remarks as List<Remark>;
      selectDate = DateUtil.getDateTime(orderTransfer!.customizeTime!);
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
    if (handleTag == "stockOutNum") {
      return await updateDirectStockOut(goods, skuMap, styleTotal, numTotal);
    } else {
      return await stockIn(goods, skuMap, styleTotal, numTotal, autoFinish);
    }
  }

  /// 创建直接调拨单或修改直接调拨单
  Future<int> updateDirectStockOut(List<TransferDoGoods> goods, Map<int, List> map, int styleTotal, int numTotal) async {
    TransferReq transferReq = new TransferReq();
    transferReq.stockOutDeptId = deptId;
    transferReq.stockInDeptId = orderTransfer!.stockInDeptId;
    transferReq.orderSaleId = orderSaleId;

    transferReq.stockOutNum = numTotal;
    transferReq.stockOutStyleNum = styleTotal;
    transferReq.orderSaleId = orderSaleId;
    transferReq.customerId = orderTransfer!.customerId;
    transferReq.customizeTime = DateUtil.formatDate(selectDate);
    transferReq.distribution = DistributionEnum.YES;
    transferReq.substandard = SubstandardEnum.NO;

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
      transferRepGoods.orderSaleId = element.orderSaleId;
      transferRepGoods.orderSaleGoodsId = element.orderSaleGoodsId;
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
            transferReqGoodsSkus.orderSaleId = element.orderSaleId;
            transferReqGoodsSkus.orderSaleGoodsId = element.orderSaleGoodsId;
            transferReqGoodsSkus.orderSaleGoodsSkuId = map[element.goodsId]![i]['sizes'][j]['data']['orderSaleGoodsSkuId'];

            skus.add(transferReqGoodsSkus);
          }
        }
        transferRepGoods.skus = skus;
      }
      goodsData.add(transferRepGoods);
    });

    transferReq.goods = goodsData;
    transferReq.remark = orderRemarkController.text;

    return await TransferApi.updateDirectStockOut(transferReq, showLoading: true);
  }

  /// 入库
  Future<int> stockIn(List<TransferDoGoods> goods, Map<int, List> map, int styleTotal, int numTotal, bool autoFinish) async {
    TransferReq transferReq = new TransferReq();
    transferReq.id = orderTransferId;
    transferReq.autoFinish = autoFinish;

    transferReq.stockInNum = numTotal;
    transferReq.stockInStyleNum = styleTotal;
    transferReq.importUnSaleGoods = false;
    transferReq.autoFinish = autoFinish;

    List<TransferReqGoods> goodsData = [];
    transferReq.customizeTime = DateUtil.formatDate(selectDate);

    TransferReqGoods transferRepGoods;
    TransferReqGoodsSkus transferReqGoodsSkus;
    goods.forEach((element) {
      transferRepGoods = new TransferReqGoods();
      transferRepGoods.goodsId = element.goodsId;
      transferRepGoods.stockInNum = element.stockInNum;
      transferRepGoods.id = element.id;
      transferRepGoods.orderSaleId = element.orderSaleId;
      transferRepGoods.orderSaleGoodsId = element.orderSaleGoodsId;
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
            transferReqGoodsSkus.stockInNum = map[element.goodsId]![i]['sizes'][j]['data']['stockInNum'];
            transferReqGoodsSkus.skuId = map[element.goodsId]![i]['sizes'][j]['data']['skuId'];
            transferReqGoodsSkus.goodsId = element.goodsId;
            transferReqGoodsSkus.orderSaleId = element.orderSaleId;
            transferReqGoodsSkus.orderSaleGoodsId = element.orderSaleGoodsId;
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
