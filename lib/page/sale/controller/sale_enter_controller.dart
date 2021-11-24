import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/db/query/hang_order_query.dart';
import 'package:haidai_flutter_module/common/db/sql_db.dart';
import 'package:haidai_flutter_module/common/sale/CalculateSaleAmountUtil.dart';
import 'package:haidai_flutter_module/common/sale/CalculateSaleBeforeAmountUtil.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleBeforeReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/SaleGoodsBeforeReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/SaleGoodsReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/SaleGoodsSkuBeforeReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/SaleGoodsSkuReq.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleSubstandardEnum.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/DateUtils.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/common/sale/util/sale_utils.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/dept_config_utils.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/dicount_template.dart';
import 'package:haidai_flutter_module/model/enum/pull_or_off.dart';
import 'package:haidai_flutter_module/model/enum/select_type.dart';
import 'package:haidai_flutter_module/model/enum/status.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/goods_page_param.dart';
import 'package:haidai_flutter_module/model/rep/store_goods_sku_req_entity.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/model/store/req/store_discount_template_req.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_relation_do.dart';
import 'package:haidai_flutter_module/model/store/res/store_discount_template_do.dart';
import 'package:haidai_flutter_module/page/customer/model/rep/store_customer_create_req_entity.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/order_item_model.dart';
import 'package:haidai_flutter_module/page/sale/model/req/batch_customer_buy_price_req_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/widget/bottom_statistics_widget.dart';
import 'package:haidai_flutter_module/page/sale_detail/models/req/copy_sale_req_entity.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';
import 'package:haidai_flutter_module/repository/base/customer_dept_api.dart';
import 'package:haidai_flutter_module/repository/base/store.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

class SaleEnterController extends SuperController {
  static const TYPE_SALE = 0;
  static const TYPE_QUOTATION = 1;
  static const TYPE_OFFLINE_SALE = 2;
  static const SUBMIT_ORDER = "submitOrder";
  static const COPY_ORDER_SALE_ID = "copyOrderSaleId";

  static const LIST_TYPE_SALE = 0;
  static const LIST_TYPE_OWE = 1;
  static const LIST_TYPE_RETURN = 2;

  /// 参数
  var _deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
  var _type = ArgUtils.getArgument2num(Constant.TYPE, def: TYPE_SALE)?.toInt();
  var _isSubstandard =
      ArgUtils.getArgument2bool(Constant.SUBSTANDARD, def: false)!;
  var _orderId = ArgUtils.getArgument2num(Constant.ORDER_ID)?.toInt();
  var _orderSaleId = ArgUtils.getArgument2num(Constant.ORDER_SALE_ID)?.toInt();
  var _copyOrderSaleId = ArgUtils.getArgument2num(COPY_ORDER_SALE_ID)?.toInt();
  var _submitOrder = ArgUtils.getArgument2bool(SUBMIT_ORDER);
  var _customerId = ArgUtils.getArgument2num(Constant.CUSTOMER_ID)?.toInt();
  var _listType =
      ArgUtils.getArgument2num(Constant.LIST_TYPE, def: LIST_TYPE_SALE)!
          .toInt();

  get deptId => _deptId;

  get type => _type;

  get online => type != TYPE_OFFLINE_SALE;

  get listType {
    if (TYPE_OFFLINE_SALE == _type) {
      return _listType == LIST_TYPE_RETURN ? 1 : 0;
    } else {
      return _listType;
    }
  }

  /// id
  static const idCustomer = "customer";
  static const idGoodsStatistics = "goodsStatistics";
  static const idAmountStatistics = "amountStatistics";
  static const idSaleHeader = "saleHeader";
  static const idSaleHeaderStatistics = "saleHeaderStatistics";
  static const idSaleList = "saleList";
  static const idSaleEmpty = "saleEmpty";
  static const idReturnHeader = "returnHeader";
  static const idReturnHeaderStatistics = "returnHeaderStatistics";
  static const idReturnList = "returnList";
  static const idReturnEmpty = "returnEmpty";
  static const idOweHeader = "oweHeader";
  static const idOweHeaderStatistics = "oweHeaderStatistics";
  static const idOweList = "oweList";
  static const idOweEmpty = "oweEmpty";
  static const idSaleTab = "saleTab";
  static const idReturnTab = "returnTab";
  static const idOweTab = "oweTab";
  static const idTabWidget = "tabWidget";
  static const idNormalGoods = "normalGoods";
  static const idSubstandardGoods = "substandardGoods";
  static const idDiscountGoodsList = "discountGoodsList";
  static const idDiscountSelectAll = "discountSelectAll";
  static const idDiscountSelectAllText = "discountSelectAllText";

  static idSaleGoods(id) => "saleGoodsCount$id";

  static idReturnGoods(id) => "returnGoodsCount$id";

  static idOweGoods(id) => "oweGoodsCount$id";

  /// 属性
  StoreCustomerListItemDoEntity? _customer;

  var _currTab = idSaleTab;

  var _showKeyBord = false;

  var taxSetting = false;//自主设置

  CreateSaleReq? _saleReq;
  CreateSaleBeforeReq? _saleBeforeReq;
  List<dynamic> _saleList = [];
  Map<int, List> _saleSkuMap = {};
  Map<int, int> _saleCountMap = {};
  List<dynamic> _returnList = [];
  Map<int, List> _returnSkuMap = {};
  Map<int, int> _returnCountMap = {};
  List<dynamic> _oweList = [];
  Map<int, List> _oweSkuMap = {};
  Map<int, int> _oweCountMap = {};
  List<CustomerDeptRelationDo>? deptRelationList;

  var _checkAmount = 0;

  var returnLastPrice = false;
  var saleLastPrice = false;
  var distributionId;

  bool get showKeyBord => _showKeyBord;

  CreateSaleReq? get saleReq => _saleReq;

  CreateSaleBeforeReq? get saleBeforeReq => _saleBeforeReq;

  get customerId => _customer?.id;

  get currTab => _currTab;

  get isSubstandard => _isSubstandard;

