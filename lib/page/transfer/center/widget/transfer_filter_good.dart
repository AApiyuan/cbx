import 'dart:convert';

import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/order_by.dart' as By;
import 'package:haidai_flutter_module/model/enum/pull_or_off.dart';
import 'package:haidai_flutter_module/model/enum/select_type.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/goods_page_param.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/model/rep/store_goods_sku_req_entity.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/page/goods/model/req/have_shortage_num_sale_page_req_entity.dart';
import 'package:haidai_flutter_module/page/goods/model/req/sale_goods_sku_distribution_req_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';

class TransferCenterSelectgoodController extends SuperController {
  ///货品列表类型
  static const int TYPE_INVENTORY = 0; //盘点
  static const int TYPE_STOCK = 1; //库存
  static const int TYPE_TRANSFER = 2; //调拨
  static const int TYPE_SALE = 3; //销售（开单）
  static const int TYPE_OWE = 4; //退欠货
  static const int TYPE_RETURN = 5; //退实物
  static const int TYPE_STOCK_SUBSTANDARD = 6; //库存_次品
  static const int TYPE_TRANSFER_SUBSTANDARD = 7; //调拨_次品

  ///id
  static const idFilterHot = "hot"; //热销
  static const idFilterLately = "lately"; //最近
  static const idFilterBuy = "buy"; //购买过
  static const idSearchClear = "searchClear"; //搜索清空
  static const idGoodsList = "goodsList"; //货品列表

  ///参数
  var deptId =
  ArgUtils.getArgument2num(Constant.DEPT_ID, def: -1)?.toInt(); // 店铺id
  var goodsType =
  ArgUtils.getArgument2num(Constant.GOODS_TYPE, def: TYPE_SALE); // 货品类型
  var orderId = ArgUtils.getArgument2num(Constant.ORDER_ID)?.toInt(); // 订单id
  var customerId =
  ArgUtils.getArgument2num(Constant.CUSTOMER_ID)?.toInt(); // 用户ID
  var selectMap = string2Map(ArgUtils.getArgument(
      Constant.SELECT_MAP)); // 选择的货品 key=goodsId， value=num

  ///成员变量
  var filterType = idFilterHot; // 筛选类型（开单部分）
  var searchText = ""; // 搜索文案

  List goodsList = []; // 货品列表
  var noMore = false; // 是否还有更多数据
  var _page = new BasePage(); // 页码数据
  var _oweParam = HaveShortageNumSalePageReqEntity();

  ///方法区
  static String map2String(Map<int, int> map) {
    Map<String, dynamic> jsonMap = {};
    map.forEach((key, value) => jsonMap["$key"] = value);
    print("flutter_tag========map2String=======${jsonEncode(jsonMap)}");
    return jsonEncode(jsonMap);
  }

  static Map<int, int> string2Map(String? arg) {
    var map = <int, int>{};
    if (arg == null) {
      return map;
    }
    Map<String, dynamic> jsonMap = jsonDecode(arg);
    print("flutter_tag======string2Map======$jsonMap");
    jsonMap.forEach((key, value) => map[int.parse(key)] = value);
    print("flutter_tag======string2Map======$map");
    return map;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadParamToType();
    getGoodsList(false);
  }

  /// 根据货品类型加载参数
  loadParamToType() {
    switch (goodsType) {
      case TYPE_SALE:
        filterHot();
        break;
      case TYPE_RETURN:
        returnParam();
        break;
      case TYPE_OWE:
        oweParam();
        break;
      case TYPE_INVENTORY:
        break;
      case TYPE_STOCK:
      case TYPE_TRANSFER:
        saleTimeParam();
        break;
      case TYPE_STOCK_SUBSTANDARD:
      case TYPE_TRANSFER_SUBSTANDARD:
        substandardParam();
        break;
    }
  }

  /// 退欠货
  oweParam() {
    _oweParam.customerId = customerId;
    _oweParam.customerDeptId = deptId;
    _oweParam.orderSaleId = orderId;
  }

  /// 退实物参数
  returnParam() {
    resetParam(
        selectType: SelectType.CUSTOMER_BUY, returnCustomerDeliveryNum: true);
  }

  /// 次品数排序（次品库存和次品调拨）
  substandardParam() {
    var orderBy = OrderBy();
    orderBy.by = By.OrderBy.DESC;
    orderBy.field = "substandardNum";
    resetParam(orderBy: orderBy);
  }

  /// 上架时间排序（正品库存和正品调拨）
  saleTimeParam() {
    var orderBy = OrderBy();
    orderBy.by = By.OrderBy.DESC;
    orderBy.field = "onSaleTime";
    resetParam(orderBy: orderBy);
  }

