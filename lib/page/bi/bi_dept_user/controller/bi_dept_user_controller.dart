import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/sale_type.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_customer_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_group_dept_user_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_total_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_dept_user_do.dart';
import 'package:haidai_flutter_module/page/bi/widget/ChartData.dart';
import 'package:haidai_flutter_module/repository/bi/bi_customer_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_remit_api.dart';

class BiDeptUserController extends SuperController {
  var deptId;
  var topDeptId;
  List<int> customerDeptIds = [];

  String statisticEndTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());
  String statisticStartTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());

  var viewList = "sale"; //returnOwe,returnGoods,saleTotal,remit
  var orderByField = "normalSaleGoodsNum";
  var orderBy = "DESC";
  List<BiSaleGroupDeptUserDo> deptUserSaleData = []; //列表用
  List<BiSaleGroupDeptUserDo> deptUserNormalSaleData = []; //chart原始数据
  List<BiSaleGroupDeptUserDo> deptUserSaleDataFilter = []; //过滤的数据

  String totalStr = "0";
  List<CircleChartData> deptUserChartData = [];
  String viewMethod = "normalSaleGoodsNum"; //normalSaleTaxAmount,orderSaleNum

  updateDeptSale() {
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

    BiDeptApi.selectSaleGroupDeptUser(biSalePageReq).then((v) {
      v.forEach((element) {
        element.returnGoodsNum = -element.returnGoodsNum!;
        element.returnAmount = -element.returnAmount!;
        element.changeBackOrderGoodsNum = -element.changeBackOrderGoodsNum!;
        element.changeBackOrderAmount = -element.changeBackOrderAmount!;
      });
      deptUserSaleData = v;
      BiRemitApi.selectRemitGroupDeptUser(biSalePageReq).then((value) {
        value.forEach((element) {
          deptUserSaleData.forEach((e) {
            if (e.merchandiserId == element.merchandiserId && e.deptId == element.deptId) {
              e.refundAmount = element.refundAmount;
              e.receivedAmount = element.receivedAmount;
              e.totalAmount = element.totalAmount;
            }
          });
        });
        changeView();
      });
    });
  }

  updateDeptSaleChart() {
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    biSalePageReq.canceled = CanceledEnum.ENABLE;
    biSalePageReq.customizeEndTime = statisticEndTime; //默认结束时间
    biSalePageReq.customizeStartTime = statisticStartTime;
    biSalePageReq.type = SaleTypeEnum.NORMAL_SALE;
    if(deptId!=null){
      biSalePageReq.filterMerchandiser = true;
    }

    BiDeptApi.selectSaleGroupDeptUser(biSalePageReq).then((v) {
      deptUserNormalSaleData = v;
      if (deptId != null) {
        if (viewMethod == "normalSaleGoodsNum") {
          changeToSaleNum();
        }
        if (viewMethod == "normalSaleTaxAmount") {
          changeToSaleAmount();
        }
        if (viewMethod == "orderSaleNum") {
          changeOrderNum();
        }
      }
      changeToSaleNum();
    });
  }

  //改变chat
  changeToSaleNum() {
    int total = 0;
    int otherTotal = 0; //超过5个显示其他
    deptUserChartData.clear();
    if (deptUserNormalSaleData.length > 0) {
      deptUserNormalSaleData.sort((a, b) => b.normalSaleGoodsNum!.compareTo(a.normalSaleGoodsNum!)); //降序
      List<BiSaleGroupDeptUserDo> newList = [];

      for (int i = 0; i < deptUserNormalSaleData.length; i++) {
        if (deptUserNormalSaleData[i].normalSaleGoodsNum == 0) {
          break;
        }
        newList.add(deptUserNormalSaleData[i]);
        total += deptUserNormalSaleData[i].normalSaleGoodsNum!;
        if (i > 4) {
          otherTotal += deptUserNormalSaleData[i].normalSaleGoodsNum!;
        }
      }
      for (int i = 0; i < newList.length; i++) {
        if (i <= 4) {
          deptUserChartData.add(
            CircleChartData(newList[i].merchandiserName.toString(), newList[i].normalSaleGoodsNum! / total * 100, CircleChartData.colors[i],
                newList[i].normalSaleGoodsNum.toString()),
          );
        } else {
          if (i > 5) {
            break;
          }
          deptUserChartData.add(
            CircleChartData('其他', otherTotal / total * 100, CircleChartData.colors[5], otherTotal.toString()),
          );
        }
      }
    }
    totalStr = total.toString();
    update(["deptUserChart"]);
  }

  //改变chat
  changeToSaleAmount() {
    double total = 0;
    double otherTotal = 0; //超过5个显示其他
    deptUserChartData.clear();
    if (deptUserNormalSaleData.length > 0) {
      deptUserNormalSaleData.sort((a, b) => b.normalSaleTaxAmount!.compareTo(a.normalSaleTaxAmount!)); //降序
      List<BiSaleGroupDeptUserDo> newList = [];

      for (int i = 0; i < deptUserNormalSaleData.length; i++) {
        if (deptUserNormalSaleData[i].normalSaleTaxAmount == 0) {
          break;
        }
        newList.add(deptUserNormalSaleData[i]);
        total = NumUtil.add(total, deptUserNormalSaleData[i].normalSaleTaxAmount!);
        if (i > 4) {
          otherTotal = NumUtil.add(otherTotal, deptUserNormalSaleData[i].normalSaleTaxAmount!);
        }
      }
      for (int i = 0; i < newList.length; i++) {
        if (i <= 4) {
          deptUserChartData.add(
            CircleChartData(newList[i].merchandiserName.toString(), newList[i].normalSaleTaxAmount! / total * 100, CircleChartData.colors[i],
                "￥${newList[i].normalSaleTaxAmount! / 100}"),
          );
        } else {
          if (i > 5) {
            break;
          }
          deptUserChartData.add(
            CircleChartData('其他', otherTotal / total * 100, CircleChartData.colors[5], "￥${otherTotal / 100}"),
          );
        }
      }
      totalStr = "￥${total / 100}";
    }
    update(["deptUserChart"]);
  }

  //改变chat
  changeOrderNum() {
    int total = 0;
    int otherTotal = 0; //超过5个显示其他
    deptUserChartData.clear();
    if (deptUserNormalSaleData.length > 0) {
      deptUserSaleData.sort((a, b) => b.orderSaleNum!.compareTo(a.orderSaleNum!)); //降序
      List<BiSaleGroupDeptUserDo> newList = [];

      for (int i = 0; i < deptUserNormalSaleData.length; i++) {
        if (deptUserNormalSaleData[i].orderSaleNum == 0) {
          break;
        }
        newList.add(deptUserNormalSaleData[i]);
        total += deptUserNormalSaleData[i].orderSaleNum!;
        if (i > 4) {
          otherTotal += deptUserNormalSaleData[i].orderSaleNum!;
        }
      }
      for (int i = 0; i < newList.length; i++) {
        if (i <= 4) {
          deptUserChartData.add(
            CircleChartData(newList[i].merchandiserName.toString(), newList[i].orderSaleNum! / total * 100, CircleChartData.colors[i],
                newList[i].orderSaleNum.toString()),
          );
        } else {
          if (i > 5) {
            break;
          }
          deptUserChartData.add(
            CircleChartData('其他', otherTotal / total * 100, CircleChartData.colors[5], otherTotal.toString()),
          );
        }
      }
    }
    totalStr = total.toString();
    update(["deptUserChart"]);
  }

  changeView() {
    if (viewList == "sale") {
      deptUserSaleDataFilter.clear();
      deptUserSaleData.forEach((element) {
        if (element.normalSaleGoodsNum != 0) {
          deptUserSaleDataFilter.add(element);
        }
      });
    }
    if (viewList == "returnOwe") {
      deptUserSaleDataFilter.clear();
      deptUserSaleData.forEach((element) {
        if (element.changeBackOrderGoodsNum != 0) {
          deptUserSaleDataFilter.add(element);
        }
      });
    }
    if (viewList == "returnGoods") {
      deptUserSaleDataFilter.clear();
      deptUserSaleData.forEach((element) {
        if (element.returnGoodsNum != 0) {
          deptUserSaleDataFilter.add(element);
        }
      });
    }
    if (viewList == "saleTotal") {
      deptUserSaleDataFilter.clear();
      deptUserSaleData.forEach((element) {
        if (element.saleGoodsNum != 0) {
          deptUserSaleDataFilter.add(element);
        }
      });
    }
    if (viewList == "remit") {
      deptUserSaleDataFilter.clear();
      deptUserSaleData.forEach((element) {
        if (element.receivedAmount != 0 || element.refundAmount != 0) {
          deptUserSaleDataFilter.add(element);
        }
      });
    }
    sort();
  }

  sort() {
    if (orderByField == "normalSaleGoodsNum") {
      if (orderBy == "ASC") {
        deptUserSaleDataFilter.sort((a, b) => a.normalSaleGoodsNum!.compareTo(b.normalSaleGoodsNum!));
      } else {
        deptUserSaleDataFilter.sort((a, b) => b.normalSaleGoodsNum!.compareTo(a.normalSaleGoodsNum!));
      }
    }
    if (orderByField == "normalSaleTaxAmount") {
      if (orderBy == "ASC") {
        deptUserSaleDataFilter.sort((a, b) => a.normalSaleTaxAmount!.compareTo(b.normalSaleTaxAmount!));
      } else {
        deptUserSaleDataFilter.sort((a, b) => b.normalSaleTaxAmount!.compareTo(a.normalSaleTaxAmount!));
      }
    }
    if (orderByField == "returnGoodsNum") {
      if (orderBy == "ASC") {
        deptUserSaleDataFilter.sort((a, b) => a.returnGoodsNum!.compareTo(b.returnGoodsNum!));
      } else {
        deptUserSaleDataFilter.sort((a, b) => b.returnGoodsNum!.compareTo(a.returnGoodsNum!));
      }
    }
    if (orderByField == "returnAmount") {
      if (orderBy == "ASC") {
        deptUserSaleDataFilter.sort((a, b) => a.returnAmount!.compareTo(b.returnAmount!));
      } else {
        deptUserSaleDataFilter.sort((a, b) => b.returnAmount!.compareTo(a.returnAmount!));
      }
    }
    if (orderByField == "changeBackOrderGoodsNum") {
      if (orderBy == "ASC") {
        deptUserSaleDataFilter.sort((a, b) => a.changeBackOrderGoodsNum!.compareTo(b.changeBackOrderGoodsNum!));
      } else {
        deptUserSaleDataFilter.sort((a, b) => b.changeBackOrderGoodsNum!.compareTo(a.changeBackOrderGoodsNum!));
      }
    }
    if (orderByField == "changeBackOrderAmount") {
      if (orderBy == "ASC") {
        deptUserSaleDataFilter.sort((a, b) => a.changeBackOrderAmount!.compareTo(b.changeBackOrderAmount!));
      } else {
        deptUserSaleDataFilter.sort((a, b) => b.changeBackOrderAmount!.compareTo(a.changeBackOrderAmount!));
      }
    }
    if (orderByField == "saleGoodsNum") {
      if (orderBy == "ASC") {
        deptUserSaleDataFilter.sort((a, b) => a.saleGoodsNum!.compareTo(b.saleGoodsNum!));
      } else {
        deptUserSaleDataFilter.sort((a, b) => b.saleGoodsNum!.compareTo(a.saleGoodsNum!));
      }
    }
    if (orderByField == "saleTaxAmount") {
      if (orderBy == "ASC") {
        deptUserSaleDataFilter.sort((a, b) => a.saleTaxAmount!.compareTo(b.saleTaxAmount!));
      } else {
        deptUserSaleDataFilter.sort((a, b) => b.saleTaxAmount!.compareTo(a.saleTaxAmount!));
      }
    }
    if (orderByField == "receivedAmount") {
      if (orderBy == "ASC") {
        deptUserSaleDataFilter.sort((a, b) => a.receivedAmount.compareTo(b.receivedAmount));
      } else {
        deptUserSaleDataFilter.sort((a, b) => b.receivedAmount.compareTo(a.receivedAmount));
      }
    }
    if (orderByField == "refundAmount") {
      if (orderBy == "ASC") {
        deptUserSaleDataFilter.sort((a, b) => a.refundAmount.compareTo(b.refundAmount));
      } else {
        deptUserSaleDataFilter.sort((a, b) => b.refundAmount.compareTo(a.refundAmount));
      }
    }
    update(['deptUserSaleList', 'deptUserSaleListTitle']);
  }

  updateStatistic() {
    updateDeptSale();
    if (deptId != null) {
      updateDeptSaleChart();
    }
  }

  //跟单统计
  BiCustomerTotalDo? biCustomerTotalDo;

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
      biCustomerTotalDo = value;
      update(['deptUserOweStatistic']);
    });
  }

  //跟单列表
  List<BiCustomerGroupDeptUserDo> customerGroupDeptUsers = [];
  var oweOrderByField = "orderOweAmount";
  var oweOrderBy = "DESC";

  updateOrderOweAndBalanceList() {
    BiCustomerPageReq biCustomerPageReq = new BiCustomerPageReq();
    biCustomerPageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biCustomerPageReq.customerDeptIds = customerDeptIds;
    }
    if(deptId!=null){
      biCustomerPageReq.filterMerchandiser = true;
    }
    BiCustomerApi.selectCustomerGroupDeptUser(biCustomerPageReq).then((value) {
      customerGroupDeptUsers = value;
      oweSort();
    });
  }

  oweSort() {
    if (oweOrderByField == "orderOweAmount") {
      if (oweOrderBy == "ASC") {
        customerGroupDeptUsers.sort((a, b) => a.orderOweAmount!.compareTo(b.orderOweAmount!));
      } else {
        customerGroupDeptUsers.sort((a, b) => b.orderOweAmount!.compareTo(a.orderOweAmount!));
      }
    }
    if (oweOrderByField == "balance") {
      if (oweOrderBy == "ASC") {
        customerGroupDeptUsers.sort((a, b) => a.balance!.compareTo(b.balance!));
      } else {
        customerGroupDeptUsers.sort((a, b) => b.balance!.compareTo(a.balance!));
      }
    }
    if (oweOrderByField == "shortageNum") {
      if (oweOrderBy == "ASC") {
        customerGroupDeptUsers.sort((a, b) => a.shortageNum!.compareTo(b.shortageNum!));
      } else {
        customerGroupDeptUsers.sort((a, b) => b.shortageNum!.compareTo(a.shortageNum!));
      }
    }
    update(['deptUserOweList']);
  }

  init() {
    updateStatistic();
    updateOrderOweAndBalance();
    updateOrderOweAndBalanceList();
  }

  @override
  void onInit() {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    topDeptId = ArgUtils.getArgument2num(Constant.TOP_DEPT_ID, def: 8512)?.toInt();
    update(['showAll', 'deptUserChart']);

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
