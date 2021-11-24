import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/bi/model/enum/bi_select_type_enum.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_remit_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_group_remit_method_id_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_dept_do.dart';
import 'package:haidai_flutter_module/page/bi/widget/ChartData.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_remit_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class BiRemitController extends SuperController {
  var deptId;
  var topDeptId;
  List<int> customerDeptIds = [];

  String customizeStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(15)); //默认开始时间
  List<Map> deptRemitChartData = [];
  String selectType = BiSelectTypeEnum.DAY;
  String viewSale = "receivedAmount"; //默认查看销量，切换为saleTaxAmount  销售金额
  int xRotation = 0;
  String yTitle = "件";
  bool receiveShowWan = false;
  bool refundShowWan = false;

  String statisticEndTime = TimeUtils.getEndOfDay(DateTime.now());
  String statisticStartTime = TimeUtils.getStartOfDay(DateTime.now());

  updateRemitChart() {
    BiRemitPageReq biRemitPageReq = new BiRemitPageReq();
    biRemitPageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biRemitPageReq.customerDeptIds = customerDeptIds;
    }
    biRemitPageReq.selectType = selectType;
    biRemitPageReq.canceled = CanceledEnum.ENABLE;
    biRemitPageReq.customizeEndTime = TimeUtils.getEndOfDay(DateTime.now()); //默认结束时间
    biRemitPageReq.customizeStartTime = customizeStartTime;
    if (deptId != null) {
      biRemitPageReq.filterMerchandiser = true;
    }

    BiRemitApi.selectRemitGroupTime(biRemitPageReq).then((value) {
      double max = 0;
      value.forEach((element) {
        if (element.receivedAmount! > max) {
          max = element.receivedAmount as double;
        }
      });
      //相当于大于 10万  设置显示万元
      receiveShowWan = max > 9999999 ? true : false;
      if (viewSale == "receivedAmount") {
        yTitle = receiveShowWan ? "万元" : "元";
      }
      double numMax = 0;
      value.forEach((element) {
        if (element.refundAmount! > numMax) {
          numMax = element.refundAmount as double;
        }
      });

      //相当于大于 10万  设置显示万件
      refundShowWan = numMax > 9999999 ? true : false;
      if (viewSale == "refundAmount") {
        yTitle = refundShowWan ? "万元" : "元";
      }
      value.forEach((element) {
        if (receiveShowWan) {
          element.receivedAmount = NumUtil.getNumByValueDouble((element.receivedAmount! / 1000000), 4) as double;
        } else {
          element.receivedAmount = element.receivedAmount! / 100;
        }

        if (refundShowWan) {
          element.refundAmount = NumUtil.getNumByValueDouble((element.refundAmount! / 1000000), 4) as double;
        } else {
          element.refundAmount = element.refundAmount! / 100;
        }
      });
      deptRemitChartData = value.map((v) => v.toJson()).toList();
      update(['remitChart']);
    });
  }

  //更新收款 统计
  BiRemitSumDo? biRemitSumDo;
  List<CircleChartData> remitChartData = [];
  String rateStr = "100%";
  String viewMethod = "remit"; //查看收款还是退款

  updateRemitTotal() {
    BasePage basePage = new BasePage();
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = statisticEndTime; //默认结束时间
    biSalePageReq.customizeStartTime = statisticStartTime;
    if (deptId != null) {
      biSalePageReq.filterMerchandiser = true;
    }
    basePage.param = biSalePageReq; //默认结束时间
    BiDeptApi.selectRemitByPageSum(basePage).then((value) {
      biRemitSumDo = value;
      double rate = 1;
      if (value.receivedAmount != 0 && value.refundAmount != 0) {
        rate = NumUtil.getNumByValueDouble(value.receivedAmount! / (value.receivedAmount! + value.refundAmount!), 4)
            as double;
        rateStr = (NumUtil.multiply(rate, 100)).toString() + "%";
      } else {
        rateStr = "100%";
      }

      remitChartData = [
        CircleChartData('Steve', rate * 100, Color(ColorConfig.color_1678ff)),
        CircleChartData('David', (1 - rate) * 100, Color(ColorConfig.color_ff1a43))
      ];

      update(['remitTotal']);
    });
  }

  List<CircleChartData> remitMethodChartData = [];
  String totalStr = "￥0";
  List<BiRemitGroupRemitMethodIdDo> methods = [];
  List<BiRemitGroupRemitMethodIdDo> methodsList = []; //复制一份用于列表展示

  //更新收款方式统计
  updateRemitMethodStatistic() {
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = statisticEndTime; //默认结束时间
    biSalePageReq.customizeStartTime = statisticStartTime;
    if (deptId != null) {
      biSalePageReq.filterMerchandiser = true;
    }
    BiRemitApi.selectRemitGroupRemitMethodId(biSalePageReq).then((value) {
      methods = value;
      methodsList = value;

      if (viewMethod == "remit") {
        changeToRemit();
      } else {
        changeToRefund();
      }
      update(['remitMethod', 'remitMethodList']);
    });
  }

  changeToRemit() {
    double total = 0;
    double otherTotal = 0; //超过5个显示其他
    remitMethodChartData.clear();
    if (methods.length > 0) {
      methods.sort((a, b) => b.receivedAmount.compareTo(a.receivedAmount)); //降序
      List newMethods = [];
      for (int i = 0; i < methods.length; i++) {
        if (methods[i].receivedAmount == 0) {
          break;
        }
        newMethods.add(methods[i]);
        total = NumUtil.add(total, methods[i].receivedAmount);
        if (i > 4) {
          otherTotal = NumUtil.add(otherTotal, methods[i].receivedAmount);
        }
      }
      for (int i = 0; i < newMethods.length; i++) {
        if (i <= 4) {
          remitMethodChartData.add(
            CircleChartData(newMethods[i].remitMethodName!, newMethods[i].receivedAmount! / total * 100,
                CircleChartData.colors[i], "￥${newMethods[i].receivedAmount! / 100}"),
          );
        } else {
          if (i > 5) {
            break;
          }
          remitMethodChartData.add(
            CircleChartData('其他', otherTotal / total * 100, CircleChartData.colors[5], "￥${otherTotal / 100}"),
          );
        }
      }
      totalStr = "￥${total / 100}";
    }
  }

  changeToRefund() {
    double total = 0;
    double otherTotal = 0; //超过5个显示其他
    remitMethodChartData.clear();
    if (methods.length > 0) {
      methods.sort((a, b) => b.refundAmount.compareTo(a.refundAmount)); //降序
      List newMethods = [];

      for (int i = 0; i < methods.length; i++) {
        if (methods[i].refundAmount == 0) {
          break;
        }
        newMethods.add(methods[i]);
        total = NumUtil.add(total, methods[i].refundAmount);
        if (i > 4) {
          otherTotal = NumUtil.add(otherTotal, methods[i].refundAmount);
        }
      }
      for (int i = 0; i < newMethods.length; i++) {
        if (i <= 4) {
          remitMethodChartData.add(
            CircleChartData(newMethods[i].remitMethodName!, newMethods[i].refundAmount! / total * 100,
                CircleChartData.colors[i], "￥${newMethods[i].refundAmount! / 100}"),
          );
        } else {
          if (i > 5) {
            break;
          }
          remitMethodChartData.add(
            CircleChartData('其他', otherTotal / total * 100, CircleChartData.colors[5], "￥${otherTotal / 100}"),
          );
        }
      }
      totalStr = "￥${total / 100}";
    }
  }

  String viewList = "method"; //"dept"
  List<BiSaleGroupDeptDo> deptRemitData = [];

  String orderByField = "receivedAmount";
  String orderBy = "DESC";

  updateRemitList() {
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    if (deptId != null) {
      biSalePageReq.filterMerchandiser = true;
    }

    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = statisticEndTime; //默认结束时间
    biSalePageReq.customizeStartTime = statisticStartTime;
    BiDeptApi.selectRemitGroupDept(biSalePageReq).then((v) {
      deptRemitData = v;
      update(['remitList']);
    });
  }

  //排序
  sort() {
    if (orderByField == "receivedAmount") {
      if (orderBy == "ASC") {
        methodsList.sort((a, b) => a.receivedAmount.compareTo(b.receivedAmount));
        if (deptId == null) {
          deptRemitData.sort((a, b) => a.receivedAmount.compareTo(b.receivedAmount));
        }
      } else {
        methodsList.sort((a, b) => b.receivedAmount.compareTo(a.receivedAmount));
        if (deptId == null) {
          deptRemitData.sort((a, b) => b.receivedAmount.compareTo(a.receivedAmount));
        }
      }
    }
    if (orderByField == "refundAmount") {
      if (orderBy == "ASC") {
        methodsList.sort((a, b) => a.refundAmount.compareTo(b.refundAmount));
        if (deptId == null) {
          deptRemitData.sort((a, b) => a.refundAmount.compareTo(b.refundAmount));
        }
      } else {
        methods.sort((a, b) => b.refundAmount.compareTo(a.refundAmount));
        if (deptId == null) {
          deptRemitData.sort((a, b) => b.refundAmount.compareTo(a.refundAmount));
        }
      }
    }
    if (orderByField == "totalAmount") {
      if (orderBy == "ASC") {
        methodsList.sort((a, b) => a.totalAmount.compareTo(b.totalAmount));
        if (deptId == null) {
          deptRemitData.sort((a, b) => a.totalAmount.compareTo(b.totalAmount));
        }
      } else {
        methodsList.sort((a, b) => b.totalAmount.compareTo(a.totalAmount));
        if (deptId == null) {
          deptRemitData.sort((a, b) => b.totalAmount.compareTo(a.totalAmount));
        }
      }
    }
    update(["remitList"]);
  }

  //更新所有统计
  updateRemitStatistic() {
    updateRemitTotal();
    updateRemitMethodStatistic();
    if (deptId == null) {
      updateRemitList();
    }
  }

  init() {
    updateRemitChart();
    updateRemitStatistic();
  }

  @override
  void onInit() {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    topDeptId = ArgUtils.getArgument2num(Constant.TOP_DEPT_ID, def: 8512)?.toInt();
    statisticStartTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());
    statisticEndTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());

    if (deptId != null) {
      customerDeptIds.add(deptId);
      init();
    } else {
      BiDeptApi.getDeptSelected().then((v) {
        if (v.length != 0) {
          customerDeptIds.addAll(v);
          update(['deptNum']);
        }
        init();
      });
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
