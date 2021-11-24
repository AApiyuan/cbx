import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/dict_type.dart';
import 'package:haidai_flutter_module/model/enum/order_stock_goods_type.dart';
import 'package:haidai_flutter_module/model/enum/select_type.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/store_goods_sku_req_entity.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/stock/model/enum/order_stock_status.dart';
import 'package:haidai_flutter_module/page/stock/model/req/batch_stock_rep.dart';
import 'package:haidai_flutter_module/page/stock/model/res/order_stock_new_do.dart';
import 'package:haidai_flutter_module/repository/base/store.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';
import 'package:haidai_flutter_module/repository/order/stock_api.dart';

class ConfirmController extends SuperController {
  var orderStockId;
  var goods;
  OrderStockNewDo? oldStock;
  var deptId; // 店铺id
  var orderStockGoodsType;

  ///订单 类型
  var orderStockType;

  TextEditingController orderRemarkController = new TextEditingController();
  TextEditingController changeReasonController = new TextEditingController();

  /// 标签类型
  String tagName = "入库标签";
  String tagType = DictTypeEnum.WARE_HOUSING;
  List<StoreDictData> tagList = [];
  int? selectTagId = -1;

  /// 统计显示文字
  String staticTitle = '出库';
  String confirmButtonText = "出库";

  /// 是否可加可减
  bool negative = false;

  /// 日期
  DateTime? selectDate;

  //获取标签
  Future getTag() async {
    if (tagList.length == 0) {
      Map dicts = await StoreApi.getDeptDictByParam(deptId!, [tagType]);
      if (dicts[tagType] != null) {
        tagList = dicts[tagType]!.map<StoreDictData>((e) => new StoreDictData().fromJson(e)).toList();
      }
    }
  }

  choseTag(int id) {
    selectTagId = id;
    update(['tagView']);
  }

  //提交数据
  Future<int> confirm(List<OrderStockNewDoGoods> goods, Map<int, List> map) async {
    if (goods.length == 0) {
      toastMsg("数量不能为空");
      return -1;
    }

    //构建主数据
    BatchStockRep batchStockRep = new BatchStockRep();
    batchStockRep.deptId = deptId;
    batchStockRep.stockChangeType = orderStockType;
    batchStockRep.orderGoodsType = orderStockGoodsType;
    batchStockRep.status = OrderStockStatusEnum.FINISH;
    //构建sku
    if (map.isEmpty) {
      return -1;
    }
    if (orderStockId != -1) {
      batchStockRep.id = orderStockId;
    }

    List<BatchStockRepGoods> goodsData = [];

    BatchStockRepGoods batchStockRepGoods;
    BatchStockRepGoodsSkus batchStockRepGoodsSkus;
    goods.forEach((element) {
      batchStockRepGoods = new BatchStockRepGoods();
      batchStockRepGoods.goodsId = element.goodsId;
      batchStockRepGoods.remark = element.remark;
      List<BatchStockRepGoodsSkus>? skus = [];
      for (int i = 0; i < map[element.goodsId]!.length; i++) {
        for (int j = 0; j < map[element.goodsId]![i]['sizes'].length; j++) {
          if (map[element.goodsId]![i]['sizes'][j]['data']['goodsNum'] != null &&
              map[element.goodsId]![i]['sizes'][j]['data']['goodsNum'] != 0) {
            batchStockRepGoodsSkus = new BatchStockRepGoodsSkus();
            batchStockRepGoodsSkus.num = map[element.goodsId]![i]['sizes'][j]['data']['goodsNum'];
            batchStockRepGoodsSkus.skuId = map[element.goodsId]![i]['sizes'][j]['data']['skuId'];
            skus.add(batchStockRepGoodsSkus);
          }
        }
        batchStockRepGoods.skus = skus;
      }
      goodsData.add(batchStockRepGoods);
    });

    batchStockRep.goods = goodsData;

    //构建附件数据
    BatchStockRepExtra batchStockRepExtra = new BatchStockRepExtra();
    if (negative) {
      //调整
      if (changeReasonController.text == "") {
        toastMsg("调整原因不能为空");
        return -1;
      }
      batchStockRepExtra.changeReason = changeReasonController.text;
    } else {
      //备注
      batchStockRepExtra.remark = orderRemarkController.text;
    }
    if (selectTagId != -1) {
      batchStockRepExtra.orderLabel = selectTagId;
    }
    if (selectDate == null) {
      batchStockRepExtra.customizeTime = DateUtil.getNowDateStr();
    } else {
      batchStockRepExtra.customizeTime = DateUtil.formatDate(selectDate);
    }
    batchStockRep.extra = batchStockRepExtra;

    return await StockApi.updateStock(batchStockRep, showLoading: true);
  }

