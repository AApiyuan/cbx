import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/enum/config_group_type.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/store/req/customer_dept_config_req.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_config_do.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/req/create_remit_req_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';
import 'package:haidai_flutter_module/repository/base/store.dart';
import 'package:haidai_flutter_module/repository/base/store_remit_method_api.dart';
import 'package:haidai_flutter_module/repository/order/remit_api.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model/order_sale_item_entity.dart';

class VerificationLogic extends GetxController {
  // 头像名字
  String avatarName = '';

  // 昵称
  String customerName = '';

  // 级别
  String levelTag = '';

  // 颜色
  int levelTagColor = ColorConfig.color_ffffff;

  // 总欠款
  String oweAmount = '';

  // 账户余额
  String balance = '';

  // 历史合计单据结欠
  String orderOweAmount = '';

  // 所有收退款方式
  List<StoreRemitMethodDoEntity> refundMethodList = [];

  // 用来显示的收退款方式
  List<StoreRemitMethodDoEntity> showRefundMethodList = [];

  var refundMethodHang = 0.obs;

  // 当前选中收退款标记
  int groupValue = 1;

  // 切换控制器
  late TabController tabController;
  late TextEditingController textEditingController;

  // 金额 输入框的值
  String textFieldValue = "";

  // 销售单list
  List<OrderSaleItemEntity> orderSaleList = [];

  // 用来显示的销售单list
  List<OrderSaleItemEntity> showOrderSaleList = [];

  // 核销模式
  String verificationMode = "";

  // 实收金额
  int paidInAmount = 0;

  // 核销金额
  int verification = 0;

  // 剩余可核销金额
  double remainingWrittenOffAmount = 0.0;

  // 备注
  var remark = "".obs;

  // 日期选择
  DateTime? selectDate;

  // 参数
  int _customerId = ArgUtils.getArgument2num('customerId')!.toInt();
  int _deptId = int.parse(ArgUtils.getArgument('depId')!);

