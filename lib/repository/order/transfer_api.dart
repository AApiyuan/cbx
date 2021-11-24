import 'dart:convert';

import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/stock/model/req/batch_stock_rep.dart';
import 'package:haidai_flutter_module/page/stock/model/res/order_stock_new_do.dart';
import 'package:haidai_flutter_module/page/transfer/model/req/distribution_sale_req.dart';
import 'package:haidai_flutter_module/page/transfer/model/req/select_relation_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/req/transfer_req.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/distribution_salegroup_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_action_do.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_count_param_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_distribution_list_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_do.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_good_list_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_list_do_entity.dart';

class TransferApi {
  static final String _detail = "/order/transfer/detail";
  static final String _createDirectStockOut = "/order/transfer/createDirectStockOut";
  static final String _updateDirect = "/order/transfer/updateDirect";
  static final String _applyStockOut = "/order/transfer/stock/out";
  static final String _createApply = "/order/transfer/createApply";
  static final String _updateApply = "/order/transfer/updateApply";
  static final String _stockIn = "/order/transfer/stock/in";

  static final String _distribution = "/order/sale/distributionSale"; //配货
  static final String _updateGoodsRemark = "/order/transfer/updateTransferGoods";
  static final String _cancelTransfer = "/order/transfer/cancel"; //撤销调拨单
  static final String _finishTransfer = "/order/transfer/finish"; //完成调拨单
  static final String _checkStock = "/order/transfer/checkStock"; //检查
  static final String _finishCancel = "/order/transfer/finishCancel"; //检查



  static final String _transferList = "/order/transfer/page"; //调拨单列表
  static final String _getAction = "/order/transfer/action"; //调拨单操作记录
  static final String _transferCount = "/order/transfer/selectCount"; //拨单列表统计数量
  static final String _transferGoodList = "goods/goods/page"; //拨单列表筛选商品列表
  static final String _mergeOrderStockSku = "/order/stock/mergeOrderStockSku"; //复制库存单
  static final String _distributionOrderList = "/order/sale/selectDistributionSaleByPage"; //分页查询配货销售单
  static final String _distributionOrderListCount = "/order/sale/selectDistributionSaleByPageCount"; //分页查询配货销售单

  static final String _distributionShopList = "/order/sale/selectDistributionSaleGroupDeptId"; //分页查询配货销售单


  static final String _selectRelationByCustomerDeptId = "/base/customerDept/selectRelationByCustomerDeptId"; //获取他店信息