  ///获取货品列表
  Future getGoodsList(bool next) async {
    if (goodsType == TYPE_OWE) {
      return await SaleApi.selectHaveShortageNum(_oweParam).then((entity) {
        goodsList.clear();
        noMore = true;
        entity.forEach((order) {
          goodsList.add(order);
          order.saleGoodsList?.forEach((element) {
            element.relationOrderSaleCustomizeTime = order.customizeTime;
            element.relationOrderSaleSerial = order.orderSaleSerial;
            goodsList.add(element);
          });
        });
        update([idGoodsList]);
      });
    }
    if (next) {
      _page.pageNo = _page.pageNo! + 1;
    } else {
      resetPage();
    }
    return await GoodsApi.page(_page).then((entity) {
      noMore = entity.length < _page.pageSize!;
      goodsList.addAll(entity);
      update([idGoodsList]);
    }, onError: (t) {
      goodsList.clear();
      update([idGoodsList]);
    });
  }

  ///重置页面和数据
  void resetPage() {
    _page.pageNo = 1;
    _page.pageSize = 15;
    goodsList.clear();
  }

  /// 重置参数
  resetParam(
      {String selectType = SelectType.BASIC_STATIC,
        OrderBy? orderBy,
        String? startTime,
        String? endTime,
        bool returnCustomerDeliveryNum = false}) {
    GoodsPageParam param = new GoodsPageParam();
    param.deptId = deptId;
    param.status = PullOrOff.ON;
    param.goodsNameSerial = searchText;
    param.selectType = selectType;
    param.orderBy = orderBy;
    param.onSaleStartTime = startTime;
    param.onSaleEndTime = endTime;
    param.customerId = customerId;
    param.isBasePrice = false;
    param.returnCustomerDeliveryNum = returnCustomerDeliveryNum;
    _page.param = param;

    _oweParam.goodsNameSerial = searchText;
  }

  /// 获取该货品的已选数量
  int getSelectNum(int goodsId) {
    return selectMap[goodsId] ?? 0;
  }

  /// 更新筛选
  updateFilter(String id) {
    if (id == idFilterBuy && customerId == null) {
      toastMsg("请选择客户");
      return;
    }
    filterType = id;
    searchText = "";
    if (id == idFilterHot) {
      filterHot();
    } else if (id == idFilterBuy) {
      resetParam(selectType: SelectType.CUSTOMER_BUY);
    } else {
      var orderBy = OrderBy();
      orderBy.by = By.OrderBy.DESC;
      orderBy.field = "onSaleTime";
      resetParam(orderBy: orderBy);
    }
    getGoodsList(false);
    update([idFilterHot, idFilterLately, idFilterBuy]);
  }

  /// 最近热销
  void filterHot() {
    var orderBy = OrderBy();
    orderBy.by = By.OrderBy.DESC;
    orderBy.field = "saleNum";
    var startTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(89));
    var endTime = TimeUtils.getEndOfDay(DateTime.now());
    resetParam(
        selectType: SelectType.SALE_HOT,
        orderBy: orderBy,
        startTime: startTime,
        endTime: endTime);
  }

  /// 是否显示过滤控件（开单部分）
  bool isShowFilter() {
    return goodsType == TYPE_SALE && searchText.isEmpty;
  }

  /// 更新搜索文案
  updateSearchText(var searchText) {
    this.searchText = searchText;
    update([idSearchClear, idFilterHot, idFilterLately, idFilterBuy]);
  }

  /// 搜索
  search(var searchText) {
    this.searchText = searchText;
    if (this.searchText.isEmpty) {
      loadParamToType();
    } else {
      resetParam();
    }
    getGoodsList(false);
  }

  /// 获取货品sku
  Future getGoodsSku(Goods goods) {
    var params = StoreGoodsSkuReqEntity();
    params.goodsId = goods.id;
    params.deptId = deptId;
    params.customerId = customerId;
    if (goodsType == TYPE_SALE) {
      params.returnCustomerOweNum = true;
    } else if (goodsType == TYPE_RETURN) {
      params.returnCustomerDeliveryNum = true;
    } else {
      params.returnStock = true;
    }
    return GoodsApi.getSkuList(params, showLoading: true).then(
            (value) => GoodsSkuEntity(goods, value, SaleDetailDoSaleGoodsList()));
  }

  /// 选择货品
  Future selectGoods(Goods goods) {
    if (getSelectNum(goods.id!) == 0) {
      return getGoodsSku(goods);
    } else {
      GoodsSkuEntity goodsSkuEntity =
      new GoodsSkuEntity(goods, [], SaleDetailDoSaleGoodsList());
      return Future.value(goodsSkuEntity);
    }
  }

  /// 获取退欠货品sku
  Future getOweGoodsSku(SaleDetailDoSaleGoodsList goods) {
    var param = SaleGoodsSkuDistributionReqEntity();
    param.status = "HIVE_SHORTAGE_NUM";
    param.warehouseId = deptId;
    param.orderSaleGoodsIds = [goods.id!];
    return SaleApi.selectSaleGoodsSku(param, showLoading: true)
        .then((value) => GoodsSkuEntity(Goods(), value, goods));
  }

  /// 选择退欠货品
  Future selectOweGoods(SaleDetailDoSaleGoodsList goods) {
    if (getSelectNum(goods.id!) == 0) {
      return getOweGoodsSku(goods);
    } else {
      GoodsSkuEntity goodsSkuEntity = new GoodsSkuEntity(Goods(), [], goods);
      return Future.value(goodsSkuEntity);
    }
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
