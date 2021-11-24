import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/customer_user_do.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/delivery_detail/models/delivery_detail_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/sale_detail/models/req/sale_update_req_entity.dart';
import 'package:haidai_flutter_module/page/sale_detail/models/store_customer_balance_change_log_detail_do.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class DeliveryDetailController extends SuperController {
  var deptId;

  DeliveryDetailEntity? saleOrder;

  CustomerUserDo? customerUserDo;

  //核销记录
  List<StoreCustomerBalanceChangeLogDetailDo> checks = [];
  var openCheck = true.obs;

  ///列表数据
  List<dynamic> saleList = [];
  Map<int, List> saleSkuMap = {};
  Map<int, int> saleCountMap = {};
  var saleAllOpenStatus = false.obs;

  var deliveryOrderId;

  init() async {
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    deliveryOrderId = ArgUtils.getArgument2num(Constant.DELIVERY_ORDER_ID)!.toInt();

    //重置数据
    saleList.clear();
    saleSkuMap.clear();
    saleCountMap.clear();
    saleAllOpenStatus = false.obs;


    saleOrder = await SaleApi.deliveryOrderDetail(deliveryOrderId, showLoading: true, showAllSku: false);
    saleOrder!.deliveryGoodsList!.forEach((element) {
      this.saleList.add(element);
        this.saleCountMap[element.id!] = element.goodsNum ?? 0;
        this.saleSkuMap[element.id!] = element.orderGoodsVoList?.map((e) => e.toJson()).toList() ?? [];
    });
    customerUserDo = await UserApi.getUser();

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
