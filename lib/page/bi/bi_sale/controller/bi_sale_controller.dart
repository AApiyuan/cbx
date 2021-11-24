import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/controller/bi_sale_detail_controller.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_customer_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/enum/bi_select_type_enum.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_dept_user_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/widget/ChartData.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class BiSaleController extends SuperController {
  var deptId;
  var topDeptId;
  var deptName;
  List<int> customerDeptIds = [];
  BiSaleDetailController biSaleDetailController = Get.find<BiSaleDetailController>();

  //头部图表参数
  List<Map> deptSaleChartData = [];
  String selectType = BiSelectTypeEnum.DAY;
  String viewSale = "saleGoodsNum"; //默认查看销量，切换为saleTaxAmount  销售金额
  String customizeStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(15)); //默认开始时间
  int xRotation = 0;
  String yTitle = "件";
  bool showWan = false;
  bool numShowWan = false; //显示万件

  //更新头部图表
  updateDeptChart() {
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    biSalePageReq.selectType = selectType;
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = TimeUtils.getEndOfDay(DateTime.now()); //默认结束时间
    biSalePageReq.customizeStartTime = customizeStartTime; //默认结束时间
    if(deptId!=null){
      biSalePageReq.filterMerchandiser = true;
    }

    BiDeptApi.selectSaleGroupTime(biSalePageReq).then((value) {
      double max = 0;
      value.forEach((element) {
        if (element.saleTaxAmount! > max) {
          max = element.saleTaxAmount as double;
        }
      });
      //相当于大于 10万  设置显示万元
      showWan = max > 9999999 ? true : false;
      if (viewSale == "saleTaxAmount") {
        yTitle = showWan ? "万元" : "元";
      }
      double numMax = 0;
      value.forEach((element) {
        if (element.saleGoodsNum! > numMax) {
          numMax = element.saleGoodsNum as double;
        }
      });

      //相当于大于 10万  设置显示万件
      numShowWan = numMax > 99999 ? true : false;
      if (viewSale == "saleGoodsNum") {
        yTitle = numShowWan ? "万件" : "件";
      }
      value.forEach((element) {
        if (showWan) {
          element.saleTaxAmount = NumUtil.getNumByValueDouble((element.saleTaxAmount! / 1000000), 4) as double;
        } else {
          element.saleTaxAmount = element.saleTaxAmount! / 100;
        }

        if (numShowWan) {
          element.saleGoodsNum = element.saleGoodsNum! / 10000;
        }
      });
      deptSaleChartData = value.map((v) => v.toJson()).toList();
      update(['deptChart']);
    });
  }

  var ownNum = 0.obs;
  var stockNum = 0.obs;
  var substandardNum = 0.obs;

  //更新欠货 和库存
  updateOweAndStock() {
    BasePage basePage = new BasePage();
    Map<String,Object> param = new Map();
    param['topDeptId'] = topDeptId;
    if (customerDeptIds.length != 0) {
      param["customerDeptIds"] = customerDeptIds;
    }
    if (deptId!=null) {
      param["filterMerchandiser"] = true;
    }
    basePage.param = param;
    BiDeptApi.selectShortageByPageSum(basePage).then((v) {
      ownNum.value = v;
    });

    BiDeptApi.selectStockByPageSum(basePage).then((v) {
      stockNum.value = v.stockNum!;
      substandardNum.value = v.substandardNum!;
    });
  }

  var balance = 0.obs;
  var orderOweAmount = 0.obs;

  //更新单据结欠，客户余额
  updateOrderOweAndBalance() {
    BiCustomerPageReq biCustomerPageReq = new BiCustomerPageReq();
    biCustomerPageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biCustomerPageReq.customerDeptIds = customerDeptIds;
    }
    if(deptId!=null){
      biCustomerPageReq.filterMerchandiser = true;
    }
    BiDeptApi.selectCustomerTotal(biCustomerPageReq).then((value) {
      balance.value = value.balance!;
      orderOweAmount.value = value.orderOweAmount!;
    });
  }

  BiSaleSumDo? biSaleSumDo;
  String statisticEndTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());
  String statisticStartTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());

  //更新销售单统计信息
  updateSaleStatisticDetail() {
    BasePage basePage = new BasePage();

    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    if(deptId!=null){
      biSalePageReq.filterMerchandiser = true;
    }
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = statisticEndTime; //默认结束时间
    biSalePageReq.customizeStartTime = statisticStartTime; //默认结束时间
    basePage.param = biSalePageReq;
    BiDeptApi.selectSaleByPageSum(basePage).then((value) {
      biSaleSumDo = value;
      update(['deptSaleStaticDetail']);
    });
  }

  //更新收款 统计
  BiRemitSumDo? biRemitSumDo;
  List<CircleChartData> remitChartData = [];
  String rateStr = "100%";

  updateRemitStatistic() {
    BasePage basePage = new BasePage();
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    if(deptId!=null){
      biSalePageReq.filterMerchandiser = true;
    }
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = statisticEndTime; //默认结束时间
    biSalePageReq.customizeStartTime = statisticStartTime;
    basePage.param = biSalePageReq; //默认结束时间
    BiDeptApi.selectRemitByPageSum(basePage).then((value) {
      biRemitSumDo = value;
      double rate = 1;
      if (value.receivedAmount != 0 && value.refundAmount != 0) {
        rate = NumUtil.getNumByValueDouble(value.receivedAmount! / (value.receivedAmount! + value.refundAmount!), 4) as double;
        rateStr = (NumUtil.multiply(rate, 100)).toString() + "%";
      } else {
        rateStr = "100%";
      }

      remitChartData = [
        CircleChartData('Steve', rate * 100, Color(ColorConfig.color_1678ff)),
        CircleChartData('David', (1 - rate) * 100, Color(ColorConfig.color_ff1a43))
      ];

      update(['deptRemitStaticDetail']);
    });
  }

  List<BiSaleGroupDeptUserDo> userSales = [];

  //更新店员top10
  updateUserSaleTop10() {
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = statisticEndTime; //默认结束时间
    biSalePageReq.customizeStartTime = statisticStartTime;
    if(deptId!=null){
      biSalePageReq.filterMerchandiser = true;
    }
    OrderBy orderBy = new OrderBy();
    orderBy.field = "normalSaleGoodsNum";
    orderBy.by = "DESC";
    biSalePageReq.orderBy = orderBy;
    BiDeptApi.selectSaleGroupDeptUser(biSalePageReq).then((v) {
      userSales.clear();
      if (deptId != null) {
        userSales = v;
      } else {
        if (v.length > 10) {
          for (int i = 0; i < 9; i++) {
            userSales.add(v[i]);
          }
        } else {
          userSales = v;
        }
      }
      update(['deptUserSaleTop10']);
    });
  }

  //更新统计
  updateSaleStatistic() {
    updateSaleStatisticDetail();
    updateRemitStatistic();
    updateUserSaleTop10();
  }

  //初始化
  init() {
    updateDeptChart();
    updateOweAndStock();
    updateOrderOweAndBalance();
    updateSaleStatistic();
  }

  @override
  void onInit() {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    deptName = ArgUtils.getArgument2num(Constant.DEPT_NAME);
    topDeptId = ArgUtils.getArgument2num(Constant.TOP_DEPT_ID, def: 8512)?.toInt();
    biSaleDetailController.deptId = deptId;
    biSaleDetailController.topDeptId = topDeptId;

    if (deptId != null) {
      customerDeptIds.add(deptId);
      init();
    } else {
      BiDeptApi.getDeptSelected().then((v) {
        if (v.length != 0) {
          customerDeptIds.addAll(v);
          update(['deptNum']);
        }
        biSaleDetailController.customerDeptIds = customerDeptIds;
        init();
        biSaleDetailController.init();
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
