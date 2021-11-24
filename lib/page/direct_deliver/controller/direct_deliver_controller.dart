import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/req/delivery_create_delivery_req_entity.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/req/sale_create_delivery_req_entity.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/req/store_dict_req_entity.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/res/delivery_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';
import 'package:haidai_flutter_module/repository/base/store.dart';
import 'package:haidai_flutter_module/repository/order/delivery_api.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';

class DirectDeliverController extends SuperController {
  /// id
  static const idCustomer = "idCustomer";
  static const idGoodsList = "idGoodsList";
  static const idHeader = "idHeader";
  static const idStatement = "idStatement";
  static const idLogisticsCompany = "idLogisticsCompany";
  static const idOrderInfoDate = "idOrderInfoDate";
  static const idPhotoVoucher = "idPhotoVoucher";
  static const idEmpty = "idEmpty";

  static idFillGoods(int orderSaleGoodsId) => "idFillGoods$orderSaleGoodsId";

  static idGoodsNum(goodsId) => "idGoodsItem$goodsId";

  /// 参数
  var customerId = ArgUtils.getArgument2num(Constant.CUSTOMER_ID)!.toInt();
  var orderSaleId = ArgUtils.getArgument2num(Constant.ORDER_SALE_ID)?.toInt();
  var deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();
  var orderId = ArgUtils.getArgument2num(Constant.ORDER_ID)?.toInt();

  /// 属性
  var param = DeliveryCreateDeliveryReqEntity();

  DeliveryDetailDoEntity? deliverData;
  StoreCustomerListItemDoEntity? customer;
  List<dynamic> goodsList = [];
  var skuMap = <int, List<dynamic>>{};

  Map<int, int> selectMap = {};

  List<StoreDictData> logisticsCompanyList = [];

  get goodsNumTotal {
    int sum = 0;
    selectMap.forEach((key, value) => sum += value);
    return sum;
  }

  get priceTotal {
    int price = 0;
    selectMap.forEach((key, value) {
      DeliveryDetailDoDeliveryGoodsList goods = goodsList
          .firstWhere((element) => element is DeliveryDetailDoDeliveryGoodsList && element.orderSaleGoodsId == key);
      price += value * (goods.taxPrice ?? 0);
    });
    return price;
  }

  get goodsStyleNum {
    var set = Set<int>();
    selectMap.forEach((key, value) {
      if (value > 0) {
        DeliveryDetailDoDeliveryGoodsList goods = goodsList
            .firstWhere((element) => element is DeliveryDetailDoDeliveryGoodsList && element.orderSaleGoodsId == key);
        set.add(goods.goodsId!);
      }
    });
    return set.length;
  }

  getGoodsNum(int orderGoodsId) => selectMap[orderGoodsId] ?? 0;

