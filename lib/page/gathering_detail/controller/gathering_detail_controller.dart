import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/remark_order_type.dart';
import 'package:haidai_flutter_module/model/remark.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/gathering_detail/model/remit_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/gathering_detail/model/req/remit_method_update_req_entity.dart';
import 'package:haidai_flutter_module/page/gathering_detail/model/req/update_remit_base_req_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';
import 'package:haidai_flutter_module/repository/order/remark_api.dart';
import 'package:haidai_flutter_module/repository/order/remit_api.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';

class GatheringDetailController extends SuperController {
  /// id
  static const idTitle = "title";
  static const idVerification = "verification";
  static const idRemitMethod = "remitMethod";
  static const idMerchandiserName = "merchandiserName";
  static const idOrderRemark = "orderRemark";
  static const idPrint = "print";

  /// 参数
  var orderId = ArgUtils.getArgument2num(Constant.ORDER_ID)!.toInt();

  /// 属性
  StoreCustomerListItemDoEntity? customer;
  RemitDetailDoEntity? remitDetail;

  /// 方法
  init() async {
    await updateRemitDetail();
    customer = await CustomerApi.getCustomer(remitDetail?.customerId, showLoading: true);
    update([idTitle, idPrint]);
  }

  Future updateRemitDetail() async {
    remitDetail = await RemitApi.getRemitDetail(orderId);
    return remitDetail;
  }

  RemitDetailDoRemarkList? getRemarkItem(index) {
    return remitDetail?.remarkList?[index];
  }

  cancelOrderBalance(int index) {
    var ids = <int>[];
    if (index == -1) {
      remitDetail!.storeCustomerBalanceChangeLogList!.forEach((element) {
        if (element.canceled == CanceledEnum.ENABLE) {
          ids.add(element.id!);
        }
      });
    } else {
      ids.add(remitDetail!.storeCustomerBalanceChangeLogList![index].id!);
    }
    if (ids.isEmpty) {
      toastMsg("没有可撤销的记录");
      return;
    }
    SaleApi.cancelOrderBalance(ids, showLoading: true)
        .then((value) => updatePage(value, updateList: [idVerification]));
  }

  cancelOrderRemit() {
    RemitApi.cancelRemit(remitDetail!.id!)
        .then((value) => updatePage(value, updateList: [idRemitMethod]));
  }

  updateRemitMethod(RemitDetailDoRemitRecordMethodList recordMethod,
      StoreRemitMethodDoEntity remitMethod) {
    var param = RemitMethodUpdateReqEntity();
    param.id = recordMethod.id;
    param.remitMethodId = remitMethod.id;
    RemitApi.updateRemitMethod(param)
        .then((value) => updatePage(value, updateList: [idRemitMethod]));
  }

  updateOrderBase(int merchandiserId) {
    var param = UpdateRemitBaseReqEntity();
    param.merchandiserId = merchandiserId;
    param.orderRemitId = remitDetail?.id;
    RemitApi.updateRemitBase(param)
        .then((value) => updatePage(value, updateList: [idMerchandiserName]));
  }

  updatePage(bool success,
      {List<String>? updateList, String? errorMsg = "请重试"}) {
    if (success) {
      updateRemitDetail().then((value) {
        if (updateList != null || updateList!.isNotEmpty) update(updateList);
      });
    } else if (errorMsg != null) {
      toastMsg(errorMsg);
    }
  }

  addRemark(String value) {
    Remark remarkParam = Remark();
    remarkParam.orderType = RemarkOrderTypeEnum.ORDER_REMIT;
    remarkParam.remark = value;
    remarkParam.createdBy = customer?.id;
    remarkParam.createdByName = customer?.customerName;
    remarkParam.orderId = remitDetail?.id;
    RemarkApi.saveOrderRemark(remarkParam)
        .then((value) => updatePage(value, updateList: [idOrderRemark]));
  }

  deleteRemark(RemitDetailDoRemarkList remarkItem) {
    List<int> remarkIds = [remarkItem.id as int];
    RemarkApi.batchDeleteOrderRemark(remarkIds).then(
      (value) {
        if (value) {
          remitDetail?.remarkList?.remove(remarkItem);
          update([idOrderRemark]);
        } else {
          toastMsg("请重试");
        }
      },
    );
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
