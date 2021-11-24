import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/config_group_type.dart';
import 'package:haidai_flutter_module/model/enum/remit_type.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/store/req/customer_dept_config_req.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_config_do.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/req/create_remit_req_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';
import 'package:haidai_flutter_module/repository/base/store.dart';
import 'package:haidai_flutter_module/repository/base/store_remit_method_api.dart';
import 'package:haidai_flutter_module/repository/order/remit_api.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

class RemitController extends SuperController {
  var deptId;
  var customerId;
  StoreCustomerListItemDoEntity? customer;
  int amount = 0; //当前结欠
  var curSaleOrderId; //当前销售单id
  List<StoreRemitMethodDoEntity> remitMethods = [];
  List<SaleDoEntity> saleList = []; //选择的的单据,
  List<SaleDoEntity> allSaleList = []; //有 结欠的单据

  var isSaleOrderTo = ArgUtils.getArgument2bool(Constant.SALE_ORDER_TO, def: false);//是否从销售单详情过来

  Map<int, bool> selectIdMap = new Map();

  //收退款
  var isRefund = false.obs; //是否是退款
  int curRemitMethodIndex = 0; //当前收款方式index
  var curRemitMethodAmount = ''; //当前收款方式金额
  var selfFirst = true.obs;
  var curMode = 0.obs;

  var afterRemitBalance = 0.0.obs; //收款后 账户余额
  var checkAmount = 0.0.obs; //核销金额
  var checkSelfAmount = 0.0.obs; //核本单金额
  var checkOtherAmount = 0.0.obs; //核本单金额
  var leftCheckAmount = 0.0.obs; //剩余可核销金额
  var remitAmount = 0.0.obs; //收款金额
  var refundAmount = 0.0.obs; //退款金额

  var remark = "".obs; //备注
  DateTime? selectDate; //选择的日期

  FocusNode focusNode = FocusNode(); //收款的focus
  FocusScopeNode node = FocusScopeNode(); //列表的focus

  init() async {
    customerId = ArgUtils.getArgument2num(Constant.CUSTOMER_ID)?.toInt();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    curSaleOrderId = ArgUtils.getArgument2num(Constant.ORDER_SALE_ID, def: -1)?.toInt();
    if (curSaleOrderId == -1) {
      selfFirst.value = false;
    }
    amount = ArgUtils.getArgument2num(Constant.AMOUNT, def: -1)!.toInt();
    //店铺配置
    await getStoreConfiguration();
    initSaleList();
    update(["remit_confirm"]);
  }

  initRemitMethod() async {
    Map<int, String> oldSortMap = new Map();
    if (remitMethods.length != 0) {
      remitMethods.forEach((element) {
        oldSortMap[element.id as int] = element.amount;
      });
    }
    remitMethods = await StoreRemitMethodApi.getRemitMethodByDept(deptId);
    if (oldSortMap.isNotEmpty) {
      remitMethods.forEach((element) {
        element.amount = oldSortMap[element.id as int] as String;
      });
    }
    oldSortMap.clear();
    curRemitMethodAmount = remitMethods[0].amount;
    update(['curAmount', 'curAmountList']);
  }

  initCustomer() async {
    customer = await CustomerApi.getCustomer(customerId);
    update(['customer_balance']);
    //默认计算一下核销
    onPriceChange();
  }

