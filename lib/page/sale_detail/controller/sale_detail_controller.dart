import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/customer_user_do.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/sale_detail/models/req/sale_update_req_entity.dart';
import 'package:haidai_flutter_module/page/sale_detail/models/store_customer_balance_change_log_detail_do.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class SaleDetailController extends SuperController {
  var deptId;
  var thirdTagName = "shu";
  var thirdTag = "shu";
  var thirdTagColor = ColorConfig.color_1678ff;

  var fourTag = "shu";
  var fourTagName = "shu";
  var fourTagColor = ColorConfig.color_1678ff;

  SaleDetailDoEntity? saleOrder;

  CustomerUserDo? customerUserDo;

  //核销记录
  List<StoreCustomerBalanceChangeLogDetailDo> checks = [];
  var openCheck = true.obs;

  ///列表数据
  List<dynamic> saleList = [];
  Map<int, List> saleSkuMap = {};
  Map<int, int> saleCountMap = {};
  var saleAllOpenStatus = false.obs;

  List<dynamic> returnList = [];
  Map<int, List> returnSkuMap = {};
  Map<int, int> returnCountMap = {};
  var returnAllOpenStatus = false.obs;

  List<dynamic> oweList = [];
  Map<int, List> oweSkuMap = {};
  Map<int, int> oweCountMap = {};
  var oweAllOpenStatus = false.obs;

  var orderSaleId;

  init() async {
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    orderSaleId = ArgUtils.getArgument2num(Constant.ORDER_SALE_ID)!.toInt();

    // orderSaleId = 103601;

    //重置数据
    saleList.clear();
    saleSkuMap.clear();
    saleCountMap.clear();
    saleAllOpenStatus = false.obs;
    returnList.clear();
    returnSkuMap.clear();
    returnCountMap.clear();
    returnAllOpenStatus = false.obs;
    oweList.clear();
    oweSkuMap.clear();
    oweCountMap.clear();
    oweAllOpenStatus = false.obs;

    saleOrder = await SaleApi.saleOrderDetail(orderSaleId, showLoading: true, showAllSku: false);
    if(saleOrder!.saleGoodsList!=null){
      saleOrder!.saleGoodsList!.forEach((element) {
        if (element.type == EnumCoverUtils.enumsToString(SaleTypeEnum.NORMAL_SALE)) {
          this.saleList.add(element);
          this.saleCountMap[element.goodsId!] = element.goodsNum ?? 0;
          this.saleSkuMap[element.goodsId!] = element.orderGoodsVoList?.map((e) => e.toJson()).toList() ?? [];
        } else if (element.type == EnumCoverUtils.enumsToString(SaleTypeEnum.RETURN_GOODS)) {
          this.returnList.add(element);
          this.returnCountMap[element.goodsId!] = (element.goodsNum ?? 0).abs();
          this.returnSkuMap[element.goodsId!] = element.orderGoodsVoList?.map((e) {
            e.sizes?.forEach((element) => element.data?.goodsNum = element.data?.goodsNum?.abs() ?? 0);
            return e.toJson();
          }).toList() ??
              [];
        } else {
          this.oweList.add(element);
          this.oweCountMap[element.id!] = (element.goodsNum ?? 0).abs();
          this.oweSkuMap[element.id!] = element.orderGoodsVoList?.map((e) {
            e.sizes?.forEach((element) => element.data?.goodsNum = element.data?.goodsNum?.abs() ?? 0);
            return e.toJson();
          }).toList() ??
              [];
        }
      });
    }
    customerUserDo = await UserApi.getUser();
    SaleApi.selectStoreCustomerBalanceChangeLogById(orderSaleId, canceled: CanceledEnum.ENABLE).then((v) {
      checks = v;
      update(['orderCheck']);
    });
  }

  Future updateOrderBase({int? wipeOffAmount, int? merchandiserId}) {
    var param = SaleUpdateReqEntity();
    param.wipeOffAmount = wipeOffAmount;
    param.merchandiserId = merchandiserId;
    param.orderSaleId = saleOrder?.id;
    return SaleApi.updateSaleBase(param)
        // .then((value) => updateDetail())
        .then((value) => toastMsg("修改成功"));
  }

  updateDetail() {
    update(["orderDetail"]);
  }

  bool hasSaleGoods() {
    return saleOrder?.saleGoodsList?.indexWhere((element) => element.type == EnumCoverUtils.enumsToString(SaleTypeEnum.NORMAL_SALE)) != -1;
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() async {
    print("diaoyong");

    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    print("1");
    // loadData(6);
    // TODO: implement onResumed
  }
}
