import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/widget/ChartData.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_remit_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class BiRemitRecordController extends SuperController {
  var deptId;
  var topDeptId;
  List<int> customerDeptIds = [];
  List<int> remitMethodIds = [];

  String statisticEndTime = TimeUtils.getEndOfDay(DateTime.now());
  String statisticStartTime = TimeUtils.getStartOfDay(DateTime.now());

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
    if (remitMethodIds.length != 0) {
      biSalePageReq.remitMethodIds = remitMethodIds;
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

      update(['remitTotal']);
    });
  }

  List<BiRemitDo> records = [];
  EasyRefreshController refreshController = EasyRefreshController();
  int pageNo = 1; //页码
  int pageSize = 15;

  updateRecord() {
    if (pageNo == 1) {
      records.clear();
    }
    BasePage basePage = new BasePage();
    basePage.pageSize = pageSize;
    basePage.pageNo = pageNo;
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    if (remitMethodIds.length != 0) {
      biSalePageReq.remitMethodIds = remitMethodIds;
    }
    if(deptId!=null){
      biSalePageReq.filterMerchandiser = true;
    }
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = statisticEndTime; //默认结束时间
    biSalePageReq.customizeStartTime = statisticStartTime;
    basePage.param = biSalePageReq; //默认结束时间
    BiRemitApi.selectRemitByPage(basePage).then((value) {
      records.addAll(value);
      update(['recordList']);
    });
  }

  updateRemitStatistic() {
    updateRemitTotal();
    updateRecord();
  }

  init() {
    updateRemitStatistic();
  }

  @override
  void onInit() {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    topDeptId = ArgUtils.getArgument2num(Constant.TOP_DEPT_ID, def: 8512)?.toInt();
    var remitMethodId = ArgUtils.getArgument2num(Constant.REMIT_METHOD_ID)?.toInt();
    statisticStartTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());
    statisticEndTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());
    if (remitMethodId != null) {
      remitMethodIds.add(remitMethodId);
    }
    customerDeptIds.add(deptId);
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