  // 店铺配置获取
  getStoreConfiguration() async {
    CustomerDeptConfigReq param = new CustomerDeptConfigReq();
    param.customerDeptId = deptId;
    param.groupTypeList = [CustomerDeptConfigGroupEnum.NUCLEAR];
    List<CustomerDeptConfigDo> configs = await StoreApi.getDeptConfig(param, online: true);
    configs.forEach((element) {
      if (curSaleOrderId != -1) {
        if (element.configDate == 'CONFIG_NUCLEAR_1_0') {
          //优先本单，最早开始
          selfFirst.value = true;
          curMode.value = 0;
        }
        if (element.configDate == 'CONFIG_NUCLEAR_1_1') {
          //优先本单，最近开始
          selfFirst.value = true;
          curMode.value = 1;
        }
        if (element.configDate == 'CONFIG_NUCLEAR_1_2') {
          //优先本单，手动
          selfFirst.value = true;
          curMode.value = 2;
        }
        if (element.configDate == 'CONFIG_NUCLEAR_1_3') {
          //最早开始
          selfFirst.value = false;
          curMode.value = 0;
        }
        if (element.configDate == 'CONFIG_NUCLEAR_1_4') {
          //最近开始
          selfFirst.value = false;
          curMode.value = 1;
        }
        if (element.configDate == 'CONFIG_NUCLEAR_1_5') {
          //手动
          selfFirst.value = false;
          curMode.value = 2;
        }
      } else {
        if (element.configDate == 'CONFIG_NUCLEAR_3_3') {
          //最早开始
          selfFirst.value = false;
          curMode.value = 0;
        }
        if (element.configDate == 'CONFIG_NUCLEAR_3_4') {
          //最近开始
          selfFirst.value = false;
          curMode.value = 1;
        }
        if (element.configDate == 'CONFIG_NUCLEAR_3_5') {
          //手动
          selfFirst.value = false;
          curMode.value = 2;
        }
      }
    });
  }

  initSaleList() {
    BasePage param = new BasePage();
    param.pageNo = 1;
    param.pageSize = 1000;
    param.param = {
      "canceled": "ENABLE",
      "balanceAmountStatus": "YES",
      "customerDeptId": deptId,
      "customerId": customerId,
      "orderBy": {"by": "ASC", "field": "customizeTime"}
    };
    SaleApi.selectPage(param).then((v) {
      allSaleList = v;
      onModeChange();
    });
  }

  //当核销模式改变
  onModeChange() {
    saleList.clear();
    selectIdMap.clear();
    saleList = new List.from(allSaleList);
    if (curMode.value == 0) {
      //正序核销
      saleList.sort((left, right) => TimeUtils.compare(left.customizeTime!, right.customizeTime!));
    }
    if (curMode.value == 1) {
      //倒序核销
      saleList.sort((left, right) => TimeUtils.compare(right.customizeTime!, left.customizeTime!));
    }
    if (curMode.value == 2) {
      checkSelfAmount.value = 0.0;
      checkOtherAmount.value = 0.0;
      checkAmount.value = 0;
    }
    //判断是否优先本单
    SaleDoEntity? sale;
    int index = 0;
    for (int i = 0; i < saleList.length; i++) {
      saleList[i].check = ""; //重置核销金额
      if (saleList[i].id == curSaleOrderId) {
        sale = saleList[i];
        index = i;
      }
    }
    if (sale != null && selfFirst.value) {
      saleList.removeAt(index);
      saleList.insert(0, sale);
    }

    update(['saleCheckList']);
    onPriceChange();
  }

