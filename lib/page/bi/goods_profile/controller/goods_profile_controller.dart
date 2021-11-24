import 'package:flustars/flustars.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';

import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/goods/store_goods_do.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/enum/bi_select_type_enum.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_goods_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_total_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_goods_stock_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_customer_do_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_dept_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_sum_do.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_sale_api.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class GoodsProfileController extends SuperController {
  var deptId;
  var topDeptId;
  var goodsId;
  List<int> customerDeptIds = [];
  List<int> goodsIds = [];

  String statisticEndTime = TimeUtils.getEndOfDay(DateTime.now());
  String statisticStartTime = TimeUtils.getStartOfDay(DateTime.now());

  StoreGoodsDo? goodsInfo;

  updateInfo() {
    GoodsApi.getGoodsDetail(goodsId, isBasic: true).then((v) {
      goodsInfo = v;
      update(['goodsInfo']);
    });
  }

  BiCustomerTotalDo? biCustomerTotalDo;

  //更新单据结欠，客户余额,跟大
  BiGoodsStockSumDo? goodsStockSumDo;
  int? oweNum;

  updateGoodsStockStatistic() {
    BasePage basePage = new BasePage();
    Map<String,Object> param = new Map();
    param['topDeptId'] = topDeptId;
    if(customerDeptIds.length != 0){
      param['customerDeptIds'] = customerDeptIds;
    }
    if(goodsIds.length != 0){
      param['goodsIds'] = goodsIds;
    }
    if(deptId!=null){
      param['filterMerchandiser'] = true;
    }
    basePage.param = param;

    BiDeptApi.selectShortageByPageSum(basePage).then((v) {
      oweNum = v;
      update(['goodsOwe']);
    });

    BiDeptApi.selectStockByPageSum(basePage).then((v) {
      goodsStockSumDo = v;
      update(["goodsStockStatistic"]);
    });
  }


  //头部图表参数
  List<Map> goodsChartData = [];
  String selectType = BiSelectTypeEnum.DAY;
  String viewSale = "saleGoodsNum"; //默认查看销量，saleTaxAmount  销售金额
  String customizeStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(15)); //默认开始时间
  int xRotation = 0;
  String yTitle = "件";
  bool showWan = false;
  bool numShowWan = false; //显示万件

  updateGoodsChart() {
    BiSaleGoodsPageReq biSaleGoodsPageReq = new BiSaleGoodsPageReq();
    biSaleGoodsPageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSaleGoodsPageReq.customerDeptIds = customerDeptIds;
    }
    if (goodsIds.length != 0) {
      biSaleGoodsPageReq.goodsIds = goodsIds;
    }
    if(deptId!=null){
      biSaleGoodsPageReq.filterMerchandiser = true;
    }
    biSaleGoodsPageReq.selectType = selectType;
    biSaleGoodsPageReq.canceled = CanceledEnum.ENABLE;
    biSaleGoodsPageReq.customizeEndTime = TimeUtils.getEndOfDay(DateTime.now()); //默认结束时间
    biSaleGoodsPageReq.customizeStartTime = customizeStartTime; //默认结束时间

    BiSaleApi.selectSaleGoodsGroupTime(biSaleGoodsPageReq).then((value) {
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
      goodsChartData = value.map((v) => v.toJson()).toList();
      update(['goodsChart']);
    });
  }

  BiSaleGoodsSumDo? biSaleGoodsSumDo;

  //更新销售单统计信息
  updateSaleStatisticDetail() {
    BasePage basePage = new BasePage();

    BiSaleGoodsPageReq biSaleGoodsPageReq = new BiSaleGoodsPageReq();
    biSaleGoodsPageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSaleGoodsPageReq.customerDeptIds = customerDeptIds;
    }
    if (goodsIds.length != 0) {
      biSaleGoodsPageReq.goodsIds = goodsIds;
    }
    if(deptId!=null){
      biSaleGoodsPageReq.filterMerchandiser = true;
    }
    biSaleGoodsPageReq.selectType = selectType;
    biSaleGoodsPageReq.canceled = CanceledEnum.ENABLE;
    biSaleGoodsPageReq.customizeEndTime = statisticEndTime; //默认结束时间
    biSaleGoodsPageReq.customizeStartTime = statisticStartTime; //默认结束时间//默认结束时间
    basePage.param = biSaleGoodsPageReq;
    BiSaleApi.selectSaleGoodsByPageSum(basePage).then((value) {
      biSaleGoodsSumDo = value;
      update(['deptSaleStaticDetail']);
    });
  }

  var viewList = "sale"; //oweNumCustomer,deptSale
  var orderByField = "normalSaleGoodsNum";
  var orderBy = "DESC";
  EasyRefreshController refreshController = EasyRefreshController();
  int pageNo = 1; //页码
  int pageSize = 15;

  List<BiSaleGoodsGroupCustomerDoEntity> goodsRecords = [];
  List<BiSaleGoodsGroupDeptDo> deptRecords = [];

  updateRecord() {
    var param = BasePage();
    param.pageNo = pageNo;
    param.pageSize = pageSize;
    if (viewList == "sale" || viewList == "oweNumCustomer") {
      BiSaleGoodsPageReq biSaleGoodsPageReq = new BiSaleGoodsPageReq();
      biSaleGoodsPageReq.topDeptId = topDeptId;
      if (customerDeptIds.length != 0) {
        biSaleGoodsPageReq.customerDeptIds = customerDeptIds;
      }
      if (goodsIds.length != 0) {
        biSaleGoodsPageReq.goodsIds = goodsIds;
      }
      if(deptId!=null){
        biSaleGoodsPageReq.filterMerchandiser = true;
      }
      biSaleGoodsPageReq.selectType = selectType;
      biSaleGoodsPageReq.canceled = CanceledEnum.ENABLE;
      biSaleGoodsPageReq.customizeEndTime = TimeUtils.getEndOfDay(DateTime.now()); //默认结束时间
      biSaleGoodsPageReq.customizeStartTime = customizeStartTime; //默认结束时间//默认结束时间
      biSaleGoodsPageReq.topDeptId = topDeptId;
      OrderBy _orderBy = new OrderBy();
      _orderBy.field = orderByField;
      _orderBy.by = orderBy;
      biSaleGoodsPageReq.orderBy = _orderBy;
      param.param = biSaleGoodsPageReq;
      BiSaleApi.selectSaleGoodsGroupCustomerByPage(param).then((v) {
        if (pageNo == 1) {
          goodsRecords = v;
        } else {
          goodsRecords.addAll(v);
        }

        update(["goodsList"]);
      });
    } else {
      BiSaleGoodsPageReq biSaleGoodsPageReq = new BiSaleGoodsPageReq();
      biSaleGoodsPageReq.topDeptId = topDeptId;
      if (customerDeptIds.length != 0) {
        biSaleGoodsPageReq.customerDeptIds = customerDeptIds;
      }
      if (goodsIds.length != 0) {
        biSaleGoodsPageReq.goodsIds = goodsIds;
      }
      if(deptId!=null){
        biSaleGoodsPageReq.filterMerchandiser = true;
      }
      biSaleGoodsPageReq.selectType = selectType;
      biSaleGoodsPageReq.canceled = CanceledEnum.ENABLE;
      biSaleGoodsPageReq.customizeEndTime = TimeUtils.getEndOfDay(DateTime.now()); //默认结束时间
      biSaleGoodsPageReq.customizeStartTime = customizeStartTime; //默认结束时间//默认结束时间
      biSaleGoodsPageReq.topDeptId = topDeptId;
      OrderBy _orderBy = new OrderBy();
      _orderBy.field = orderByField;
      _orderBy.by = orderBy;
      biSaleGoodsPageReq.orderBy = _orderBy;

      BiSaleApi.selectSaleGoodsGroupDept(biSaleGoodsPageReq).then((v) {
        // if (pageNo == 1) {
          deptRecords = v;
        // } else {
        //   deptRecords.addAll(v);
        // }
        update(["goodsList"]);
      });
    }
    update(['goodsSortTitle']);
  }

  updateStatistic() {
    updateSaleStatisticDetail();
    updateRecord();
  }

  init() {
    updateInfo();
    updateGoodsStockStatistic();
    updateGoodsChart();
    updateStatistic();
  }

  @override
  void onInit() {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    topDeptId = ArgUtils.getArgument2num(Constant.TOP_DEPT_ID, def: 8512)?.toInt();
    goodsId = ArgUtils.getArgument2num(Constant.GOODS_ID);
    statisticStartTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());
    statisticEndTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());

    if(deptId!=null){
      customerDeptIds.add(deptId);
    }
    goodsIds.add(goodsId);
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
