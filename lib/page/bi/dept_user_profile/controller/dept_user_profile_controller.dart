import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';

import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/sale_type.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_user_detail_do.dart';
import 'package:haidai_flutter_module/page/bi/model/enum/bi_select_type_enum.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_customer_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_goods_page_req_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/req/merchandiser_user_list.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_total_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_goods_id_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/widget/ChartData.dart';
import 'package:haidai_flutter_module/repository/base/customer_user.dart';
import 'package:haidai_flutter_module/repository/bi/bi_customer_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_sale_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class DeptUserProfileController extends SuperController {
  var deptId;
  var topDeptId;
  var deptUserId;
  List<int> customerDeptIds = [];
  List<MerchandiserUserList> merchandiserUserList = [];

  String statisticEndTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());
  String statisticStartTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());

  CustomerDeptUserDetailDo? userInfo;

  updateInfo() {
    CustomerUserApi.customerUserDetail(deptUserId, deptId).then((v) {
      userInfo = v;
      update(['deptUserInfo']);
    });
  }

  BiCustomerTotalDo? biCustomerTotalDo;

  //?????????????????????????????????,??????
  int? customerNum;
  int? newCustomerNum;

  updateOrderOweAndCustomerNum() {
    BiCustomerPageReq biCustomerPageReq = new BiCustomerPageReq();
    biCustomerPageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biCustomerPageReq.customerDeptIds = customerDeptIds;
    }
    if (merchandiserUserList.length != 0) {
      biCustomerPageReq.merchandiserUserList = merchandiserUserList;
    }
    if(deptId!=null){
      biCustomerPageReq.filterMerchandiser = true;
    }
    BiDeptApi.selectCustomerTotal(biCustomerPageReq).then((value) {
      biCustomerTotalDo = value;
      update(['deptUserOweStatistic']);
    });
    BiCustomerApi.selectCustomerPageCount(biCustomerPageReq).then((value) {
      customerNum = value;
      update(['deptUserCustomer']);
    });
  }

  updateCustomerNew() {
    BiCustomerPageReq biCustomerPageReq = new BiCustomerPageReq();
    biCustomerPageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biCustomerPageReq.customerDeptIds = customerDeptIds;
    }
    if (merchandiserUserList.length != 0) {
      biCustomerPageReq.merchandiserUserList = merchandiserUserList;
    }
    biCustomerPageReq.createdStartTime = TimeUtils.getStartOfMouth(DateTime.now());
    biCustomerPageReq.createdEndTime = TimeUtils.getEndOfDay(DateTime.now());
    if(deptId!=null){
      biCustomerPageReq.filterMerchandiser = true;
    }
    BiCustomerApi.selectCustomerPageCount(biCustomerPageReq).then((value) {
      newCustomerNum = value;
      update(['deptUserCustomer']);
    });
  }

  //??????????????????
  List<Map> deptUserChartData = [];
  String selectType = BiSelectTypeEnum.DAY;
  String viewSale = "normalSaleGoodsNum"; //??????????????????????????????saleTaxAmount  ????????????
  String customizeStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(15)); //??????????????????
  int xRotation = 0;
  String yTitle = "???";
  bool showWan = false;
  bool numShowWan = false; //????????????

  updateDeptUserChart() {
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    if (merchandiserUserList.length != 0) {
      biSalePageReq.merchandiserUserList = merchandiserUserList;
    }
    if(deptId!=null){
      biSalePageReq.filterMerchandiser = true;
    }
    biSalePageReq.selectType = selectType;
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = TimeUtils.getEndOfDay(DateTime.now()); //??????????????????
    biSalePageReq.customizeStartTime = customizeStartTime; //??????????????????
    biSalePageReq.type = SaleTypeEnum.NORMAL_SALE; //???????????????????????????

    BiDeptApi.selectSaleGroupTime(biSalePageReq).then((value) {
      double max = 0;
      value.forEach((element) {
        if (element.normalSaleTaxAmount! > max) {
          max = element.normalSaleTaxAmount as double;
        }
      });
      //??????????????? 10???  ??????????????????
      showWan = max > 9999999 ? true : false;
      if (viewSale == "normalSaleTaxAmount") {
        yTitle = showWan ? "??????" : "???";
      }
      double numMax = 0;
      value.forEach((element) {
        if (element.normalSaleGoodsNum! > numMax) {
          numMax = element.normalSaleGoodsNum as double;
        }
      });

      //??????????????? 10???  ??????????????????
      numShowWan = numMax > 99999 ? true : false;
      if (viewSale == "normalSaleGoodsNum") {
        yTitle = numShowWan ? "??????" : "???";
      }
      value.forEach((element) {
        if (showWan) {
          element.normalSaleTaxAmount = NumUtil.getNumByValueDouble((element.normalSaleTaxAmount! / 1000000), 4) as double;
        } else {
          element.normalSaleTaxAmount = element.normalSaleTaxAmount! / 100;
        }

        if (numShowWan) {
          element.normalSaleGoodsNum = element.normalSaleGoodsNum! / 10000;
        }
      });
      deptUserChartData = value.map((v) => v.toJson()).toList();
      update(['deptUserChart']);
    });
  }

  BiSaleSumDo? biSaleSumDo;

  //???????????????????????????
  updateSaleStatisticDetail() {
    BasePage basePage = new BasePage();

    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    if (merchandiserUserList.length != 0) {
      biSalePageReq.merchandiserUserList = merchandiserUserList;
    }
    if(deptId!=null){
      biSalePageReq.filterMerchandiser = true;
    }
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = statisticEndTime; //??????????????????
    biSalePageReq.customizeStartTime = statisticStartTime; //??????????????????
    basePage.param = biSalePageReq;
    BiDeptApi.selectSaleByPageSum(basePage).then((value) {
      biSaleSumDo = value;
      update(['deptSaleStaticDetail']);
    });
  }

  //???????????? ??????
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
    if (merchandiserUserList.length != 0) {
      biSalePageReq.merchandiserUserList = merchandiserUserList;
    }
    if(deptId!=null){
      biSalePageReq.filterMerchandiser = true;
    }
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = statisticEndTime; //??????????????????
    biSalePageReq.customizeStartTime = statisticStartTime;
    basePage.param = biSalePageReq; //??????????????????
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

  var viewList = "sale"; //oweAmountCustomer,oweNumCustomer,oweGoods
  var orderByField = "normalSaleGoodsNum";
  var orderBy = "DESC";
  EasyRefreshController refreshController = EasyRefreshController();
  int pageNo = 1; //??????
  int pageSize = 15;

  List<BiSaleGoodsGroupGoodsIdDo> goodsRecords = [];
  List<BiCustomerDo> customerRecords = [];

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
      if (merchandiserUserList.length != 0) {
        req.merchandiserUserList = merchandiserUserList;
      }
      if(deptId!=null){
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
          goodsRecords.clear();
        }

        if (viewList == "sale") {
          v.forEach((element) {
            if (element.normalSaleGoodsNum! > 0) {
              goodsRecords.add(element);
            }
          });
        } else {
          v.forEach((element) {
            if (element.shortageNum! > 0) {
              goodsRecords.add(element);
            }
          });
        }
        update(["deptUserList"]);
      });
    } else {
      BiCustomerPageReq biCustomerPageReq = new BiCustomerPageReq();
      if (customerDeptIds.length != 0) {
        biCustomerPageReq.customerDeptIds = customerDeptIds;
      }
      if (merchandiserUserList.length != 0) {
        biCustomerPageReq.merchandiserUserList = merchandiserUserList;
      }
      if(deptId!=null){
        biCustomerPageReq.filterMerchandiser = true;
      }
      biCustomerPageReq.topDeptId = topDeptId;
      OrderBy _orderBy = new OrderBy();
      _orderBy.field = orderByField;
      _orderBy.by = orderBy;
      biCustomerPageReq.orderBy = _orderBy;
      param.param = biCustomerPageReq;

      BiCustomerApi.selectCustomerPage(param).then((v) {
        if (pageNo == 1) {
          customerRecords.clear();
        }
        if (viewList == "oweAmountCustomer") {
          v.forEach((element) {
            if (element.orderOweAmount! != 0 || element.balance! != 0) {
              customerRecords.add(element);
            }
          });
        } else {
          v.forEach((element) {
            if (element.shortageNum! > 0) {
              customerRecords.add(element);
            }
          });
        }
        update(["deptUserList"]);
      });
    }
    update(['deptUserSortTitle']);
  }

  updateStatistic() {
    updateSaleStatisticDetail();
    updateRemitStatistic();
    updateRecord();
  }

  init() {
    updateInfo();
    updateOrderOweAndCustomerNum();
    updateCustomerNew();
    updateDeptUserChart();
    updateStatistic();
  }

  @override
  void onInit() {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    topDeptId = ArgUtils.getArgument2num(Constant.TOP_DEPT_ID, def: 8512)?.toInt();
    deptUserId = ArgUtils.getArgument2num(Constant.DEPT_USER_ID);
    statisticStartTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());
    statisticEndTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());

    customerDeptIds.add(deptId);
    MerchandiserUserList merchandiser = new MerchandiserUserList();
    merchandiser.deptId = deptId;
    merchandiser.id = deptUserId;
    merchandiserUserList = [merchandiser];

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