  // int orderSaleId = 98701;
  int orderSaleId = ArgUtils.getArgument2num('orderSaleId',def: 0)!.toInt();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    // 用户信息部分
    getCustomerData(_customerId).then((value) {
      // print(value);
      // 原有属性
      this.customerName = value.customerName!;
      this.levelTag = value.levelTag!;
      this.oweAmount = "总欠款¥${(value.oweAmount! / 100.00).toString()}";
      this.balance = (value.balance! / 100.00).toString();

      // 计算属性
      this.avatarName = getCutOutCustomerName();
      this.levelTagColor = getLevelTagColor();
    }).then((value) {
      getCustomerStatisticData(_customerId).then((value) {
        this.orderOweAmount = (value.orderOweAmount! / 100.00).toString();

        update(['first']);
        update(['second']);
      });
    }).then((valueX) {
      // 收退款部分
      getRemitMethodByDeptData(_deptId).then((value) {
        this.refundMethodList = value;

        update(['third']);
      });
    }).then((valueY) {
      // 核销部分
      getStoreConfiguration(_deptId).then((values) {
        for (var v in values) {
          if (this.orderSaleId > 0) {
            // 订单收款
            if (v.type == 'CONFIG_NUCLEAR_1') {
              this.verificationMode = v.configDate!;
            }
          } else {
            // 直接收款
            if (v.type == 'CONFIG_NUCLEAR_3') {
              this.verificationMode = v.configDate!;
            }
          }
        }
        update(['fifth']);

        getSelectByPageData(_customerId, _deptId).then((value) {
          this.orderSaleList = value;

          this.dataProcessing();
        });
      });
    });
  }

  // 数据处理
  dataProcessing() {
    if (this.verificationMode == 'CONFIG_NUCLEAR_3_3') {
      this.showOrderSaleList = [];
      for (var o in this.orderSaleList) {
        this.showOrderSaleList.add(o);
      }
    } else if (this.verificationMode == 'CONFIG_NUCLEAR_3_4') {
      this.showOrderSaleList = [];
      for (var o in this.orderSaleList.reversed) {
        this.showOrderSaleList.add(o);
      }
    } else if (this.verificationMode == 'CONFIG_NUCLEAR_3_5') {
      this.showOrderSaleList = [];
    }

    if (this.verificationMode == 'CONFIG_NUCLEAR_1_0') {
      this.showOrderSaleList = [];

      for (var o in this.orderSaleList) {
        if (o.id == this.orderSaleId) {
          this.showOrderSaleList.add(o);
        }
      }

      for (var o in this.orderSaleList) {
        if (o.id != this.orderSaleId) {
          this.showOrderSaleList.add(o);
        }
      }
    } else if (this.verificationMode == 'CONFIG_NUCLEAR_1_1') {
      this.showOrderSaleList = [];
      for (var o in this.orderSaleList) {
        if (o.id == this.orderSaleId) {
          this.showOrderSaleList.add(o);
        }
      }

      for (var o in this.orderSaleList) {
        if (o.id != this.orderSaleId) {
          this.showOrderSaleList.add(o);
        }
      }
    } else if (this.verificationMode == 'CONFIG_NUCLEAR_1_2') {
      this.showOrderSaleList = [];
      for (var o in this.orderSaleList) {
        if (o.id == this.orderSaleId) {
          this.showOrderSaleList.add(o);
        }
      }

    } else if (this.verificationMode == 'CONFIG_NUCLEAR_1_3') {
      this.showOrderSaleList = [];
      for (var o in this.orderSaleList) {
        this.showOrderSaleList.add(o);
      }
    } else if (this.verificationMode == 'CONFIG_NUCLEAR_1_4') {
      this.showOrderSaleList = [];
      for (var o in this.orderSaleList.reversed) {
        this.showOrderSaleList.add(o);
      }
    } else if (this.verificationMode == 'CONFIG_NUCLEAR_1_5') {
      this.showOrderSaleList = [];
    }

    update(['sixth']);

    this.writeOffListHandle();
  }

  // 核销列表
  writeOffListHandle() {
    if (this.verificationMode == 'CONFIG_NUCLEAR_3_5') {
      /*
      for (var i = 0; i < this.showOrderSaleList.length; i++) {
        OrderSaleItemEntity order = this.showOrderSaleList[i];
        order.writeOffAmount = 0.0;
      }
      */
      //

    } else if (this.verificationMode == 'CONFIG_NUCLEAR_1_2') {
    } else if (this.verificationMode == 'CONFIG_NUCLEAR_1_5') {
    } else {
      // 现有的钱
      double allMoney = this.afterBalance() * 100;

      print('所有钱');
      print(allMoney);
      print('所有钱');

      for (var i = 0; i < this.showOrderSaleList.length; i++) {
        OrderSaleItemEntity order = this.showOrderSaleList[i];

        if (order.balanceAmount != null) {
          if (allMoney >= order.balanceAmount!) {
            order.writeOffAmount = order.balanceAmount!;
            allMoney = allMoney - order.balanceAmount!;

            // print('第一步');
          } else if (allMoney == 0.0) {
            order.writeOffAmount = 0.0;
          } else {
            order.writeOffAmount = allMoney;
            allMoney = 0.0;
          }
        }
      }
    }

    update(['sixth']);
  }

  // 收款后账户余额
  double afterBalance() {
    double total = 0.0;

    if (this.balance.length > 0) {
      total = total + double.parse(this.balance);
    }

    if (this.paidUpAmountDisplayed().length > 0) {
      total = total + double.parse(this.paidUpAmountDisplayed());
    }

    // update(['fifth']);

    return total;
  }

  // 实收金额计算显示
  String paidUpAmountDisplayed() {
    double total = 0;

    for (var m in this.refundMethodList) {
      if (m.xPaymentAmount != null) {
        if (m.xPaymentAmount!.length > 0) {
          total = total + double.parse(m.xPaymentAmount!);
        }
      }
    }

    return (total).toString();
  }

  // 实退金额计算显示
  String refundAmountDisplayed() {
    // print('有吗1');

    double total = 0;

    for (var m in this.refundMethodList) {
      if (m.xRefundAmount != null) {
        if (m.xRefundAmount!.length > 0) {
          total = total + double.parse(m.xRefundAmount!);

          // print('有吗2');
          // print(total);
        }
      }
    }

    return (total).toString();
  }

  // 获取核销模式标题
  String getVerificationModeTitle() {
    String configDate = this.verificationMode;
    String title = "";
    if (configDate == 'CONFIG_NUCLEAR_3_3') {
      title = '从最早时间订单开始核销（自动）';
    } else if (configDate == 'CONFIG_NUCLEAR_3_4') {
      title = '从最近时间订单开始核销（自动）';
    } else if (configDate == 'CONFIG_NUCLEAR_3_5') {
      title = '手动选择';
    }

    if (configDate == 'CONFIG_NUCLEAR_1_0') {
      title = '优先本单,从最早时间订单开始核销（自动）';
    } else if (configDate == 'CONFIG_NUCLEAR_1_1') {
      title = '优先本单,从最近时间订单开始核销（自动）';
    } else if (configDate == 'CONFIG_NUCLEAR_1_2') {
      title = '优先本单,手动选择';
    } else if (configDate == 'CONFIG_NUCLEAR_1_3') {
      title = '从最早时间订单开始核销（自动）';
    } else if (configDate == 'CONFIG_NUCLEAR_1_4') {
      title = '从最近时间订单开始核销（自动）';
    } else if (configDate == 'CONFIG_NUCLEAR_1_5') {
      title = '手动选择';
    }

    return title;
  }

  // 修改核销模式标题
  changeVerificationModeTitle(verificationMode) {
    this.verificationMode = verificationMode;

    if (this.verificationMode == 'CONFIG_NUCLEAR_3_5') {
      this.showOrderSaleList = [];
    }

    update(['fifth']);
  }

  // 字符串截取
  String getCutOutCustomerName() {
    if (this.customerName.length == 1 || this.customerName.length == 2) {
      return this.customerName;
    } else {
      return this.customerName.substring(0, 2);
    }
  }

  // 更新底部数据
  updateBottom() {
    print('这里有执行吗');

    update(['bottom']);
  }

  // 获取等级颜色
  getLevelTagColor() {
    if (this.levelTag == "A") {
      return ColorConfig.color_FF9B20;
    } else if (this.levelTag == "B") {
      return ColorConfig.color_FFB117;
    } else if (this.levelTag == "C") {
      return ColorConfig.color_FFD517;
    }

    return ColorConfig.color_ffffff;
  }

  // 收退款-切换按钮-更新
  updateRefundMethodBtn(value) {
    this.groupValue = int.parse(value.toString());

    update(['third']);

    update(['fifth']);

    update(['header']);

    update(['sixth']);

    update(['bottom']);

    refundChangeTap();
  }

  // 点击tab时，赋值给textField
  refundChangeTap() {
    // 当前实体
    StoreRemitMethodDoEntity entity =
        this.refundMethodList[tabController.index];
    print('---当前索引---');
    print(tabController.index);
    print('---当前索引---');

    // 判断收退款方式
    if (groupValue == 1) {
      this.textFieldValue = entity.xPaymentAmount ?? "";
    } else {
      this.textFieldValue = entity.xRefundAmount ?? "";
    }

    print('看2看');
    print(this.textFieldValue);
    print('看2看');

    textEditingController.text = textFieldValue;

    update(['thirdSon']);

    // update(['third']);

    this.updateBottom();
  }

  // 编辑完成时，修改模型
  editCompletedAssignment(value) {
    print('看1看');
    print(this.textFieldValue);
    print('看1看');

    // 当前实体
    StoreRemitMethodDoEntity entity =
        this.refundMethodList[tabController.index];

    // 判断收退款方式
    if (groupValue == 1) {
      entity.xPaymentAmount = value;
    } else {
      entity.xRefundAmount = value;
    }

    update(['fifth']);

    this.updateBottom();
    this.writeOffListHandle();
  }


  // 收退款-部件显示
  Widget plusOrMinusWidget() {
    if (this.groupValue == 1) {
      return pText("+", ColorConfig.color_ffffff, 64.w);
    } else {
      return pText("-", ColorConfig.color_ff3715, 64.w);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // 核销金额
  double getVerification() {
    double total = 0;

    for (var o in this.showOrderSaleList) {
      if (o.writeOffAmount > 0) {
        total = total + o.writeOffAmount;
      }
    }

    return total;
  }

  // 查找本单
  OrderSaleItemEntity? getOrder(){
    for (OrderSaleItemEntity o in this.showOrderSaleList) {
        if (o.id == this.orderSaleId){
          return o;
        }
    }
    return null;
  }

  // 本单剩余应收
  double getOrderSurplusReceivable(){
    OrderSaleItemEntity? o = getOrder();

    if (o != null){
      return o.balanceAmount??0 - o.writeOffAmount;
    }

    return 0.0;
  }

  // 核销本单
  double writeOffOrderAmount(){
    OrderSaleItemEntity? o = getOrder();

    if (o != null){
      return  this.getVerification() - o.writeOffAmount;
    }
    return 0.0;
  }

  // 核销他单
  double writeOffBillAmount(){
    OrderSaleItemEntity? o = getOrder();

    if (o != null){
      return   o.writeOffAmount;
    }
    return 0.0;
  }




  // 完成收款-提交
  paymentConfirm() {
    CreateRemitReqEntity req = CreateRemitReqEntity();
    req.deptId = _deptId;
    req.customerId = _customerId;
    req.type = "PAYMENT";
    req.orderSaleId = this.orderSaleId;

    req.customizeTime = DateUtil.formatDate(selectDate);
    req.remark = remark.value;

    req.remitAmount = double.parse(this.paidUpAmountDisplayed()).toInt() * 100;

    List<CreateRemitReqRemitRecordMethodDoList> remitRecordMethodDoList = [];
    for (var m in this.refundMethodList) {
      if (m.xPaymentAmount != null) {
        if (m.xPaymentAmount!.length > 0) {
          CreateRemitReqRemitRecordMethodDoList dd =
              CreateRemitReqRemitRecordMethodDoList();

          dd.remitMethodId = m.id;
          dd.amount = int.parse(m.xPaymentAmount!) * 100;

          remitRecordMethodDoList.add(dd);
        }
      }
    }
    req.remitRecordMethodDoList = remitRecordMethodDoList;

    // 核销部分
    List<CreateRemitReqReqList> reqList = [];
    for (var o in this.showOrderSaleList) {
      if (o.writeOffAmount > 0) {
        CreateRemitReqReqList item = new CreateRemitReqReqList();
        item.customerId = _customerId;
        item.orderSaleId = o.id!.toInt();
        item.amount = o.writeOffAmount.toInt();
        reqList.add(item);
      }
    }
    if (reqList.length > 0) {
      req.reqList = reqList;
    }

    RemitApi.createRemit(req, showLoading: true).then((v) {
      Get.offAndToNamed(ArgUtils.map2String(
          path: Routes.GATHERING_DETAIL, arguments: {Constant.ORDER_ID: v.id}));
    });
  }

  // 完成退款-提交
  refundConfirm() {
    CreateRemitReqEntity req = CreateRemitReqEntity();
    req.deptId = _deptId;
    req.customerId = _customerId;
    req.type = "REFUND";
    req.orderSaleId = 0;
    // print("${this.refundAmountDisplayed()}");

    req.customizeTime = DateUtil.formatDate(selectDate);
    req.remark = remark.value;

    req.remitAmount = double.parse(this.refundAmountDisplayed()).toInt() * 100;

    List<CreateRemitReqRemitRecordMethodDoList> remitRecordMethodDoList = [];
    for (var m in this.refundMethodList) {
      if (m.xRefundAmount != null) {
        if (m.xRefundAmount!.length > 0) {
          CreateRemitReqRemitRecordMethodDoList dd =
              CreateRemitReqRemitRecordMethodDoList();

          dd.remitMethodId = m.id;
          dd.amount = int.parse(m.xRefundAmount!) * 100;

          remitRecordMethodDoList.add(dd);
        }
      }
    }
    req.remitRecordMethodDoList = remitRecordMethodDoList;

    RemitApi.createRemit(req, showLoading: true).then((v) {
      Get.offAndToNamed(ArgUtils.map2String(
          path: Routes.GATHERING_DETAIL, arguments: {Constant.ORDER_ID: v.id}));
    });
  }

  // 选择销售单-确定操作
  selectSaleOrderConfirm() {
    this.showOrderSaleList = [];
    for (var o in this.orderSaleList) {
      if (o.isCheck == true) {
        o.writeOffAmount = o.tempWriteOffAmount;
        this.showOrderSaleList.add(o);
      }
    }

    // print("我想知道的22");
    // print(this.showOrderSaleList);
    // print("我想知道的33");

    update(["sixth"]);
  }

  // 销售单 TextField 的值修改
  changeSalesValue(String value) {
    update([value]);
  }

  // 获取客户信息
  Future<StoreCustomerListItemDoEntity> getCustomerData(int id) {
    return CustomerApi.getCustomer(id, showLoading: true);
  }

  // 获取店铺收款方式
  Future<List<StoreRemitMethodDoEntity>> getRemitMethodByDeptData(int deptId) {
    return StoreRemitMethodApi.getRemitMethodByDept(deptId);
  }

  // 获取客户主页的统计数据信息
  Future getCustomerStatisticData(int id) {
    return CustomerApi.getCustomerStatistic(id);
  }

  // 分页查询销售单信息
  Future<List<OrderSaleItemEntity>> getSelectByPageData(
      int customerId, int customerDeptId) {
    BasePage param = new BasePage();
    param.pageNo = 1;
    param.pageSize = 1000;
    param.param = {
      "canceled": "ENABLE",
      "balanceAmountStatus": "YES",
      "customerId": customerId,
      "customerDeptId": customerDeptId,
      "orderBy": {"by": "ASC", "field": "customizeTime"}
    };
    return SaleApi.selectByPage(param);
  }

  // 店铺配置获取
  Future<List<CustomerDeptConfigDo>> getStoreConfiguration(int id) {
    CustomerDeptConfigReq param = new CustomerDeptConfigReq();
    param.customerDeptId = id;
    param.groupTypeList = [CustomerDeptConfigGroupEnum.NUCLEAR];
    return StoreApi.getDeptConfig(param, online: true);
  }
}