  //价格改变
  onPriceChange() {
    //收款
    if (!isRefund.value) {
      //汇总收款金额
      remitAmount.value = 0.0;
      remitMethods.forEach((element) {
        if (element.amount != '') {
          remitAmount.value = NumUtil.add(remitAmount.value, double.parse(element.amount));
        }
      });

      double amount = 0.0;
      List<String> updateTags = [];
      checkOtherAmount.value = 0;
      afterRemitBalance.value = NumUtil.add(remitAmount.value, customer!.balance!.toDouble() / 100);

      //计算收款后余额
      if (curMode.value != 2) {
        //非手动核销，则自动计算
        //计算核销金额
        if (afterRemitBalance.value < customer!.orderOweAmount!.toDouble() / 100) {
          checkAmount.value = afterRemitBalance.value;
        } else {
          checkAmount.value = customer!.orderOweAmount!.toDouble() / 100;
        }
        amount = checkAmount.value;
        for (int i = 0; i < saleList.length; i++) {
          saleList[i].check = ""; //清空
          //自动核销
          var checked;
          if (amount >= saleList[i].balanceAmount!.toDouble() / 100) {
            saleList[i].check = (saleList[i].balanceAmount!.toDouble() / 100).toString();
            checked = saleList[i].balanceAmount!.toDouble() / 100;
            amount = NumUtil.subtract(amount, checked);
          } else {
            checked = amount;
            saleList[i].check = checked.toString();
            amount = 0;
          }
          //判断是否是本单，设置核本单
          if (saleList[i].id == curSaleOrderId) {
            checkSelfAmount.value = checked;
          } else {
            checkOtherAmount.value = NumUtil.add(checkOtherAmount.value, double.parse(saleList[i].check));
          }

          updateTags.add("amount" + saleList[i].id.toString());
        }
      } else {
        //手动核销
        leftCheckAmount.value = NumUtil.add(remitAmount.value, customer!.balance!.toDouble() / 100);
        int handleIndex = -1;
        for (int i = 0; i < saleList.length; i++) {
          if (curMode.value == 2 && selectIdMap[saleList[i].id] != true) {
            //如果 是手动选择 ，且没有选中
            updateTags.add("amount" + saleList[i].id.toString());
            continue;
          }

          var check = double.parse(saleList[i].check == '' ? '0' : saleList[i].check);
          if (leftCheckAmount.value >= check) {
            leftCheckAmount.value = NumUtil.subtract(leftCheckAmount.value, check);
          } else {
            saleList[i].check = leftCheckAmount.value.toString();
            check = leftCheckAmount.value;
          }
          if (saleList[i].id == curSaleOrderId) {
            checkSelfAmount.value = check;
          } else {
            checkOtherAmount.value = NumUtil.add(checkOtherAmount.value, check);
          }
          //自动填充是
          // if (leftCheckAmount.value >= saleList[i].balanceAmount!.toDouble() / 100) {
          //   saleList[i].check = (saleList[i].balanceAmount!.toDouble() / 100).toString();
          //   if (saleList[i].id == curSaleOrderId) {
          //     checkSelfAmount.value = saleList[i].balanceAmount!.toDouble() / 100;
          //   } else {
          //     checkOtherAmount.value += saleList[i].balanceAmount!.toDouble() / 100;
          //   }
          //   leftCheckAmount.value -= double.parse(saleList[i].check == '' ? '0' : saleList[i].check);
          // } else {
          //   saleList[i].check = leftCheckAmount.value.toString();
          //   if (saleList[i].id == curSaleOrderId) {
          //     checkSelfAmount.value = leftCheckAmount.value;
          //   } else {
          //     checkOtherAmount.value += leftCheckAmount.value;
          //   }
          //   leftCheckAmount.value = 0;
          // }

          updateTags.add("amount" + saleList[i].id.toString());
        }
        checkAmount.value = NumUtil.add(checkOtherAmount.value, checkSelfAmount.value);
      }

      update(updateTags);
      //更新收款信息
      update(['remitConfirm']);
    } else {
      refundAmount.value = 0.0;
      remitMethods.forEach((element) {
        if (element.amount != '') {
          refundAmount.value = NumUtil.add(refundAmount.value, double.parse(element.amount));
        }
      });
      update(['remitConfirm']);
    }
    update(['curAmountList']);
  }

