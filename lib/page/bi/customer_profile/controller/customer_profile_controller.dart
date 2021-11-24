import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';

import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/enum/bi_select_type_enum.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_goods_page_req_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_goods_classify_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_goods_id_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/widget/ChartData.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_sale_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class CustomerProfileController extends SuperController {
  var deptId;
  var topDeptId;
  var customerId;
  List<int> customerDeptIds = [];
  List<int> customerIds = [];

  String statisticEndTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());
  String statisticStartTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());

  StoreCustomerListItemDoEntity? customerInfo;

  updateInfo() {
    CustomerApi.getCustomer(customerId).then((v) {
      customerInfo = v;
      update(['customerInfo', "customerOweStatistic", "customerCustomer"]);
    });
  }

  //头部图表参数
  List<Map> customerChartData = [];
  String selectType = BiSelectTypeEnum.DAY;
  String viewSale = "normalSaleGoodsNum"; //默认查看销量，切换为saleTaxAmount  销售金额
  String customizeStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(15)); //默认开始时间
  int xRotation = 0;
  String yTitle = "件";
  bool showWan = false;
  bool numShowWan = false; //显示万件

  updateCustomerChart() {
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    if (customerIds.length != 0) {
      biSalePageReq.customerIds = customerIds;
    }
    if (deptId != null) {
      biSalePageReq.filterMerchandiser = true;
    }
    biSalePageReq.selectType = selectType;
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = TimeUtils.getEndOfDay(DateTime.now()); //默认结束时间
    biSalePageReq.customizeStartTime = customizeStartTime; //默认结束时间

    BiDeptApi.selectSaleGroupTime(biSalePageReq).then((value) {
      double max = 0;
      value.forEach((element) {
        if (element.normalSaleTaxAmount! > max) {
          max = element.normalSaleTaxAmount as double;
        }
      });
      //相当于大于 10万  设置显示万元
      showWan = max > 9999999 ? true : false;
      if (viewSale == "normalSaleTaxAmount") {
        yTitle = showWan ? "万元" : "元";
      }
      double numMax = 0;
      value.forEach((element) {
        if (element.normalSaleGoodsNum! > numMax) {
          numMax = element.normalSaleGoodsNum as double;
        }
      });

      //相当于大于 10万  设置显示万件
      numShowWan = numMax > 99999 ? true : false;
      if (viewSale == "normalSaleGoodsNum") {
        yTitle = numShowWan ? "万件" : "件";
      }
      value.forEach((element) {
        if (showWan) {
          element.normalSaleTaxAmount =
              NumUtil.getNumByValueDouble((element.normalSaleTaxAmount! / 1000000), 4) as double;
        } else {
          element.normalSaleTaxAmount = element.normalSaleTaxAmount! / 100;
        }

        if (numShowWan) {
          element.normalSaleGoodsNum = element.normalSaleGoodsNum! / 10000;
        }
      });
      customerChartData = value.map((v) => v.toJson()).toList();
      update(['customerChart']);
    });
  }

  BiSaleSumDo? biSaleSumDo;

  //更新销售单统计信息
  updateSaleStatisticDetail() {
    BasePage basePage = new BasePage();

    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    if (customerIds.length != 0) {
      biSalePageReq.customerIds = customerIds;
    }
    if (deptId != null) {
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
    if (customerIds.length != 0) {
      biSalePageReq.customerIds = customerIds;
    }
    if (deptId != null) {
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

      update(['deptRemitStaticDetail']);
    });
  }

  var viewList = "sale"; //classify,oweGoods
  var orderByField = "normalSaleGoodsNum";
  var orderBy = "DESC";
  EasyRefreshController refreshController = EasyRefreshController();
  int pageNo = 1; //页码
  int pageSize = 15;

  List<BiSaleGoodsGroupGoodsIdDo> goodsRecords = [];
  List<BiSaleGoodsGroupGoodsClassifyDo> classifyRecords = [];

  updateRecord() {
    var param = BasePage();
    param.pageNo = pageNo;
    param.pageSize = pageSize;
    if (viewList == "sale" || viewList == "oweGoods") {
      BiSaleGoodsPageReqEntity req = BiSaleGoodsPageReqEntity();
      req.canceled = CanceledEnum.ENABLE;
      req.customizeEndTime = statisticEndTime;
      req.customizeStartTime = statisticStartTime;
      if (customerDeptIds.length != 0) {
        req.customerDeptIds = customerDeptIds;
      }
      if (customerIds.length != 0) {
        req.customerIds = customerIds;
      }
      if (deptId != null) {
        req.filterMerchandiser = true;
      }
      req.topDeptId = topDeptId;
      OrderBy _orderBy = new OrderBy();
      _orderBy.field = orderByField;
      _orderBy.by = orderBy;
      req.orderBy = _orderBy;
      param.param = req;
      BiSaleApi.selectSaleGoodsGroupGoodsIdByPage(param).then((v) {
        if (pageNo == 1) {
          goodsRecords = v;
        } else {
          goodsRecords.addAll(v);
        }

        update(["customerList"]);
      });
    } else {
      BiSaleGoodsPageReqEntity req = BiSaleGoodsPageReqEntity();
      req.canceled = CanceledEnum.ENABLE;
      req.customizeEndTime = statisticEndTime;
      req.customizeStartTime = statisticStartTime;
      if (customerDeptIds.length != 0) {
        req.customerDeptIds = customerDeptIds;
      }
      if (customerIds.length != 0) {
        req.customerIds = customerIds;
      }
      req.topDeptId = topDeptId;
      if (deptId != null) {
        req.filterMerchandiser = true;
      }

      BiSaleApi.selectSaleGoodsGroupGoodsClassify(req).then((v) {
        if (v.length > 0) {
          List<BiSaleGoodsGroupGoodsClassifyDo> filters = [];
          v.forEach((element) {
            if (element.goodsClassify != null) {
              filters.add(element);
            }
          });
          classifyRecords = filters;
        } else {
          classifyRecords = v;
        }
        update(["customerList"]);
      });
    }
    update(['customerSortTitle']);
  }

  updateStatistic() {
    updateSaleStatisticDetail();
    updateRemitStatistic();
    updateRecord();
  }

  init() {
    updateInfo();
    updateCustomerChart();
    updateStatistic();
  }

  @override
  void onInit() {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    topDeptId = ArgUtils.getArgument2num(Constant.TOP_DEPT_ID, def: 8512)?.toInt();
    customerId = ArgUtils.getArgument2num(Constant.CUSTOMER_ID);
    statisticStartTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());
    statisticEndTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());

    customerDeptIds.add(deptId);
    customerIds.add(customerId);

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
