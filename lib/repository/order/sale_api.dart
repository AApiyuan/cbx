import 'dart:convert';

import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleBeforeReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleReq.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/delivery_detail/models/delivery_detail_entity.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/req/sale_create_delivery_req_entity.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/res/delivery_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/goods/model/req/have_shortage_num_sale_page_req_entity.dart';
import 'package:haidai_flutter_module/page/goods/model/req/sale_goods_sku_distribution_req_entity.dart';
import 'package:haidai_flutter_module/page/goods/model/sale_and_sale_goods_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_do_entity.dart';
import 'package:haidai_flutter_module/page/sale_detail/models/check_canceled_sale_res.dart';
import 'package:haidai_flutter_module/page/sale_detail/models/req/copy_sale_req_entity.dart';
import 'package:haidai_flutter_module/page/sale_detail/models/req/sale_update_req_entity.dart';
import 'package:haidai_flutter_module/page/sale_detail/models/store_customer_balance_change_log_detail_do.dart';
import 'package:haidai_flutter_module/page/sale_operation/models/sale_action_detail_do.dart';
import 'package:haidai_flutter_module/page/verification/model/order_sale_item_entity.dart';

class SaleApi {
  static final String _selectHaveShortageNum = "/order/sale/selectHaveShortageNum";
  static final String _selectSaleGoodsSku = "/order/sale/selectSaleGoodsSku";
  static final String _createSale = "/order/sale/createSale";
  static final String _updateSale = "/order/sale/updateSale";
  static final String _createSaleBefore = "/order/saleBefore/createSaleBefore";
  static final String _updateSaleBase = "/order/sale/updateSaleBase";
  static final String _allSkuSaleOrderDetail = "/order/sale/selectDetailToAllSkuById";
  static final String _saleOrderDetail = "/order/sale/selectDetailById";
  static final String _selectByPage = "/order/sale/selectByPage";

  static final String _deliveryOrderDetail = "/order/delivery/selectDetailById";
  static final String _deliveryOrderDetailUpdate = "/order/delivery/updateDeliveryBase";
  static final String _deliveryOrderGoodsUpdate = "/order/delivery/updateDeliveryGoods";
  static final String _canceledDelivery = "/order/delivery/canceledDelivery";

  static final String _selectStoreCustomerBalanceChangeLogById = "/order/sale/selectStoreCustomerBalanceChangeLogById";
  static final String _updateGoodsRemark = "/order/sale/updateSaleGoods";
  static final String _checkCanceledSale = "/order/sale/checkCanceledSale";
  static final String _canceledSale = "/order/sale/canceledSale";
  static final String _copySaleOrder = "/order/sale/copySale";
  static final String _selectSaleActionDetailById = "/order/sale/selectSaleActionDetailById";

  static final String _cancelOrderBalance = "/order/sale/canceledStoreCustomerBalanceChange";

  static final String _createDelivery = "/order/sale/createDelivery";//创建发货单