  //当列表编辑核销金额时候触发
  onEditOneOrderCheck(int id) {
    //手动核销
    List<String> updateTags = [];
    checkOtherAmount.value = 0;
    leftCheckAmount.value = NumUtil.add(remitAmount.value, customer!.balance!.toDouble() / 100);
    int handleIndex = -1;
    for (int i = 0; i < saleList.length; i++) {
      if (saleList[i].id == id) {
        //跳过当前
        handleIndex = i;
        continue;
      }
      if (selectIdMap[saleList[i].id] != true) {
        //如果 是手动选择 ，且没有选中
        updateTags.add("amount" + saleList[i].id.toString());
        continue;
      }

      var check = double.parse(saleList[i].check == '' ? '0' : saleList[i].check);
      if (saleList[i].id == curSaleOrderId) {
        checkSelfAmount.value = check;
      } else {
        checkOtherAmount.value = NumUtil.add(checkOtherAmount.value, check);
      }
      leftCheckAmount.value = NumUtil.subtract(leftCheckAmount.value, check);
    }

    if (handleIndex != -1) {
      var check = double.parse(saleList[handleIndex].check == '' ? '0' : saleList[handleIndex].check);

      if (check > (saleList[handleIndex].balanceAmount!.toDouble() / 100)) {
        saleList[handleIndex].check = (saleList[handleIndex].balanceAmount!.toDouble() / 100).toString();
      }
      if (check > leftCheckAmount.value) {
        saleList[handleIndex].check = leftCheckAmount.value.toString();
      }
      check = double.parse(saleList[handleIndex].check == '' ? '0' : saleList[handleIndex].check);
      if (saleList[handleIndex].id == curSaleOrderId) {
        checkSelfAmount.value = check;
      } else {
        checkOtherAmount.value = NumUtil.add(checkOtherAmount.value, check);
      }
      leftCheckAmount.value = NumUtil.subtract(leftCheckAmount.value, check);
      updateTags.add("amount" + saleList[handleIndex].id.toString());
    }
    checkAmount.value = NumUtil.add(checkOtherAmount.value, checkSelfAmount.value);
    update(updateTags);
    //更新收款信息
    update(['remitConfirm']);
  }

  //收退款提交
  confirm() {
    CreateRemitReqEntity req = new CreateRemitReqEntity();
    req.deptId = deptId;
    req.orderSaleId = curSaleOrderId != -1 ? curSaleOrderId : 0;
    req.customerId = customerId;
    req.customizeTime = DateUtil.formatDate(selectDate);
    req.remark = remark.value;
    if (isRefund.value) {
      req.type = RemitTypeEnum.REFUND;
      req.remitAmount = (refundAmount.value * 100).toInt();
    } else {
      req.type = RemitTypeEnum.PAYMENT;
      req.remitAmount = (remitAmount.value * 100).toInt();
      if (checkAmount.value != 0) {
        List<CreateRemitReqReqList> reqList = [];
        saleList.forEach((element) {
          if (element.check != "") {
            CreateRemitReqReqList item = new CreateRemitReqReqList();
            item.customerId = customerId;
            item.orderSaleId = element.id;
            item.amount = (double.parse(element.check) * 100).toInt();
            if (item.amount != 0) {
              reqList.add(item);
            }
          }
        });
        if (reqList.length > 0) {
          req.reqList = reqList;
        }
      }
    }
    if (req.remitAmount != 0) {
      List<CreateRemitReqRemitRecordMethodDoList> remitRecordMethodDoList = [];
      remitMethods.forEach((element) {
        if (element.amount != "") {
          CreateRemitReqRemitRecordMethodDoList item = new CreateRemitReqRemitRecordMethodDoList();
          item.remitMethodId = element.id;
          item.amount = (double.parse(element.amount) * 100).toInt();
          if (item.amount != 0) {
            remitRecordMethodDoList.add(item);
          }
        }
      });
      req.remitRecordMethodDoList = remitRecordMethodDoList;
    }

    RemitApi.createRemit(req, showLoading: true).then((v) {
      if (curSaleOrderId != -1) {
        // BackUtils.back(result: "update");
        Get.offAndToNamed(
            ArgUtils.map2String(path: Routes.SALE_DETAIL, arguments: {Constant.ORDER_SALE_ID: curSaleOrderId, Constant.DEPT_ID: deptId}));
      } else {
        Get.offAndToNamed(ArgUtils.map2String(path: Routes.GATHERING_DETAIL, arguments: {Constant.ORDER_ID: v.id}));
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    init();
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
