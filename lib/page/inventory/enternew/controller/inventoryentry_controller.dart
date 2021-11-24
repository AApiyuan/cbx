import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/enum/order_stock_goods_type.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/stock/create/controller/confim_controller.dart';
import 'package:haidai_flutter_module/page/stock/model/res/order_stock_new_do.dart';
import 'package:haidai_flutter_module/repository/order/inventory_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

import 'entry_confim_controller.dart';

class InventoryEntryController extends SuperController {

  // ConfirmController confirmController = ConfirmController();
  EntryConfirmController confirmController = Get.find<EntryConfirmController>();
  ///参数===================
  ///正品 还是次品
  var orderStockGoodsType = OrderStockGoodsTypeEnum.NORMAL;

  ///订单 类型
  ///INVENTORY_SUBSTANDARD_ADJUST
  var orderStockType = OrderStockTypeEnum.INVENTORY_ADJUST;

  var depId = ArgUtils.getArgument2num("deptId")!.toInt();

  var orderId = ArgUtils.getArgument2num("orderId")!.toInt();

  var recordId = ArgUtils.getArgument2num("recordId",def: -1)!.toInt();
  bool isSubstandard = ArgUtils.getArgument2bool("isSubstandard",def: false)!;
  /// 统计显示文字
  String staticTitle = '盘点';
  String confirmButtonText = "提交盘点数";

  /// 是否可加可减
  bool negative = false;

  ///UI控制===================

  ///添加的每一个数据的量，
  Map<int, int> selectMap = new Map();

  ///搜索数据
  Map<String, dynamic> searchParam = new Map();

  ///列表数据
  List<dynamic> data = [];

  ///记录所有sku 键值是goodsId
  Map<int, List> skuMap = new Map();

  ///总件数
  int numTotal = 0;
  int minusNumTotal = 0;

  ///总款数
  int styleTotal = 0;
  int minusStyleTotal = 0;

  List<dynamic> getData() {
    return data;
  }

  Future<dynamic> searchGoods() async {
    Get.toNamed(ArgUtils.map2String(path: Routes.GOODS_LIST, arguments: searchParam));
  }

  //从货品页面添加货品并展开
  addGoods(GoodsSkuEntity value) {
    if (skuMap[value.goods.id] != null) {
      //已经添加过，滑动到指定 位置
      eventBus.fire(new AddGoodsEvent(value.goods.id as int, fixGoodsId: value.goods.id as int));
    }  else{
      //添加 货品
      OrderStockNewDoGoods stockNewDoGoods = new OrderStockNewDoGoods();
      stockNewDoGoods.storeGoodsBaseDo = value.goods;
      stockNewDoGoods.addNum = 0;
      stockNewDoGoods.subtractNum = 0;
      stockNewDoGoods.goodsId = value.goods.id;
      data.add(stockNewDoGoods);
      //添加sku
      skuMap[value.goods.id as int] = value.storeGoodsVos.map((v) => v.toJson()).toList();
      selectMap[value.goods.id as int] = 0;
      eventBus.fire(new AddGoodsEvent(value.goods.id as int));

      //更新搜索
      updateSearchMap();
    }
    update(['noGoods']);
  }

  updateSearchMap() {
    searchParam[Constant.SELECT_MAP] = GoodsListController.map2String(selectMap);
  }