  get orderSaleId => isEdit ? _orderSaleId : null;

  get tax {
    if (TYPE_QUOTATION == type) {
      return saleBeforeReq?.tax ?? 0;
    }
    return saleReq?.tax ?? 0;
  }

  get checkAmount => _checkAmount;

  setTax(int tax) {
    if (TYPE_QUOTATION == type) {
      saleBeforeReq?.tax = tax;
    } else {
      saleReq?.tax = tax;
    }
  }

  get goodsLen {
    if (TYPE_QUOTATION == type) {
      return saleBeforeReq?.goodsBeforeList.length ?? 0;
    }
    return saleReq?.goodsList.length ?? 0;
  }

  StoreCustomerListItemDoEntity? get customer => _customer;

  bool get hasSale => saleList.length - 2 > 0;

  List<dynamic> get saleList => _saleList;

  Map<int, List> get saleSkuMap => _saleSkuMap;

  dynamic saleItem(int index) => saleList[index];

  Map<int, int> get saleSelectMap => _saleCountMap;

  get salePrice {
    var price = 0;
    if (type == TYPE_QUOTATION) {
      saleBeforeReq?.goodsBeforeList
          .forEach((element) => price += element.taxReceivableAmount ?? 0);
    } else {
      saleReq?.goodsList.forEach((element) {
        if (element.type == SaleTypeEnum.NORMAL_SALE) {
          price += element.taxReceivableAmount ?? 0;
        }
      });
    }
    return price;
  }

  bool get hasReturn => returnList.length - 2 > 0;

  List<dynamic> get returnList => _returnList;

  Map<int, List> get returnSkuMap => _returnSkuMap;

  dynamic returnItem(int index) => returnList[index];

  Map<int, int> get returnSelectMap => _returnCountMap;

  get returnPrice {
    var price = 0;
    saleReq?.goodsList.forEach((element) {
      if (element.type == SaleTypeEnum.RETURN_GOODS) {
        price += element.receivableAmount ?? 0;
      }
    });
    return price;
  }

  bool get hasOwe => oweList.length - 2 > 0;

  List<dynamic> get oweList => _oweList;

  Map<int, List> get oweSkuMap => _oweSkuMap;

  dynamic oweItem(int index) => oweList[index];

  Map<int, int> get oweSelectMap => _oweCountMap;

  Map<int, int> get oweNewSelectMap {
    var map = <int, int>{};
    oweSelectMap.forEach((key, value) {
      saleReq?.goodsList.forEach((element) {
        if (SaleTypeEnum.CHANGE_BACK_ORDER == element.type) {
          if (element.id == null) {
            map[element.oweGoodsId!] = value;
          } else {
            map[element.relationOrderSaleGoodsId!] = value;
          }
        }
      });
    });
    return map;
  }

  get owePrice {
    var price = 0;
    saleReq?.goodsList.forEach((element) {
      if (element.type == SaleTypeEnum.CHANGE_BACK_ORDER) {
        price += element.receivableAmount ?? 0;
      }
    });
    return price;
  }

  get saleCount {
    var count = 0;
    saleSelectMap.forEach((key, value) => count += value);
    return count;
  }

  get oweCount {
    var count = 0;
    oweSelectMap.forEach((key, value) => count += value);
    return -count;
  }

  get returnCount {
    var count = 0;
    returnSelectMap.forEach((key, value) => count += value);
    return -count;
  }

  int get dataLength => saleList.length + returnList.length + oweList.length;

  get receivable {
    if (type == TYPE_QUOTATION) {
      return PriceUtils.getPrice(saleBeforeReq?.balanceAmount);
    }
    return PriceUtils.getPrice(saleReq?.balanceAmount);
  }

  get balanceAmount {
    if (type == TYPE_QUOTATION) {
      return saleBeforeReq?.balanceAmount ?? 0;
    }
    return saleReq?.balanceAmount ?? 0;
  }

  get orderItemList {
    var list = <OrderItemModel>[];
    var saleCount = 0;
    var saleStyle = 0;
    var salePrice = 0;
    List<String> saleCovers = [];
    saleList.forEach((element) {
      if (element is SaleDetailDoSaleGoodsList) {
        if (type == TYPE_QUOTATION) {
          var saleGoodsReq = getSaleGoodsBeforeReq(element.goodsId!);
          if ((saleGoodsReq?.goodsNum ?? 0) > 0) {
            saleStyle++;
            saleCount += saleGoodsReq!.goodsNum!;
            salePrice += saleGoodsReq.receivableAmount!;
            var goods = element.storeGoods!;
            if (saleCovers.length < 3) {
              saleCovers
                  .add(GoodsUtils.getGoodsCover(goods.imgPath, goods.cover));
            }
          }
        } else {
          var saleGoodsReq = getSaleGoodsReq(element.goodsId!);
          if ((saleGoodsReq?.goodsNum ?? 0) > 0) {
            saleStyle++;
            saleCount += saleGoodsReq!.goodsNum!;
            salePrice += saleGoodsReq.receivableAmount!;
            var goods = element.storeGoods!;
            if (saleCovers.length < 3) {
              saleCovers
                  .add(GoodsUtils.getGoodsCover(goods.imgPath, goods.cover));
            }
          }
        }
      }
    });
    if (saleStyle != 0)
      list.add(OrderItemModel(SaleTypeEnum.NORMAL_SALE, saleCount, saleStyle,
          salePrice, saleCovers));

    var returnCount = 0;
    var returnStyle = 0;
    var returnPrice = 0;
    List<String> returnCovers = [];
    returnList.forEach((element) {
      if (element is SaleDetailDoSaleGoodsList) {
        var returnGoodsReq = getReturnGoodsReq(element.goodsId!);
        if ((returnGoodsReq?.goodsNum ?? 0) != 0) {
          returnStyle++;
          returnCount += returnGoodsReq!.goodsNum!;
          returnPrice += returnGoodsReq.receivableAmount!;
          var goods = element.storeGoods!;
          if (returnCovers.length < 3) {
            returnCovers
                .add(GoodsUtils.getGoodsCover(goods.imgPath, goods.cover));
          }
        }
      }
    });
    if (returnStyle != 0)
      list.add(OrderItemModel(SaleTypeEnum.RETURN_GOODS, returnCount,
          returnStyle, returnPrice, returnCovers));

    var oweCount = 0;
    var oweStyle = 0;
    var owePrice = 0;
    List<String> oweCovers = [];
    oweList.forEach((element) {
      if (element is SaleDetailDoSaleGoodsList) {
        var oweGoodsReq = getOweGoodsReq(element.id!);
        if ((oweGoodsReq?.goodsNum ?? 0) != 0) {
          oweStyle++;
          owePrice += oweGoodsReq?.receivableAmount ?? 0;
          oweCount += oweGoodsReq?.goodsNum ?? 0;
          var goods = element.storeGoods!;
          if (oweCovers.length < 3) {
            oweCovers.add(GoodsUtils.getGoodsCover(goods.imgPath, goods.cover));
          }
        }
      }
    });
    if (oweStyle != 0)
      list.add(OrderItemModel(SaleTypeEnum.CHANGE_BACK_ORDER, oweCount,
          oweStyle, owePrice, oweCovers));
    return list;
  }