  /// 方法
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await createDeliverData();
    getLogisticsCompany();
  }

  createDeliverData() async {
    customer = await CustomerApi.getCustomer(customerId, showLoading: true);
    var req = SaleCreateDeliveryReqEntity();
    req.customerId = customerId;
    req.deptId = deptId;
    req.orderSaleId = orderSaleId;
    req.warehouseId = deptId;
    req.orderDeliveryId = orderId;
    deliverData = await SaleApi.createDelivery(req, showLoading: true);

    param.customizeTime =
        deliverData?.customizeTime ?? TimeUtils.getTime(DateTime.now(), format: "yyyy-MM-dd HH:mm:ss");
    param.remark = deliverData?.remark;
    param.logisticsNo = deliverData?.logisticsNo;
    param.logisticsCompanyName = deliverData?.logisticsCompanyName;
    param.logisticsCompanyId = deliverData?.logisticsCompanyId;

    // goodsList.addAll(deliverData!.deliveryGoodsList ?? []);

    deliverData!.deliveryGoodsList?.forEach((element) {
      int count = 0;
      skuMap[element.orderSaleGoodsId!] = element.orderGoodsVoList?.map((e) {
            if (orderId != null) {
              e.sizes?.forEach((element) {
                element.data?.num = element.data?.goodsNum;
                count += element.data?.goodsNum ?? 0;
              });
            }
            return e.toJson();
          }).toList() ??
          [];
      selectMap[element.orderSaleGoodsId!] = count;

      int index = goodsList.lastIndexWhere((goods) {
        if (goods is DeliveryDetailDoDeliveryGoodsList && goods.orderSaleId == element.orderSaleId) {
          return true;
        }
        return false;
      });
      if (index == -1) {
        goodsList.add(element);
      } else {
        goodsList.insert(index + 1, element);
      }
    });
    update([idCustomer, idGoodsList, idHeader, idStatement, idEmpty]);
  }

  updateGoodsNum(int key, int itemAdd) {
    selectMap[key] = itemAdd;
    update([idGoodsNum(key), idHeader, idStatement, idFillGoods(key), idEmpty]);
  }

  Future<List<StoreDictData>> getLogisticsCompany() async {
    if (logisticsCompanyList.isNotEmpty) {
      return logisticsCompanyList;
    }
    var param = StoreDictReqEntity();
    param.customerDeptId = deptId;
    param.dictType = "LOGISTICS_COMPANY";
    logisticsCompanyList = await StoreApi.selectByParam(param);
    return logisticsCompanyList;
  }

  selectLogisticsCompany(StoreDictData dictData) {
    param.logisticsCompanyName = dictData.dictName;
    param.logisticsCompanyId = dictData.id;
    update([idLogisticsCompany]);
  }

  Future createDeliverOrder({bool checkStock = true}) async {
    if (param.logisticsCompanyId == null && param.logisticsCompanyName != null) {
      var index = logisticsCompanyList.indexWhere((element) => element.dictName == param.logisticsCompanyName);
      if (index == -1) {
        var dict = StoreDictData();
        dict.dictName = param.logisticsCompanyName;
        dict.deptId = deptId;
        dict.status = CanceledEnum.ENABLE;
        dict.dictType = "LOGISTICS_COMPANY";
        param.logisticsCompanyId = await StoreApi.saveOrUpdateStoreDict(dict);
      } else {
        param.logisticsCompanyId = logisticsCompanyList[index].id;
      }
    }
    if (orderId != null) {
      return updateDeliverOrder(checkStock: checkStock);
    }
    // param.deliveryGoodsList = [];
    // selectMap.forEach((key, value) {
    //   if (value > 0) {
    //     var goods = deliverData!.deliveryGoodsList
    //         ?.firstWhere((element) => element.orderSaleGoodsId == key);
    //     var jsonList = skuMap[goods!.orderSaleGoodsId];
    //     var skuList = jsonList?.map((e) => SkuInfoEntity().fromJson(e))
    //         .toList();
    //     skuList?.forEach((sku) {
    //       sku.sizes?.forEach((size) {
    //         var deliverSize = goods.deliveryGoodsSkuList?.firstWhere((
    //             element) =>
    //         element.orderSaleGoodsSkuId == size.data?.orderSaleGoodsSkuId);
    //         deliverSize?.goodsNum = size.data?.num;
    //       });
    //     });
    //     goods.goodsNum = selectMap[goods.orderSaleGoodsId];
    //     param.deliveryGoodsList!.add(goods);
    //   }
    // });
    // param.deptId = deptId;
    // param.warehouseId = deptId;
    // param.customerId = customerId;
    param.deliveryGoodsList = [];
    var tempDeliverData = DeliveryDetailDoEntity().fromJson(deliverData!.toJson());
    selectMap.forEach((key, value) {
      if (value > 0) {
        var goods = tempDeliverData.deliveryGoodsList?.firstWhere((element) => element.orderSaleGoodsId == key);
        var jsonList = skuMap[goods!.orderSaleGoodsId];
        var skuList = jsonList?.map((e) => SkuInfoEntity().fromJson(e)).toList() ?? [];
        skuList.forEach((sku) {
          var filterSkuSize = <SkuInfoSize>[];
          sku.sizes?.forEach((size) {
            int num = size.data?.num ?? 0;
            if (num > 0) {
              var deliverSize = goods.deliveryGoodsSkuList
                  ?.firstWhere((element) => element.orderSaleGoodsSkuId == size.data?.orderSaleGoodsSkuId);
              deliverSize?.goodsNum = num;
              filterSkuSize.add(size);
            }
          });
          sku.sizes = filterSkuSize;
        });
        var goodsSkuList = goods.deliveryGoodsSkuList;
        goods.deliveryGoodsSkuList = [];
        goodsSkuList?.forEach((goodsSku) {
          int index = skuList.indexWhere((element) {
            var has = false;
            element.sizes?.forEach((element) {
              if (element.data?.orderSaleGoodsSkuId == goodsSku.orderSaleGoodsSkuId) {
                has = true;
              }
            });
            return has;
          });
          if (index != -1) {
            goods.deliveryGoodsSkuList?.add(goodsSku);
          }
        });
        goods.orderGoodsVoList = skuList;
        goods.goodsNum = selectMap[goods.orderSaleGoodsId];
        param.deliveryGoodsList!.add(goods);
      }
    });
    param.deptId = deptId;
    param.warehouseId = deptId;
    param.customerId = customerId;
    param.id = orderId;

    var json = jsonEncode(param.toJson());
    if (checkStock) {
      var check = await DeliveryApi.batchCheckDeliveryStock(param);
      if (check) {
        return param;
      }
    }
    return await DeliveryApi.createDelivery(param);
  }

  Future updateDeliverOrder({bool checkStock = true}) async {
    param.deliveryGoodsList = [];
    var tempDeliverData = DeliveryDetailDoEntity().fromJson(deliverData!.toJson());
    selectMap.forEach((key, value) {
      if (value > 0) {
        var goods = tempDeliverData.deliveryGoodsList?.firstWhere((element) => element.orderSaleGoodsId == key);
        var jsonList = skuMap[goods!.orderSaleGoodsId];
        var skuList = jsonList?.map((e) => SkuInfoEntity().fromJson(e)).toList() ?? [];
        skuList.forEach((sku) {
          var filterSkuSize = <SkuInfoSize>[];
          sku.sizes?.forEach((size) {
            int num = size.data?.num ?? 0;
            if (num > 0) {
              var deliverSize = goods.deliveryGoodsSkuList
                  ?.firstWhere((element) => element.orderSaleGoodsSkuId == size.data?.orderSaleGoodsSkuId);
              deliverSize?.goodsNum = num;
              filterSkuSize.add(size);
            }
          });
          sku.sizes = filterSkuSize;
        });
        var goodsSkuList = goods.deliveryGoodsSkuList;
        goods.deliveryGoodsSkuList = [];
        goodsSkuList?.forEach((goodsSku) {
          int index = skuList.indexWhere((element) {
            var has = false;
            element.sizes?.forEach((element) {
              if (element.data?.orderSaleGoodsSkuId == goodsSku.orderSaleGoodsSkuId) {
                has = true;
              }
            });
            return has;
          });
          if (index != -1) {
            goods.deliveryGoodsSkuList?.add(goodsSku);
          }
        });
        goods.orderGoodsVoList = skuList;
        goods.goodsNum = selectMap[goods.orderSaleGoodsId];
        param.deliveryGoodsList!.add(goods);
      }
    });
    param.deptId = deptId;
    param.warehouseId = deptId;
    param.customerId = customerId;
    param.id = orderId;
    // param.customerAddress =

    // param.consigneeImg = ;
    // param.remark = ;
    // param.customizeTime = DateUtils.date2String(DateTime.now());
    // param.logisticsCompanyId = ;
    // param.logisticsNo = ;
    // param.logisticsCompanyName = ;
    if (checkStock) {
      var check = await DeliveryApi.batchCheckDeliveryStock(param);
      if (check) {
        return param;
      }
    }
    return await DeliveryApi.updateDelivery(param);
  }

  addGoods(GoodsSkuEntity value) {
    bool has = skuMap[value.saleGoodsList.id!] != null;
    if (has) {
      eventBus.fire(new AddGoodsEvent(value.saleGoodsList.id as int, fixGoodsId: value.saleGoodsList.id));
    } else {
      var goods = value.saleGoodsList;
      var deliveryGoods = DeliveryDetailDoDeliveryGoodsList().fromJson(goods.toJson());
      deliveryGoods.orderSaleGoodsId = goods.id;
      deliveryGoods.id = null;
      deliveryGoods.storeGoods =
          DeliveryDetailDoDeliveryGoodsListStoreGoodsBaseDo().fromJson(goods.storeGoods!.toJson());
      deliveryGoods.orderGoodsVoList = value.storeGoodsVos;
      deliveryGoods.orderSaleSerial = goods.relationOrderSaleSerial;
      deliveryGoods.orderSaleCustomizeTime = goods.relationOrderSaleCustomizeTime;
      deliveryGoods.deliveryGoodsSkuList = [];
      value.storeGoodsVos.forEach((element) {
        element.sizes?.forEach((element) {
          var sku = DeliveryDetailDoDeliveryGoodsListDeliveryGoodsSkuList();
          sku.id = null;
          sku.deptId = deptId;
          sku.warehouseId = deptId;
          sku.topDeptId = goods.topDeptId;
          sku.orderSaleId = element.data?.orderSaleId;
          sku.orderSaleGoodsId = element.data?.orderSaleGoodsId;
          sku.orderSaleGoodsSkuId = element.data?.id;
          sku.goodsId = element.data?.goodsId;
          sku.skuId = element.data?.skuId;
          sku.goodsNum = element.data?.goodsNum;
          deliveryGoods.deliveryGoodsSkuList!.add(sku);
        });
      });

      deliveryGoods.warehouseId = deptId;
      // 	int? stockNum;

      int stockNum = 0;
      skuMap[deliveryGoods.orderSaleGoodsId!] = deliveryGoods.orderGoodsVoList?.map((e) {
            e.sizes?.forEach((element) {
              int num = element.data?.storeGoodsSkuStockDo?.stockNum ?? 0;
              element.data?.stockNum = num;
              stockNum += num;
            });
            return e.toJson();
          }).toList() ??
          [];
      deliveryGoods.stockNum = stockNum;

      if (deliverData!.deliveryGoodsList == null) {
        deliverData!.deliveryGoodsList = [];
      }
      deliverData!.deliveryGoodsList!.add(deliveryGoods);
      int index = goodsList.lastIndexWhere((element) {
        if (element is DeliveryDetailDoDeliveryGoodsList && element.orderSaleId == deliveryGoods.orderSaleId) {
          return true;
        }
        return false;
      });
      if (index == -1) {
        goodsList.add(deliveryGoods);
        eventBus.fire(new AddGoodsEvent(deliveryGoods.orderSaleGoodsId as int));
      } else {
        goodsList.insert(index + 1, deliveryGoods);
        eventBus
            .fire(new AddGoodsEvent(deliveryGoods.orderSaleGoodsId as int, fixGoodsId: deliveryGoods.orderSaleGoodsId));
      }

      update([idGoodsList, idHeader, idStatement, idEmpty]);
    }
  }

  deleteGoods(int orderSaleGoodsId) {
    goodsList.removeWhere(
        (element) => element is DeliveryDetailDoDeliveryGoodsList && element.orderSaleGoodsId == orderSaleGoodsId);
    skuMap.remove(orderSaleGoodsId);
    // if (skuMap.isEmpty) {
    //   goodsList.clear();
    //   update([idGoodsList]);
    // }
    selectMap.remove(orderSaleGoodsId);
    update([idHeader, idStatement, idEmpty]);
  }

  fillGoods(int orderSaleGoodsId, state) {
    var jsonList = skuMap[orderSaleGoodsId];
    var skuList = jsonList?.map((e) => SkuInfoEntity().fromJson(e)).toList();
    int count = 0;
    skuList?.forEach((element) {
      element.sizes?.forEach((element) {
        count += element.data?.shortageNum ?? 0;
        element.data?.num = element.data?.shortageNum;
      });
    });
    selectMap[orderSaleGoodsId] = count;
    skuMap[orderSaleGoodsId] = skuList?.map((e) => e.toJson()).toList() ?? [];
    state.fill(orderSaleGoodsId);
    update([idGoodsList, idHeader, idStatement, idEmpty]);
    // eventBus.fire(new AddGoodsEvent(-1));
  }

  fillAllGoods() {
    goodsList.forEach((element) {
      if (element is DeliveryDetailDoDeliveryGoodsList) {
        var orderSaleGoodsId = element.orderSaleGoodsId!;
        var jsonList = skuMap[orderSaleGoodsId];
        var skuList = jsonList?.map((e) => SkuInfoEntity().fromJson(e)).toList();
        int count = 0;
        skuList?.forEach((element) {
          element.sizes?.forEach((element) {
            count += element.data?.shortageNum ?? 0;
            element.data?.num = element.data?.shortageNum;
          });
        });
        selectMap[orderSaleGoodsId] = count;
        skuMap[orderSaleGoodsId] = skuList?.map((e) => e.toJson()).toList() ?? [];
      }
      if (element.runtimeType.toString() == "_InternalLinkedHashMap<dynamic, dynamic>" &&
          element['itemType'] == 'sku') {
        element['handleTag'] = element['thirdTag'];
      }
    });
    update([idGoodsList, idHeader, idStatement, idEmpty]);
    // eventBus.fire(new AddGoodsEvent(-1));
  }

  upload(String path) async {
    MethodChannel(ChannelConfig.flutterToNative)
        .invokeMethod(ChannelConfig.methodLogisticsPhotoVoucher, path)
        .then((value) {
      deliverData?.consigneeImg = value;
      param.consigneeImg = value;
      update([idPhotoVoucher]);
    });
  }

  bool checkOrderHead(DeliveryDetailDoDeliveryGoodsList goods, int index) {
    int find = goodsList.indexWhere((element) {
      if (element is DeliveryDetailDoDeliveryGoodsList && element.orderSaleId == goods.orderSaleId) {
        return true;
      }
      return false;
    });
    return find == index;
  }

  bool isFillGoods(int orderSaleGoodsId) {
    var fill = true;
    var sku = skuMap[orderSaleGoodsId]?.map((e) => SkuInfoEntity().fromJson(e)).toList();
    sku?.forEach((element) {
      element.sizes?.forEach((element) {
        if (element.data?.shortageNum != element.data?.num) {
          fill = false;
        }
      });
    });
    return fill;
  }

  clearGoods(int orderSaleGoodsId, state) {
    var jsonList = skuMap[orderSaleGoodsId];
    var skuList = jsonList?.map((e) => SkuInfoEntity().fromJson(e)).toList();
    skuList?.forEach((element) {
      element.sizes?.forEach((element) {
        element.data?.num = 0;
      });
    });
    selectMap[orderSaleGoodsId] = 0;
    skuMap[orderSaleGoodsId] = skuList?.map((e) => e.toJson()).toList() ?? [];
    state.fillClear(orderSaleGoodsId);
    update([idGoodsList, idHeader, idStatement, idEmpty]);
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