  //详情
  static Future<TransferDo> orderTransferDetail(int id, int curDeptId, {bool getAllSku = false, bool showLoading = false}) async {
    Map<String, dynamic> param = new Map();
    param['id'] = id;
    param['getAllSku'] = getAllSku;
    param['curDeptId'] = curDeptId;
    var res = await HttpUtils.get(_detail, params: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return TransferDo().fromJson(res);
  }

  //配货
  static Future<TransferDo> distributionSale(DistributionSaleReq req, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_distribution, data: req, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return TransferDo().fromJson(res);
  }

  //创建直接调拨单
  static Future<int> updateDirectStockOut(TransferReq param, {bool showLoading = false}) async {
    var res;
    if (param.id == -1 || param.id == null) {
      res = await HttpUtils.post(_createDirectStockOut, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    } else {
      res = await HttpUtils.post(_updateDirect, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    }
    return res;
  }

  //创建或修改 申请调拨单
  static Future<int> updateApply(TransferReq param, {bool showLoading = false}) async {
    var res;
    if (param.id == -1 || param.id == null) {
      res = await HttpUtils.post(_createApply, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    } else {
      res = await HttpUtils.post(_updateApply, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    }
    return res;
  }

  //申请 调拨单的出库
  static Future<int> applyStockOut(TransferReq param, {bool showLoading = false}) async {
    return await HttpUtils.post(_applyStockOut, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
  }

  //调拨单的入库
  static Future<int> stockIn(TransferReq param, {bool showLoading = false}) async {
    return await HttpUtils.post(_stockIn, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
  }

  //修改商品的备注
  static Future<bool> updateGoodsRemark(int orderTransferGoodsId, String remark, {bool showLoading = false}) async {
    Map<String, dynamic> param = new Map();
    param['orderTransferGoodsId'] = orderTransferGoodsId;
    param['remark'] = remark;
    return await HttpUtils.post(_updateGoodsRemark, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
  }

  //撤销调拨单
  static Future<bool> cancelTransfer(int id, {bool showLoading = false}) async {
    Map<String, dynamic> param = new Map();
    param['id'] = id;
    return await HttpUtils.get(_cancelTransfer, params: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
  }

  //完成调拨单
  static Future<bool> finishTransfer(int id, {bool isDelivery = false, bool showLoading = false}) async {
    Map<String, dynamic> param = new Map();
    param['id'] = id;
    param['isDelivery'] = isDelivery;
    return await HttpUtils.get(_finishTransfer, params: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
  }

  //获取调拨单列表统计数据
  static Future<Map<String,dynamic>> getTransferListCount(
      TransferCountParamEntity param) async {
    var res = await HttpUtils.post(_transferCount,
        data: param, baseUrl: Config.ORDER_API_URL, showLoading: false);
    return res;
  }

  //获取调拨单列表筛选商品列表
  static Future<List<TransferGoodListEntity>> getTransferGoodList(
      BasePage param) async {
    var res = await HttpUtils.post(_transferGoodList,
        data: param, baseUrl: Config.GOODS_API_URL, showLoading: true);
    return res.map<TransferGoodListEntity>(
            (e) => new TransferGoodListEntity().fromJson(e))
        .toList();
  }

  //获取调拨单列表筛选店铺列表
  static Future<List<DistributionSalegroupEntity>> getDistributionShopList(
      BasePage param) async {
    var res = await HttpUtils.get(_distributionShopList,
        baseUrl: Config.ORDER_API_URL, params: param.param);
    return res.map<DistributionSalegroupEntity>(
            (e) => new DistributionSalegroupEntity().fromJson(e))
        .toList();
  }



  //分页获取调拨单列表
  static Future<List<TransferListDoEntity>> getTransferList(
      BasePage param) async {
    var res = await HttpUtils.post(_transferList,
        data: param, baseUrl: Config.ORDER_API_URL, showLoading: true);
    return res
        .map<TransferListDoEntity>(
            (e) => new TransferListDoEntity().fromJson(e))
        .toList();
  }

  //分页获取调拨单列表
  static Future<List<TransferDistributionListEntity>> getDistributionOrderList(
      BasePage param) async {
    var res = await HttpUtils.post(_distributionOrderList,
        data: param, baseUrl: Config.ORDER_API_URL, showLoading: false);
    return res
        .map<TransferDistributionListEntity>(
            (e) => new TransferDistributionListEntity().fromJson(e))
        .toList();
  }

  //分页获取调拨单列表数量
  static Future<String> getDistributionOrderListCount(
      BasePage param) async {
    var res = await HttpUtils.post(_distributionOrderListCount,
        data: param, baseUrl: Config.ORDER_API_URL, showLoading: true);
    return res.toString();
  }



  //复制库存单调拨
  static Future<TransferDo> mergeOrderStockSku(List<int> ids, {bool getAllSku = false, bool showLoading = false}) async {
    Map<String, dynamic> param = new Map();
    param['ids'] = ids;
    param['getAllSku'] = true;
    var res = await HttpUtils.post(_mergeOrderStockSku, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return TransferDo().fromJson(res);
  }

  // 获取他店信息
  static Future<List<SelectRelationEntity>> getSelectRelationByCustomerDeptId(num customerDeptId, {bool showLoading = false}) async {
    var res = await HttpUtils.get(_selectRelationByCustomerDeptId,
        baseUrl: Config.BASE_API_URL, params: {"customerDeptId": customerDeptId});
    return res.map<SelectRelationEntity>((e) => new SelectRelationEntity().fromJson(e)).toList();
  }

  //检查是否足够的库存发货
  static Future<bool> checkStock(int transferId, {bool showLoading = false}) async {
    Map<String, dynamic> param = new Map();
    param['id'] = transferId;
    var res = await HttpUtils.get(_checkStock, params: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res;
  }

  //获取操作记录
  static Future<List<TransferActionDo>> getAction(int id, {showLoading: false}) async {
    var res = await HttpUtils.get(_getAction,
        params: {"id": id}, baseUrl: Config.ORDER_API_URL, showLoading: false);
    return res.map<TransferActionDo>((e) => new TransferActionDo().fromJson(e)).toList();
  }

  //撤销完成状态
  static Future<bool> finishCancel(int id, {showLoading: false}) async {
    var res = await HttpUtils.get(_finishCancel,
        params: {"id": id}, baseUrl: Config.ORDER_API_URL, showLoading: false);
    return res;
  }
}