  get isEdit => _orderSaleId != null;

  /// 方法

  @override
  void onInit() {
    super.onInit();
  }

  getReceivableAmount(int id) {
    return type == SaleEnterController.TYPE_QUOTATION
        ? getSaleGoodsBeforeReq(id)?.receivableAmount
        : getSaleGoodsReq(id)?.receivableAmount;
  }

  getTaxReceivableAmount(int id) {
    return type == SaleEnterController.TYPE_QUOTATION
        ? getSaleGoodsBeforeReq(id)?.taxReceivableAmount
        : getSaleGoodsReq(id)?.taxReceivableAmount;
  }

  init() async {
    if (online) {
      distributionId = await DeptConfigUtils.getConfig(DeptConfigUtils.CONFIG_DISTRIBUTION_1);
      if (distributionId == "") {
        distributionId = null;
      }
      returnLastPrice = await DeptConfigUtils.checkConfig(DeptConfigUtils.CONFIG_PRICE_2, DeptConfigUtils.CONFIG_PRICE_2_0);
        // (await MethodChannel(ChannelConfig.flutterToNative)
        //       .invokeMethod(
        //           ChannelConfig.methodDeptConfig, "CONFIG_PRICE_2")) ==
        //   "CONFIG_PRICE_2_0";
      saleLastPrice = await DeptConfigUtils.checkConfig(DeptConfigUtils.CONFIG_PRICE_1, DeptConfigUtils.CONFIG_PRICE_1_0);
          // (await MethodChannel(ChannelConfig.flutterToNative)
          //     .invokeMethod(
          //         ChannelConfig.methodDeptConfig, "CONFIG_PRICE_1")) ==
          // "CONFIG_PRICE_1_0";
      // await MethodChannel(ChannelConfig.flutterToNative)
      //     .invokeMethod(
      //         ChannelConfig.methodDeptConfig, "CONFIG_DISTRIBUTION_1");
    }
    if (_orderId != null) {
      await loadHangOrderData();
    } else if (_orderSaleId != null || _copyOrderSaleId != null) {
      await loadOrderSaleData();
    } else if (_customerId != null) {
      await CustomerApi.getCustomer(_customerId).then((customer) {
        this._customer = customer;
      });
    }
  }

  Future loadOrderSaleData() async {
    Future<SaleDetailDoEntity> future;
    if (_copyOrderSaleId != null) {
      var param = CopySaleReqEntity();
      param.deptId = deptId;
      param.orderSaleId = _copyOrderSaleId;
      future = SaleApi.copySaleOrder(param);
    } else {
      future = SaleApi.saleOrderDetail(_orderSaleId!);
    }
    await future.then((value) async {
      this._checkAmount = value.checkAmount ?? 0;
      value.saleGoodsList?.forEach((element) {
        element.orderGoodsVoList?.forEach((element) => element.sizes
            ?.forEach((element) => element.data?.num = element.data?.goodsNum));
        if (element.type ==
            EnumCoverUtils.enumsToString(SaleTypeEnum.NORMAL_SALE)) {
          this._saleList.add(element);
          this._saleCountMap[element.goodsId!] = element.goodsNum ?? 0;
          this._saleSkuMap[element.goodsId!] =
              element.orderGoodsVoList?.map((e) => e.toJson()).toList() ?? [];
        } else if (element.type ==
            EnumCoverUtils.enumsToString(SaleTypeEnum.RETURN_GOODS)) {
          this._returnList.add(element);
          this._returnCountMap[element.goodsId!] =
              (element.goodsNum ?? 0).abs();
          this._returnSkuMap[element.goodsId!] =
              element.orderGoodsVoList?.map((e) {
                    e.sizes?.forEach((element) =>
                        element.data?.num = element.data?.num?.abs() ?? 0);
                    return e.toJson();
                  }).toList() ??
                  [];
        } else {
          this._oweList.add(element);
          this._oweCountMap[element.id!] = (element.goodsNum ?? 0).abs();
          this._oweSkuMap[element.id!] = element.orderGoodsVoList?.map((e) {
                e.sizes?.forEach((element) =>
                    element.data?.num = element.data?.num?.abs() ?? 0);
                return e.toJson();
              }).toList() ??
              [];
        }
      });
      this._isSubstandard = value.substandard == "YES";
      if (type == TYPE_QUOTATION) {
        this._saleBeforeReq = CreateSaleBeforeReq();
        this._saleBeforeReq?.customerId = value.customerId;
        this._saleBeforeReq?.goodsBeforeList = [];
        this._saleBeforeReq?.wipeOffAmount = value.wipeOffAmount;
        this._saleBeforeReq?.id = value.id;
        this._saleBeforeReq?.customizeTime =
            DateUtils.string2Date(value.customizeTime);
        this._saleBeforeReq?.warehouseId = value.warehouseId;
        this._saleBeforeReq?.tax = value.tax;
      } else {
        this._saleReq = CreateSaleReq();
        this._saleReq?.customerId = value.customerId;
        this._saleReq?.goodsList = [];
        this._saleReq?.wipeOffAmount = value.wipeOffAmount;
        this._saleReq?.id = value.id;
        this._saleReq?.customizeTime =
            DateUtils.string2Date(value.customizeTime);
        this._saleReq?.warehouseId = value.warehouseId;
        this._saleReq?.tax = value.tax;
      }
      return await CustomerApi.getCustomer(value.customerId).then((customer) {
        this._customer = customer;
        calculate();
      });
    });
  }