  Future init() async {
    orderStockId = ArgUtils.getArgument2num(Constant.ORDER_STOCK_ID, def: -1)?.toInt();

    if (orderStockId == -1) {
      //新建
      orderStockGoodsType = ArgUtils.getArgument(Constant.ORDER_STOCK_GOODS_TYPE) ?? OrderStockGoodsTypeEnum.NORMAL;
      orderStockType = ArgUtils.getArgument(Constant.ORDER_STOCK_TYPE) ?? OrderStockTypeEnum.ADJUST;
    } else {
      oldStock = await StockApi.orderStockDetail(orderStockId, getAllSku: true, showLoading: true);
      orderStockGoodsType = oldStock!.orderGoodsType;
      orderStockType = oldStock!.orderType;

      //初始化其他
      orderRemarkController.text = oldStock!.remark ?? "";
      changeReasonController.text = oldStock!.changeReason ?? "";
      selectDate = DateUtil.getDateTime(oldStock!.customizeTime!);
      selectTagId = oldStock!.orderLabel;
    }
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID, def: -1)?.toInt();

    var goodsId = ArgUtils.getArgument2num(Constant.GOODS_ID, def: -1)?.toInt();
    if (goodsId != -1) {
      var page = new BasePage();
      Map<String, dynamic> param = new Map();
      page.pageNo = 1;
      page.pageSize = 10;
      param['deptId'] = deptId;
      param['goodsIds'] = [goodsId];
      param['selectType'] = SelectType.BASIC_STATIC;
      page.param = param;
      List<Goods> res = await GoodsApi.page(page);
      var params = StoreGoodsSkuReqEntity();
      params.goodsId = goodsId;
      params.deptId = deptId;
      params.returnStock = true;
      var value = await GoodsApi.getSkuList(params, showLoading: true);
      goods = GoodsSkuEntity(res[0], value, SaleDetailDoSaleGoodsList());
    }

    if (orderStockType == OrderStockTypeEnum.DIRECT_IN) {
      staticTitle = '入库';
      confirmButtonText = '入库';
      negative = false;
      tagType = DictTypeEnum.WARE_HOUSING;
      tagName = "入库标签";
    }
    if (orderStockType == OrderStockTypeEnum.DIRECT_OUT) {
      staticTitle = '出库';
      confirmButtonText = '出库';
      negative = false;
      tagType = DictTypeEnum.OUT_OF_STOCK_TAG;
      tagName = "出库标签";
    }
    if (orderStockType == OrderStockTypeEnum.ADJUST) {
      negative = true;
      confirmButtonText = '调整';
    }
    if (orderStockType == OrderStockTypeEnum.EXCHANGE_ADJUST) {
      negative = true;
      confirmButtonText = '改码调整';
    }
    if (orderStockType == OrderStockTypeEnum.SUBSTANDARD_RECORD) {
      staticTitle = '记录';
      negative = false;
      confirmButtonText = '记录次品';
      tagType = DictTypeEnum.SUBSTANDARD_GOODS;
      tagName = "次品标签";
    }
    if (orderStockType == OrderStockTypeEnum.SUBSTANDARD_RECOVER) {
      staticTitle = '复原';
      confirmButtonText = '次品复原';
      negative = false;
      tagType = DictTypeEnum.SUBSTANDARD_GOODS;
      tagName = "次品标签";
    }
    if (orderStockType == OrderStockTypeEnum.SUBSTANDARD_ADJUST) {
      negative = true;
      confirmButtonText = '次品调整';
    }
    if (orderStockType == OrderStockTypeEnum.SUBSTANDARD_OUT) {
      staticTitle = '出库';
      confirmButtonText = '次品出库';
      negative = false;
      tagType = DictTypeEnum.SUBSTANDARD_OUT_OF_STOCK_TAG;
      tagName = "次品出库标签";
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