  deleteGoods(int goodsId) {
    selectMap.remove(goodsId);
    skuMap.remove(goodsId);
    updateSearchMap();
    //从新计算总数
    //更新总数
    numTotal = 0;
    styleTotal = 0;
    if (data.length > 0) {
      for (var item in data) {
        if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
          if (item.addNum != 0) {
            styleTotal += 1;
            numTotal += item.addNum as int;
          }
        }
      }
    }
    if (negative == true) {
      //证明是调整，要计算负数
      minusNumTotal = 0;
      minusStyleTotal = 0;
      for (var item in data) {
        if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
          if (item.subtractNum != 0) {
            minusStyleTotal += 1;
            minusNumTotal += item.subtractNum as int;
          }
        }
      }
    }
    update(['stockTotal', 'noGoods']);
  }

  //当数字变化  计算
  calculate(int goodsId, int index, int itemAdd, int itemMinus) {
    selectMap[goodsId] = itemAdd - itemMinus;
    //更新总数
    numTotal = 0;
    styleTotal = 0;
    if (data.length > 0) {
      for (var item in data) {
        if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
          if (item.goodsId == goodsId) {
            item.addNum = itemAdd;
          }
          if (item.addNum != 0) {
            styleTotal += 1;
            numTotal += item.addNum as int;
          }
        }
      }
    }
    if (negative == true) {
      //证明是调整，要计算负数
      minusNumTotal = 0;
      minusStyleTotal = 0;
      for (var item in data) {
        if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
          if (item.goodsId == goodsId) {
            item.subtractNum = itemMinus;
          }
          if (item.subtractNum != 0) {
            minusStyleTotal += 1;
            minusNumTotal += item.subtractNum.abs() as int;
          }
        }
      }
    }

    //更新货品ui,总数ui
    update(['goodsAddNum' + goodsId.toString(), 'stockTotal']);
    //更新搜索
    updateSearchMap();
  }

  /// 提交数据
  confirm() {
    List<OrderStockNewDoGoods> goods = [];


    for (var item in data) {
      if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
        if (item.addNum != 0 || item.subtractNum != 0) {
          goods.add(item);
        }
      }
    }

    if(recordId != -1){
      confirmController.updateOrder(orderId,depId,isSubstandard,goods,skuMap).then((value)
      {
        print(value);
      });
    }else{
      confirmController.createOrder(orderId,depId,isSubstandard,goods,skuMap).then((value)
      {
        print(value);
      });
    }


  }


  checkGoodsInit() {
    if (confirmController.goods != null) {
      //如果是 货品带入
      addGoods(confirmController.goods);
    }
  }

  ///盘点记录的货品
  Future getOrderGoods({int? recordId}) async {
    return await InventoryApi.getInventoryOrderDetail(recordId!,getAllSku: true).then((value) {
      //证明是 修改，那么要初始化数据
      List GoodsData = [];
      value.goods.forEach((goods){
        var goodModel = OrderStockNewDoGoods().fromJson(goods.toJson());
        goodModel.id = goods.id;
        goodModel.goodsId = goods.goodsId;
        goodModel.storeGoodsBaseDo = Goods().fromJson(goods.storeGoodsBaseDo.toJson());
        List<SkuInfoEntity> orderGoodsVoList = [];
        goods.orderGoodsVoList.forEach((sku) {
          var skuItem = SkuInfoEntity().fromJson(sku.toJson());
          orderGoodsVoList.add(skuItem);
        });

        var num = 0;
        goods.skus.forEach((sku) {
          if(sku.goodsNum != null){
            num += sku.goodsNum!;
          }
        });
        goodModel.orderGoodsVoList = orderGoodsVoList;
        goodModel.storeGoodsBaseDo!.stockNum = goods.stockNum;
        goodModel.storeGoodsBaseDo!.substandardNum = goods.substandardNum;
        goodModel.addNum = num;
        GoodsData.add(goodModel);

        var goodsSkuEntity = GoodsSkuEntity(goodModel.storeGoodsBaseDo!,goodModel.orderGoodsVoList!,SaleDetailDoSaleGoodsList());
        if (skuMap[goodsSkuEntity.goods.id] != null) {
          //已经添加过，滑动到指定 位置
          eventBus.fire(new AddGoodsEvent(goodsSkuEntity.goods.id as int, fixGoodsId: goodsSkuEntity.goods.id as int));
        } else {
          //添加 货品
          OrderStockNewDoGoods stockNewDoGoods = new OrderStockNewDoGoods();
          stockNewDoGoods.storeGoodsBaseDo = goodsSkuEntity.goods;
          stockNewDoGoods.addNum = num;
          stockNewDoGoods.subtractNum = 0;
          stockNewDoGoods.goodsId = goodsSkuEntity.goods.id;
          data.add(stockNewDoGoods);
          //添加sku
          skuMap[goodsSkuEntity.goods.id as int] = goodsSkuEntity.storeGoodsVos.map((v) => v.toJson()).toList();
          selectMap[goodsSkuEntity.goods.id as int] = num;
          eventBus.fire(new AddGoodsEvent(goodsSkuEntity.goods.id as int));
          //更新搜索
          updateSearchMap();
        }
        update(['noGoods']);

        numTotal = 0;
        styleTotal = 0;
        if (data.length > 0) {
          for (var item in data) {
            if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
              if (item.addNum != 0) {
                styleTotal += 1;
                numTotal += item.addNum as int;
              }
            }
          }
        }
        if (negative == true) {
          //证明是调整，要计算负数
          minusNumTotal = 0;
          minusStyleTotal = 0;
          for (var item in data) {
            if (item.runtimeType.toString() == "OrderStockNewDoGoods") {
              if (item.subtractNum != 0) {
                minusStyleTotal += 1;
                minusNumTotal += item.subtractNum.abs() as int;
              }
            }
          }
        }

        //更新货品ui,总数ui
        update(['stockTotal']);

      });
    });
  }

  init() async {
    confirmController.deptId = depId;
    confirmController.orderId = orderId;
    confirmController.recordId = recordId;
    await confirmController.init();

    if(recordId != -1){
      getOrderGoods(recordId: recordId);
    }


    ///订单 类型

    orderStockType = isSubstandard?OrderStockTypeEnum.INVENTORY_SUBSTANDARD_ADJUST:OrderStockTypeEnum.INVENTORY_ADJUST;
    orderStockGoodsType = isSubstandard?OrderStockGoodsTypeEnum.SUBSTANDARD:OrderStockGoodsTypeEnum.NORMAL;
    //初始化
    searchParam[Constant.DEPT_ID] = depId;
    searchParam[Constant.GOODS_TYPE] = isSubstandard?GoodsListController.TYPE_INVENTORY_SUBSTANDARD:GoodsListController.TYPE_INVENTORY;
    // searchParam[GoodsListController.PARAM_SELECT_ALL] = true;
    searchParam[Constant.SELECT_MAP] = GoodsListController.map2String(selectMap);



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
    print("onResumed调用 了");
  }
}