  Future loadHangOrderData() async {
    await HangOrderQuery.getHangOrder(_orderId!).then((value) {
      this._saleReq = value.saleReq;
      this._saleBeforeReq = value.saleBeforeReq;
      this._customer = value.customer;
      this._saleList.addAll(value.saleGoodsList ?? []);
      this._returnList.addAll(value.returnGoodsList ?? []);
      this._oweList.addAll(value.oweGoodsList ?? []);
      this._saleSkuMap.addAll(value.saleGoodsSku ?? {});
      this._returnSkuMap.addAll(value.returnGoodsSku ?? {});
      this._oweSkuMap.addAll(value.oweGoodsSku ?? {});
      this._isSubstandard =
          this._saleReq?.substandard == SaleSubstandardEnum.YES;
      if (type == TYPE_QUOTATION) {
        this._saleBeforeReq?.goodsBeforeList.forEach((element) {
          this._saleCountMap[element.goodsId!] = element.goodsNum ?? 0;
        });
      } else {
        this._saleReq?.goodsList.forEach((element) {
          if (element.type == SaleTypeEnum.NORMAL_SALE) {
            this._saleCountMap[element.goodsId!] = element.goodsNum ?? 0;
          } else if (element.type == SaleTypeEnum.CHANGE_BACK_ORDER) {
            this._oweCountMap[element.oweGoodsId!] =
                (element.goodsNum ?? 0).abs();
          } else {
            this._returnCountMap[element.goodsId!] =
                (element.goodsNum ?? 0).abs();
          }
        });
      }
      if (_submitOrder ?? false) {
        showOrderDetail(Get.context!, this);
      }
    });
  }

  Map<int, List> _getSaleGoodsSku(
      List<SaleDetailDoSaleGoodsList> saleGoodsList) {
    var map = <int, List>{};
    saleSkuMap.forEach((key, value) {
      if (saleGoodsList.indexWhere((element) => element.goodsId == key) != -1) {
        map[key] = value;
      }
    });
    return map;
  }

  Map<int, List> _getReturnGoodsSku(
      List<SaleDetailDoSaleGoodsList> returnGoodsList) {
    var map = <int, List>{};
    returnSkuMap.forEach((key, value) {
      if (returnGoodsList.indexWhere((element) => element.goodsId == key) !=
          -1) {
        map[key] = value;
      }
    });
    return map;
  }

  Map<int, List> _getOweGoodsSku(List<SaleDetailDoSaleGoodsList> oweGoodsList) {
    var map = <int, List>{};
    oweSkuMap.forEach((key, value) {
      if (oweGoodsList.indexWhere((element) => element.id == key) != -1) {
        map[key] = value;
      }
    });
    return map;
  }

  List<SaleDetailDoSaleGoodsList> getSaleGoodsList() {
    var list = <SaleDetailDoSaleGoodsList>[];
    saleList.forEach((element) {
      if (element is SaleDetailDoSaleGoodsList &&
          (saleSelectMap[element.goodsId] ?? 0) > 0) {
        list.add(element);
      }
    });
    return list;
  }

  List<SaleDetailDoSaleGoodsList> getReturnGoodsList() {
    var list = <SaleDetailDoSaleGoodsList>[];
    returnList.forEach((element) {
      if (element is SaleDetailDoSaleGoodsList &&
          (returnSelectMap[element.goodsId] ?? 0) > 0) {
        list.add(element);
      }
    });
    return list;
  }

  List<SaleDetailDoSaleGoodsList> getOweGoodsList() {
    var list = <SaleDetailDoSaleGoodsList>[];
    oweList.forEach((element) {
      if (element is SaleDetailDoSaleGoodsList &&
          (oweSelectMap[element.id] ?? 0) > 0) {
        list.add(element);
      }
    });
    return list;
  }

  SaleGoodsBeforeReq? getSaleGoodsBeforeReq(int goodsId) {
    if (type == TYPE_QUOTATION) {
      return saleBeforeReq?.goodsBeforeList.firstWhere(
          (element) => goodsId == element.goodsId,
          orElse: () => SaleGoodsBeforeReq());
    }
  }

  SaleGoodsReq? getSaleGoodsReq(int goodsId) {
    return saleReq?.goodsList.firstWhere(
        (element) =>
            element.type == SaleTypeEnum.NORMAL_SALE &&
            goodsId == element.goodsId,
        orElse: () => SaleGoodsReq());
  }

  SaleGoodsReq? getReturnGoodsReq(int goodsId) {
    return saleReq?.goodsList.firstWhere(
        (element) =>
            element.type == SaleTypeEnum.RETURN_GOODS &&
            goodsId == element.goodsId,
        orElse: () => SaleGoodsReq());
  }

  SaleGoodsReq? getOweGoodsReq(int id) {
    return saleReq?.goodsList.firstWhere(
        (element) =>
            element.type == SaleTypeEnum.CHANGE_BACK_ORDER &&
            id == element.oweGoodsId,
        orElse: () => SaleGoodsReq());
  }

  setSubstandard(value) {
    _isSubstandard = value;
    calculate(updateList: [idSubstandardGoods, idNormalGoods]);
  }

