import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/db/query/hang_order_query.dart';
import 'package:haidai_flutter_module/common/db/sql_db.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/store/res/store_remit_method_do.dart';
import 'package:haidai_flutter_module/page/customer/model/rep/store_customer_create_req_entity.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/offline_gathering_order_model.dart';
import 'package:haidai_flutter_module/page/sale/model/remit_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/req/create_remit_req_entity.dart';
import 'package:haidai_flutter_module/page/sale/widget/offline_gathering_widget.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';
import 'package:haidai_flutter_module/repository/base/store.dart';
import 'package:haidai_flutter_module/repository/order/remit_api.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OfflineGatheringController extends SuperController {
  static const int TYPE_OFFLINE_GATHERING = 4;
  static const SUBMIT_ORDER = "submitOrder";

  /// 参数
  var deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();
  var orderId = ArgUtils.getArgument2num(Constant.ORDER_ID)?.toInt();
  var _submitOrder = ArgUtils.getArgument2bool(SUBMIT_ORDER);

  /// 属性
  StoreCustomerListItemDoEntity? customer;
  List<StoreRemitMethodDo> remitMethodList = [];
  Map<int, double> remitAmountMap = {};
  var accountSize = 0.obs;
  var amountCount = 0.0.obs;
  var customizeTime = DateTime.now().obs;
  var remark = "".obs;

  /// id
  static const idCustomer = "customer";

  /// 方法
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (orderId == null) {
      StoreApi.getRemitMethod(deptId, false, online: false).then((value) {
        remitMethodList.clear();
        remitAmountMap.clear();
        remitMethodList.addAll(value);
        remitMethodList.forEach((element) => remitAmountMap[element.id!] = 0);
        accountSize.value = remitMethodList.length;
      });
    } else {
      StoreApi.getRemitMethod(deptId, false, online: false).then((value) {
        remitMethodList.clear();
        remitAmountMap.clear();
        remitMethodList.addAll(value);
        HangOrderQuery.getHangOrder(orderId!).then((value) {
          updateCustomer(value.customer);
          customizeTime.value =
              value.offlineGatheringOrderModel?.customTime ?? DateTime.now();
          remark.value = value.offlineGatheringOrderModel?.remark ?? "";
          remitMethodList.forEach((element) => remitAmountMap[element.id!] =
              value.remitAmountMap?[element.id!] ?? 0);
          accountSize.value = remitMethodList.length;
          updateAmountCount();
          if (_submitOrder ?? false) {
            showOfflineGatheringOrderDialog();
          }
        });
      });
    }
  }

  showOfflineGatheringOrderDialog() {
    showCupertinoModalBottomSheet(
      context: Get.context!,
      animationCurve: Curves.easeIn,
      builder: (context) {
        return BottomSheetWidget(
          title: "离线收款",
          showCertain: false,
          height: 1400.w,
          child: OfflineGatheringWidget(),
        );
        // return OfflineGatheringWidget();
      },
    );
  }

  updateCustomer(StoreCustomerListItemDoEntity? customer) {
    if (customer == null) return;
    this.customer = customer;
    update([idCustomer]);
  }

  getRetailStoreCustomer() {
    CustomerApi.getRetailStoreCustomer(deptId, online: false)
        .then((value) => updateCustomer(value));
  }

  updateAmountCount() {
    var amount = 0.0;
    remitAmountMap.forEach((key, value) => amount += value);
    amountCount.value = NumUtil.getNumByValueDouble(amount, 2)!.toDouble();
  }

  StoreRemitMethodDo getRemitMethod(int id) {
    return remitMethodList.firstWhere((element) => element.id == id);
  }

  Future hangOrder() {
    var amountMap = <int, double>{};
    var methodMap = <int, StoreRemitMethodDo>{};
    remitAmountMap.forEach((key, value) {
      if (value > 0) {
        amountMap[key] = value;
        methodMap[key] = getRemitMethod(key);
      }
    });
    if (amountMap.isEmpty) return Future.error(toastMsg("请输入收款金额"));
    var req = OfflineGatheringOrderModel();
    req.remark = remark.value;
    req.customTime = customizeTime.value;
    if (orderId == null) {
      return HangOrderQuery.insertOfflineGathering(
          amountMap, methodMap, customer, deptId, req);
    } else {
      return HangOrderQuery.delete(id: orderId!).then(
        (value) => HangOrderQuery.insertOfflineGathering(
            amountMap, methodMap, customer, deptId, req),
      );
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
    var customerId = await CustomerApi.createCustomer(req, online: true, customerId: customer.id);
    await CustomerQuery.updateCustomerId(customerId, customer.deptId!, customer.id!);
    return customerId;
  }

  Future<RemitDoEntity> createOrder() async {
    if (customer == null) return Future.error(toastMsg("请录入客户"));
    if ((customer!.offline ?? 0) == 1) {
      var customerId = await createCustomer(customer!);
      customer!.id = customerId;
    }
    var param = CreateRemitReqEntity();
    param.remark = remark.value;
    param.customizeTime =
        TimeUtils.getTime(customizeTime.value, format: "yyyy-MM-dd HH:mm:ss");
    param.type = "PAYMENT";
    param.customerId = customer?.id;
    param.deptId = deptId;
    param.orderSaleId = 0;
    var amount = 0.0;
    var methodList = <CreateRemitReqRemitRecordMethodDoList>[];
    remitAmountMap.forEach((key, value) {
      if (value > 0) {
        amount += value;
        var method = CreateRemitReqRemitRecordMethodDoList();
        method.amount = (value * 100).toInt();
        method.remitMethodId = key;
        methodList.add(method);
      }
    });
    param.remitAmount = (amount * 100).toInt();
    param.remitRecordMethodDoList = methodList;
    return await RemitApi.createRemit(param).then((value) {
      if (orderId != null)
        return HangOrderQuery.delete(id: orderId).then((_) => value);
      return value;
    }, onError: (err) {
      if (err.error.error is SocketException) {
        Future.delayed(Duration(milliseconds: 300))
            .then((value) => toastMsg("当前网络连接不可用，请先挂单"));
      }
    });
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