  // 创建发货单
  static Future<DeliveryDetailDoEntity> createDelivery(SaleCreateDeliveryReqEntity param, {bool showLoading = false}) async {
    var res =  await HttpUtils.post(_createDelivery, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return DeliveryDetailDoEntity().fromJson(res);
  }

  // 批量作废核销记录 v0.4.0
  static Future<bool> cancelOrderBalance(List<int> param, {bool showLoading = false}) async {
    return await HttpUtils.post(_cancelOrderBalance, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
  }

  // 分页查询销售单信息
  static Future<List<OrderSaleItemEntity>> selectByPage(BasePage param, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_selectByPage, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res.map<OrderSaleItemEntity>((e) => new OrderSaleItemEntity().fromJson(e)).toList();
  }

  // 分页查询销售单信息
  static Future<List<SaleDoEntity>> selectPage(BasePage param, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_selectByPage, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res.map<SaleDoEntity>((e) => new SaleDoEntity().fromJson(e)).toList();
  }

  // 销售单修改基础信息
  static Future<bool> updateSaleBase(SaleUpdateReqEntity param, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_updateSaleBase, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res;
  }

  // 复制销售单
  static Future<SaleDetailDoEntity> copySaleOrder(CopySaleReqEntity param, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_copySaleOrder, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return SaleDetailDoEntity().fromJson(res);
  }

  static Future<List<SaleAndSaleGoodsDoEntity>> selectHaveShortageNum(HaveShortageNumSalePageReqEntity param) async {
    var res = await HttpUtils.post(_selectHaveShortageNum, data: param, baseUrl: Config.ORDER_API_URL, showLoading: false);
    return res.map<SaleAndSaleGoodsDoEntity>((e) => new SaleAndSaleGoodsDoEntity().fromJson(e)).toList();
  }

  static Future<List<SkuInfoEntity>> selectSaleGoodsSku(SaleGoodsSkuDistributionReqEntity param, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_selectSaleGoodsSku, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res[0]["orderGoodsVoList"].map<SkuInfoEntity>((e) => SkuInfoEntity().fromJson(e)).toList();
  }

  static Future<SaleDoEntity> createSaleOrder(CreateSaleReq param, {bool showLoading = false}) async {
    var json = jsonEncode(param.toJson());
    var res = await HttpUtils.post(_createSale, data: param.toJson(), baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return SaleDoEntity().fromJson(res);
  }

  static Future<SaleDoEntity> createSaleBefore(CreateSaleBeforeReq param, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_createSaleBefore, data: param.toJson(), baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return SaleDoEntity().fromJson(res);
  }

  static Future<SaleDoEntity> updateSaleOrder(CreateSaleReq param) async {
    var json = jsonEncode(param.toJson());
    var res = await HttpUtils.post(_updateSale, data: param.toJson(), baseUrl: Config.ORDER_API_URL, showLoading: false);
    return SaleDoEntity().fromJson(res);
  }

  static Future<SaleDetailDoEntity> saleOrderDetail(int orderSaleId, {showLoading: false, showAllSku: true}) async {
    Map<String, dynamic> params = new Map();
    params['orderSaleId'] = orderSaleId;
    var res = await HttpUtils.get(showAllSku ? _allSkuSaleOrderDetail : _saleOrderDetail,
        params: params, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return SaleDetailDoEntity().fromJson(res);
  }

  static Future<List<StoreCustomerBalanceChangeLogDetailDo>> selectStoreCustomerBalanceChangeLogById(int orderSaleId,
      {String? canceled, showLoading: false}) async {
    Map<String, dynamic> params = new Map();
    params['orderSaleId'] = orderSaleId;
    if (canceled != null) {
      params['canceled'] = canceled;
    }
    var res = await HttpUtils.get(_selectStoreCustomerBalanceChangeLogById, params: params, baseUrl: Config.ORDER_API_URL, showLoading: false);
    return res.map<StoreCustomerBalanceChangeLogDetailDo>((e) => new StoreCustomerBalanceChangeLogDetailDo().fromJson(e)).toList();
  }

  //修改备注
  static Future<bool> updateGoodsRemark(int orderSaleGoodsId, String remark, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_updateGoodsRemark,
        data: {"orderSaleGoodsId": orderSaleGoodsId, "remark": remark}, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res;
  }

  //撤销判断
  static Future<CheckCanceledSaleRes> checkCanceledSale(int orderSaleId, {bool showLoading = false}) async {
    var res = await HttpUtils.get(_checkCanceledSale, params: {"orderSaleId": orderSaleId}, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return CheckCanceledSaleRes().fromJson(res);
  }

  //撤销销售单

  static Future<bool> canceledSale(int orderSaleId, {bool showLoading = false}) async {
    var res = await HttpUtils.get(_canceledSale,
        params: {
          "orderSaleId": orderSaleId,
        },
        baseUrl: Config.ORDER_API_URL,
        showLoading: showLoading);
    return res;
  }

  //获取销售单操作记录
  static Future<List<SaleActionDetailDo>> selectSaleActionDetailById(int orderSaleId, {showLoading: false}) async {
    var res =
        await HttpUtils.get(_selectSaleActionDetailById, params: {"orderSaleId": orderSaleId}, baseUrl: Config.ORDER_API_URL, showLoading: false);
    return res.map<SaleActionDetailDo>((e) => new SaleActionDetailDo().fromJson(e)).toList();
  }

  //发货单详情
  static Future<DeliveryDetailEntity> deliveryOrderDetail(int deliveryOrderId, {showLoading: false, showAllSku: true}) async {
    Map<String, dynamic> params = new Map();
    params['orderDeliveryId'] = deliveryOrderId;
    var res = await HttpUtils.get(_deliveryOrderDetail,
        params: params, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return DeliveryDetailEntity().fromJson(res);
  }

  //修改发货货品备注
  static Future<bool> updateDeliveryOrderRemark(int orderDeliveryId, String remark, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_deliveryOrderDetailUpdate,
        data: {"orderDeliveryId": orderDeliveryId, "remark": remark}, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res;
  }

  //修改发货货品备注
  static Future<bool> updateDeliveryGoodsRemark(int orderDeliveryGoodsId, String remark, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_deliveryOrderGoodsUpdate,
        data: {"orderDeliveryGoodsId": orderDeliveryGoodsId, "remark": remark}, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res;
  }
  //撤销发货单

  static Future<bool> canceledDelivery(int orderSaleId, {bool showLoading = false}) async {
    var res = await HttpUtils.get(_canceledDelivery,
        params: {
          "orderDeliveryId": orderSaleId,
        },
        baseUrl: Config.ORDER_API_URL,
        showLoading: showLoading);
    return res;
  }
}