  addGoods(SaleTypeEnum type, dynamic value) {
    if (value is GoodsSkuEntity) {
      if (type == SaleTypeEnum.NORMAL_SALE) {
        if (_currTab != idSaleTab) {
          updateSelectTab(idSaleTab, _currTab);
        }
        if (!saleSkuMap.containsKey(value.goods.id)) {
          /// 转换为订单模型
          var saleGoods = SaleDetailDoSaleGoodsList();
          saleGoods.goodsId = value.goods.id;
          saleGoods.storeGoods = SaleDetailDoSaleGoodsListStoreGoods();
          saleGoods.storeGoods!.goods = value.goods;
          saleGoods.storeGoods!.imgPath = value.goods.imgPath;
          saleGoods.storeGoods!.cover = value.goods.cover;
          saleGoods.storeGoods!.goodsName = value.goods.goodsName;
          saleGoods.storeGoods!.goodsSerial = value.goods.goodsSerial;
          saleGoods.storeGoods!.id = value.goods.id;
          saleGoods.salePrice = getGoodsPrice(saleGoods, addSaleGoods: true);
          saleList.add(saleGoods);

          /// 添加sku
          saleSkuMap[value.goods.id!] =
              value.storeGoodsVos.map((e) => e.toJson()).toList();
          eventBus
              .fire(new AddGoodsEvent(value.goods.id as int, tag: idSaleList));
          update([
            idSaleList,
            idSaleHeader,
            idGoodsStatistics,
            idAmountStatistics,
            idSaleEmpty,
          ]);
        } else {
          eventBus.fire(new AddGoodsEvent(value.goods.id as int,
              fixGoodsId: value.goods.id, tag: idSaleList));
        }
      } else if (type == SaleTypeEnum.RETURN_GOODS) {
        if (_currTab != idReturnTab) {
          updateSelectTab(idReturnTab, _currTab);
        }
        if (!returnSkuMap.containsKey(value.goods.id)) {
          /// 转换为订单模型
          var returnGoods = SaleDetailDoSaleGoodsList();
          returnGoods.goodsId = value.goods.id;
          returnGoods.storeGoods = SaleDetailDoSaleGoodsListStoreGoods();
          returnGoods.storeGoods!.goods = value.goods;
          returnGoods.storeGoods!.imgPath = value.goods.imgPath;
          returnGoods.storeGoods!.cover = value.goods.cover;
          returnGoods.storeGoods!.goodsName = value.goods.goodsName;
          returnGoods.storeGoods!.goodsSerial = value.goods.goodsSerial;
          returnGoods.storeGoods!.id = value.goods.id;
          returnGoods.salePrice = getGoodsPrice(returnGoods, addSaleGoods: true);
          returnList.add(returnGoods);

          /// 添加sku
          returnSkuMap[value.goods.id!] =
              value.storeGoodsVos.map((e) => e.toJson()).toList();
          eventBus.fire(
              new AddGoodsEvent(value.goods.id as int, tag: idReturnList));
          update([
            idReturnList,
            idReturnHeader,
            idGoodsStatistics,
            idAmountStatistics,
            idReturnEmpty,
          ]);
        } else {
          eventBus.fire(new AddGoodsEvent(value.goods.id as int,
              fixGoodsId: value.goods.id, tag: idReturnList));
        }
      } else {
        if (_currTab != idOweTab) {
          updateSelectTab(idOweTab, _currTab);
        }
        int? key = value.saleGoodsList.id;
        saleReq?.goodsList.forEach((element) {
          int? target;
          if (element.id == null) {
            target = element.oweGoodsId;
          } else {
            target = element.relationOrderSaleGoodsId;
          }
          if (target == key && element.id != null) {
            key = element.id;
          }
        });
        if (!oweSkuMap.containsKey(key)) {
          /// 转换为订单模型
          var oweGoods = value.saleGoodsList;
          var addFlag = false;
          for (var item in oweList) {
            if (item is SaleDetailDoSaleGoodsList &&
                item.orderSaleId == oweGoods.orderSaleId) {
              addFlag = true;
            } else if (addFlag) {
              var index = oweList.indexOf(item);
              oweList.insert(index, oweGoods);
              break;
            }
          }
          if (!addFlag) {
            oweList.add(oweGoods);
          }

          /// 添加sku
          oweSkuMap[key!] = value.storeGoodsVos.map((e) => e.toJson()).toList();
          eventBus.fire(new AddGoodsEvent(key as int, tag: idOweList));
          update([
            idOweList,
            idOweHeader,
            idGoodsStatistics,
            idAmountStatistics,
            idOweEmpty,
          ]);
        } else {
          eventBus.fire(
              new AddGoodsEvent(key as int, fixGoodsId: key, tag: idOweList));
        }
      }
    }
  }

  updateCustomer(StoreCustomerListItemDoEntity customer) {
    if (_customer?.id == customer.id) return;
    this._customer = customer;
    oweList.clear();
    oweSkuMap.clear();
    oweSelectMap.clear();
    returnList.clear();
    returnSkuMap.clear();
    returnSelectMap.clear();
    calculate();
    if (!taxSetting) {
      setTax(customer.tax ?? 0);
      calculate();
    }
    update([idCustomer, idSaleList, idReturnList, idOweList, idAmountStatistics, idSaleHeader]);
    if (type == TYPE_OFFLINE_SALE) return;
    updateGoodsLastBuyPrice();
  }

  updateGoodsSalePrice() {
    saleList.forEach((element) {
      if (element is SaleDetailDoSaleGoodsList) {
        element.salePrice = getGoodsPrice(element);
      }
    });
    calculate();
    update([
      idSaleList,
      idGoodsStatistics,
      idSaleHeaderStatistics,
      idAmountStatistics,
    ]);
  }

  updateGoodsLastBuyPrice() {
    if (!hasSale) return;
    var param = BatchCustomerBuyPriceReqEntity();
    param.deptId = _deptId;
    param.customerId = customerId;
    param.goodsIds = [];
    saleList.forEach((element) {
      if (element is SaleDetailDoSaleGoodsList) {
        param.goodsIds?.add(element.goodsId!);
      }
    });
    GoodsApi.getGoodsLastPrice(param).then((value) {
      value.forEach((goodsInfo) {
        SaleDetailDoSaleGoodsList saleGoods = saleList.firstWhere((element) =>
            (element is SaleDetailDoSaleGoodsList &&
                element.goodsId == goodsInfo.goodsId));
        saleGoods.storeGoods?.goods?.lastBuyPrice = goodsInfo.price;
      });
      updateGoodsSalePrice();
    });
  }

  getRetailStoreCustomer() {
    CustomerApi.getRetailStoreCustomer(deptId, online: online)
        .then((value) => updateCustomer(value));
  }

  updateSelectTab(String curr, String perv) {
    _currTab = curr;
    update([curr, perv, idTabWidget]);
  }

  void deleteSaleGoods(int id) {
    saleList.removeWhere((element) =>
        (element is SaleDetailDoSaleGoodsList && element.goodsId == id));
    saleSkuMap.remove(id);
    if (saleSkuMap.isEmpty) update([idSaleList]);
    updateSaleGoodsCount({id: 0});
  }

  void deleteReturnGoods(int id) {
    returnList.removeWhere((element) =>
        (element is SaleDetailDoSaleGoodsList && element.goodsId == id));
    returnSkuMap.remove(id);
    if (returnSkuMap.isEmpty) update([idReturnList]);
    updateReturnGoodsCount(id, 0);
  }

  void deleteOweGoods(int id) {
    oweList.removeWhere((element) =>
        (element is SaleDetailDoSaleGoodsList && element.id == id));
    oweSkuMap.remove(id);
    if (oweSkuMap.isEmpty) update([idOweList]);
    updateOweGoodsCount(id, 0);
  }

  updateSaleGoodsCount(Map<int, int> data) {
    var list = [
      idGoodsStatistics,
      idSaleHeaderStatistics,
      idAmountStatistics,
      idSaleHeader,
      idTabWidget,
    ];
    data.forEach((key, value) {
      list.add(idSaleGoods(key));
      if (value == 0) {
        saleSelectMap.remove(key);
      } else {
        saleSelectMap[key] = value;
      }
    });
    calculate();
    update(list);
  }

  updateReturnGoodsCount(int key, int count) {
    if (count == 0) {
      returnSelectMap.remove(key);
    } else {
      returnSelectMap[key] = count;
    }
    calculate();
    update([
      idReturnGoods(key),
      idGoodsStatistics,
      idReturnHeaderStatistics,
      idAmountStatistics,
      idReturnHeader,
      idTabWidget,
    ]);
  }

  updateOweGoodsCount(int key, int count) {
    if (count == 0) {
      oweSelectMap.remove(key);
    } else {
      oweSelectMap[key] = count;
    }
    calculate();
    update([
      idOweGoods(key),
      idGoodsStatistics,
      idOweHeaderStatistics,
      idAmountStatistics,
      idOweHeader,
      idTabWidget,
    ]);
  }

  calculate({List<String>? updateList}) {
    if (TYPE_QUOTATION == type) {
      _calculateQuotation();
    } else {
      _calculateSale();
    }

    if (updateList != null) {
      update(updateList);
    }
  }

  _calculateQuotation() {
    var goodsList = <SaleGoodsBeforeReq>[];

    /// 销售商品参数
    saleSkuMap.forEach((key, value) {
      /// 初始化sku参数
      var saleGoodsSkus = <SaleGoodsSkuBeforeReq>[];
      value.forEach((element) {
        var skuInfo = SkuInfoEntity().fromJson(element);
        skuInfo.sizes?.forEach((element) {
          if ((element.data?.num ?? 0) > 0) {
            saleGoodsSkus
                .add(SaleUtils.createGoodsSkuBeforeReq(key, element.data!));
          }
        });
      });

      /// 存在sku数量
      if (saleGoodsSkus.isNotEmpty) {
        /// 初始化货品参数
        SaleDetailDoSaleGoodsList saleGoods = saleList.firstWhere((element) =>
            (element is SaleDetailDoSaleGoodsList && key == element.goodsId));
        goodsList.add(SaleUtils.createGoodsBeforeReq(saleGoodsSkus, saleGoods));
      }
    });

    _saleBeforeReq = SaleUtils.createSaleBeforeReq(
      deptId,
      customerId,
      goodsList,
      wipeOffAmount: saleBeforeReq?.wipeOffAmount,
      id: saleBeforeReq?.id,
      dateTime: saleBeforeReq?.customizeTime,
      remark: saleBeforeReq?.remark,
      warehouseId: saleBeforeReq?.warehouseId,
      tax: saleBeforeReq?.tax,
    );
    if (goodsList.isNotEmpty)
      CalculateSaleBeforeAmountUtil.calculateSaleAmount(saleBeforeReq!, 0);
  }

  _calculateSale() {
    var goodsList = <SaleGoodsReq>[];

    /// 销售商品参数
    saleSkuMap.forEach((key, value) {
      /// 初始化sku参数
      var saleGoodsSkus = <SaleGoodsSkuReq>[];
      value.forEach((element) {
        var skuInfo = SkuInfoEntity().fromJson(element);
        skuInfo.sizes?.forEach((element) {
          if ((element.data?.num ?? 0) > 0) {
            saleGoodsSkus.add(SaleUtils.createSaleGoodsSku(key, element.data!));
          }
        });
      });

      /// 存在sku数量
      if (saleGoodsSkus.isNotEmpty) {
        /// 初始化货品参数
        SaleDetailDoSaleGoodsList saleGoods = saleList.firstWhere((element) =>
            (element is SaleDetailDoSaleGoodsList && key == element.goodsId));
        goodsList.add(SaleUtils.createSaleGoods(saleGoods, saleGoodsSkus));
      }
    });

    /// 退实物商品参数
    returnSkuMap.forEach((key, value) {
      /// 初始化sku参数
      var returnGoodsSkus = <SaleGoodsSkuReq>[];
      value.forEach((element) {
        var skuInfo = SkuInfoEntity().fromJson(element);
        skuInfo.sizes?.forEach((element) {
          if ((element.data?.num ?? 0) != 0) {
            returnGoodsSkus
                .add(SaleUtils.createReturnGoodsSku(key, element.data!));
          }
        });
      });

      /// 存在sku数量
      if (returnGoodsSkus.isNotEmpty) {
        /// 初始化货品参数
        SaleDetailDoSaleGoodsList returnGoods = returnList.firstWhere(
            (element) => (element is SaleDetailDoSaleGoodsList &&
                key == element.goodsId));
        goodsList
            .add(SaleUtils.createReturnGoods(returnGoods, returnGoodsSkus));
      }
    });

    /// 退欠货商品参数
    oweSkuMap.forEach((key, value) {
      /// 初始化sku参数
      var oweGoodsSkus = <SaleGoodsSkuReq>[];
      SaleDetailDoSaleGoodsList oweGoods = oweList.firstWhere((element) =>
          (element is SaleDetailDoSaleGoodsList && key == element.id));
      value.forEach((element) {
        var skuInfo = SkuInfoEntity().fromJson(element);
        skuInfo.sizes?.forEach((element) {
          if ((element.data?.num ?? 0) != 0) {
            oweGoodsSkus
                .add(SaleUtils.createOweGoodsSku(key, element.data!, isEdit));
          }
        });
      });

      /// 存在sku数量
      if (oweGoodsSkus.isNotEmpty) {
        /// 初始化货品参数
        goodsList.add(SaleUtils.createOweGoods(oweGoods, oweGoodsSkus, isEdit));
      }
    });

    int? warehouseId;
    if (distributionId != null) {
      if (distributionId is String) {
        warehouseId = int.tryParse(distributionId);
      } else if (distributionId is int) {
        warehouseId = distributionId;
      }
      distributionId = null;
    }
    _saleReq = SaleUtils.createSaleReq(
      deptId,
      customerId,
      isSubstandard,
      goodsList,
      wipeOffAmount: saleReq?.wipeOffAmount,
      id: saleReq?.id,
      dateTime: saleReq?.customizeTime,
      remark: saleReq?.remark,
      delivery: warehouseId == null ? saleReq?.delivery : false,
      warehouseId: warehouseId ?? saleReq?.warehouseId,
      tax: saleReq?.tax,
      configNormalSalePrice: saleLastPrice,
      configReturnGoodsPrice: returnLastPrice,
    );
    if (goodsList.isNotEmpty)
      CalculateSaleAmountUtil.calculateSaleAmount(saleReq!, checkAmount);
  }

  int getGoodsPrice(SaleDetailDoSaleGoodsList saleGoods, {bool addSaleGoods = false}) {
    if ((isEdit ||
            _copyOrderSaleId != null ||
            saleGoods.storeGoods?.goods == null) &&
        saleGoods.salePrice != null) return saleGoods.salePrice!;
    var goods = saleGoods.storeGoods!.goods!;
    int price = goods.sailingPrice ?? 0;
    if (customer == null) {
      return price;
    } else {
      if (customer!.levelTag == "B") {
        price = goods.takingPrice ?? price;
      } else if (customer!.levelTag == "C") {
        price = goods.packagePrice ?? price;
      }
      if (saleLastPrice && (saleList.contains(saleGoods) || addSaleGoods)) {
        return goods.lastBuyPrice ?? price;
      } else if (returnLastPrice && (returnList.contains(saleGoods) || addSaleGoods)) {
        return goods.lastBuyPrice ?? price;
      } else {
        return price;
      }
    }
  }

  hangOrder() {
    if (type == TYPE_QUOTATION &&
        (saleBeforeReq?.goodsBeforeList.isEmpty ?? true)) {
      toastMsg("请选择货品");
      return;
    } else if (type != TYPE_QUOTATION && (saleReq?.goodsList.isEmpty ?? true)) {
      toastMsg("请选择货品");
      return;
    }
    var goodsData = <String, List<SaleDetailDoSaleGoodsList>>{};
    var skuMap = <String, Map<int, List>>{};
    //获取销售货品和sku信息
    var saleGoodsList = getSaleGoodsList();
    goodsData[EnumCoverUtils.enumsToString(SaleTypeEnum.NORMAL_SALE)!] =
        saleGoodsList;
    skuMap[EnumCoverUtils.enumsToString(SaleTypeEnum.NORMAL_SALE)!] =
        _getSaleGoodsSku(saleGoodsList);
    if (type == SaleEnterController.TYPE_OFFLINE_SALE) {
      //获取退实物货品和sku信息
      var returnGoodsList = getReturnGoodsList();
      goodsData[EnumCoverUtils.enumsToString(SaleTypeEnum.RETURN_GOODS)!] =
          returnGoodsList;
      skuMap[EnumCoverUtils.enumsToString(SaleTypeEnum.RETURN_GOODS)!] =
          _getReturnGoodsSku(returnGoodsList);
    } else if (type == SaleEnterController.TYPE_SALE) {
      //获取退实物货品和sku信息
      var returnGoodsList = getReturnGoodsList();
      goodsData[EnumCoverUtils.enumsToString(SaleTypeEnum.RETURN_GOODS)!] =
          returnGoodsList;
      skuMap[EnumCoverUtils.enumsToString(SaleTypeEnum.RETURN_GOODS)!] =
          _getReturnGoodsSku(returnGoodsList);
      //获取退欠货货品和sku信息
      var oweGoodsList = getOweGoodsList();
      goodsData[EnumCoverUtils.enumsToString(SaleTypeEnum.CHANGE_BACK_ORDER)!] =
          oweGoodsList;
      skuMap[EnumCoverUtils.enumsToString(SaleTypeEnum.CHANGE_BACK_ORDER)!] =
          _getOweGoodsSku(oweGoodsList);
    }
    if (_orderId != null) {
      _deleteHangOrder().then((value) => HangOrderQuery.insert(
              saleReq, saleBeforeReq, customer, goodsData, skuMap, type)
          .then((value) => toastMsg("挂单成功"))
          .then((value) => _backToHangOrderPage()));
    } else {
      HangOrderQuery.insert(
              saleReq, saleBeforeReq, customer, goodsData, skuMap, type)
          .then((value) => toastMsg("挂单成功"))
          .then((value) => _backToHangOrderPage());
    }
  }

  _backToHangOrderPage() {
    if (BackUtils.canPop()) {
      BackUtils.back();
      eventBus.fire(UpdateHangOrderEvent());
    } else {
      Get.offNamed(ArgUtils.map2String(
          path: Routes.HANG_ORDER_WORKBENCH,
          arguments: {Constant.DEPT_ID: deptId}));
    }
  }

  Future<int> createCustomer(StoreCustomerListItemDoEntity customer) async {
    var req = StoreCustomerCreateReqEntity();
    req.deptId = customer.deptId;
    req.customerPhone = customer.customerPhone;
    req.customerName = customer.customerName;
    req.levelTag = customer.levelTag;
    req.status = customer.status;
    req.star = customer.star;
    req.tax = 0;
    var customerId = await CustomerApi.createCustomer(req,
        online: true, customerId: customer.id);
    await CustomerQuery.updateCustomerId(
        customerId, customer.deptId!, customer.id!);
    return customerId;
  }

  Future<SaleDoEntity> createOrder() async {
    if (customer == null) {
      return await Future.error(toastMsg("请录入客户"));
    } else if (!hasSale && !hasReturn && !hasOwe) {
      return await Future.error(toastMsg("请录入货品"));
    } else if (goodsLen == 0) {
      return await Future.error(toastMsg("请选择货品数量"));
    }

    if ((customer!.offline ?? 0) == 1) {
      var customerId = await createCustomer(customer!);
      customer!.id = customerId;
    }

    calculate();
    if (_orderSaleId == null) {
      if (type == TYPE_QUOTATION) {
        return await SaleApi.createSaleBefore(saleBeforeReq!, showLoading: true)
            .then((value) {
          if (_orderId != null) {
            return _deleteHangOrder().then((_) => value);
          }
          return value;
        });
      }
      String text = jsonEncode(saleReq!);
      return await SaleApi.createSaleOrder(saleReq!, showLoading: true).then(
          (value) {
        if (_orderId != null) {
          return _deleteHangOrder().then((_) => value);
        }
        return value;
      }, onError: (err) {
        if (err.error.error is SocketException) {
          Future.delayed(Duration(milliseconds: 300))
              .then((value) => toastMsg("当前网络连接不可用，请先挂单"));
        }
      });
    } else {
      return await SaleApi.updateSaleOrder(saleReq!);
    }
  }

  Future _deleteHangOrder() {
    return HangOrderQuery.delete(id: _orderId);
  }

  Future<List<CustomerDeptRelationDo>> getRelationList() {
    if (deptRelationList == null && type == TYPE_SALE) {
      return CustomerDeptApi.selectRelation(deptId).then((value) {
        deptRelationList = value;
        return deptRelationList!;
      });
    }
    return Future.value(deptRelationList ?? []);
  }

  onKeyBordChange(bool change) {
    _showKeyBord = change;
    update([idCustomer]);
  }

  Future<List<StoreDiscountTemplateDo>> getDiscountTemplate() async {
    var param = StoreDiscountTemplateReq();
    param.status = Status.ENABLE;
    param.style = StoreDiscountTemplateEnum.CLEARANCE;
    param.customerDeptId = deptId;
    return await StoreApi.getDiscountTemp(param, online: online);
  }

  addReturnGoods(SaleDetailDoSaleGoodsList saleGoods) {
    _getGoodsSku(saleGoods, SaleTypeEnum.RETURN_GOODS);
  }

  addSaleGoods(SaleDetailDoSaleGoodsList saleGoods) {
    _getGoodsSku(saleGoods, SaleTypeEnum.NORMAL_SALE);
  }

  _getGoodsSku(
      SaleDetailDoSaleGoodsList saleGoods, SaleTypeEnum typeEnum) async {
    if (customer == null) {
      toastMsg("请选择客户");
      return;
    }
    Goods goods;
    List<SkuInfoEntity> skus;
    int selectNum;
    if (typeEnum == SaleTypeEnum.NORMAL_SALE) {
      selectNum = saleSelectMap[saleGoods.goodsId] ?? 0;
    } else {
      selectNum = returnSelectMap[saleGoods.goodsId] ?? 0;
    }
    if (selectNum == 0) {
      goods = await _getSingleGoods(saleGoods);
      skus = await _getSingleGoodsSkus(goods, typeEnum);
    } else {
      goods = Goods();
      goods.id = saleGoods.goodsId;
      skus = [];
    }
    var goodsSku = GoodsSkuEntity(goods, skus, SaleDetailDoSaleGoodsList());
    addGoods(typeEnum, goodsSku);
  }

  Future<Goods> _getSingleGoods(SaleDetailDoSaleGoodsList saleGoods) async {
    var page = BasePage();
    page.pageNo = 1;
    page.pageSize = 10;
    GoodsPageParam param = new GoodsPageParam();
    param.deptId = deptId;
    param.status = PullOrOff.ON;
    param.selectType = SelectType.BASIC_STATIC;
    param.customerId = customerId;
    param.isBasePrice = false;
    param.goodsSerial = saleGoods.storeGoods?.goodsSerial;
    param.goodsIds = [saleGoods.goodsId!];
    param.returnCustomerDeliveryNum = true;
    page.param = param;
    var goodsList =
        await GoodsApi.page(page, online: online, showLoading: true);
    var goods = goodsList.firstWhere((element) => element.id == param.goodsIds?[0], orElse: () => Goods());
    if (goods.id == null) return Future.error(toastMsg("加载货品失败"));
    return goods;
  }

  _getSingleGoodsSkus(Goods goods, SaleTypeEnum typeEnum) async {
    var params = StoreGoodsSkuReqEntity();
    params.goodsId = goods.id;
    params.deptId = deptId;
    params.customerId = customerId;
    if (typeEnum == SaleTypeEnum.RETURN_GOODS) {
      params.returnCustomerDeliveryNum = true;
    } else {
      params.returnCustomerOweNum = true;
      params.returnStock = true;
    }
    return await GoodsApi.getSkuList(params, showLoading: true, online: online);
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
