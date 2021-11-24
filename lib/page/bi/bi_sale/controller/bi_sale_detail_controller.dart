import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/sale_type.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_customer_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_dept_do.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';

class BiSaleDetailController extends SuperController {
  var deptId;
  var topDeptId;
  List<int> customerDeptIds = [];

  String statisticEndTime = ArgUtils.getArgument(Constant.END_TIME) ?? TimeUtils.getEndOfDay(DateTime.now());
  String statisticStartTime = ArgUtils.getArgument(Constant.START_TIME) ?? TimeUtils.getStartOfDay(DateTime.now());

  String orderByField = "saleTaxAmount";
  String orderBy = "DESC";
  bool isSort = true;

  List<BiSaleGroupDeptDo> deptData = [];

  //更新 销售
  updateDeptSale({bool wait = false}) async {
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
    if (wait) {
      biSalePageReq.toAllDept = true;
      await BiDeptApi.selectSaleGroupDept(biSalePageReq).then((v) {
        deptData = v;
      });
    } else {
      BiDeptApi.selectSaleGroupDept(biSalePageReq).then((v) {
        List<String> tags = [];
        deptData.forEach((e) {
          tags.add("sale" + e.deptId.toString());
          tags.add("shortage" + e.deptId.toString());
          v.forEach((element) {
            if (e.deptId == element.deptId) {
              e.orderSaleNum = element.orderSaleNum;
              e.normalSaleGoodsNum = element.normalSaleGoodsNum;
              e.normalSaleAmount = element.normalSaleAmount;
              e.normalSaleTaxAmount = element.normalSaleTaxAmount;
              e.returnGoodsNum = element.returnGoodsNum;
              e.returnAmount = element.returnAmount;
              e.changeBackOrderGoodsNum = element.changeBackOrderGoodsNum;
              e.changeBackOrderAmount = element.changeBackOrderAmount;
              e.saleGoodsNum = element.saleGoodsNum;
              e.saleAmount = element.saleAmount;
              e.saleTaxAmount = element.saleTaxAmount;
              e.shortageNum = element.shortageNum;
              e.shortageAmount = element.shortageAmount;
            }
          });
        });
        update(tags);
      });
    }
  }

  updateCustomer() async {
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
    biSalePageReq.type = SaleTypeEnum.NORMAL_SALE;
    BiDeptApi.selectSaleGroupDept(biSalePageReq).then((v) {
      List<String> tags = [];
      deptData.forEach((e) {
        tags.add("member" + e.deptId.toString());
        v.forEach((element) {
          if (e.deptId == element.deptId) {
            e.orderSaleNum = element.orderSaleNum;
            e.merchandiserNum = element.merchandiserNum;
          }
        });
      });
      update(tags);
    });
  }

  //更新库存
  updateStock() {
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    if(deptId!=null){
      biSalePageReq.filterMerchandiser = true;
    }

    BiDeptApi.selectStockGroupDept(biSalePageReq).then((v) {
      List<String> tags = [];

      deptData.forEach((e) {
        tags.add("stock" + e.deptId.toString());
        v.forEach((element) {
          if (e.deptId == element.deptId) {
            e.stockNum = element.stockNum;
            e.substandardNum = element.substandardNum;
          }
        });
      });
      update(tags);
    });
  }

  //更新上新
  updateNew() {
    BiSalePageReq biSalePageReq = new BiSalePageReq();
    biSalePageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biSalePageReq.customerDeptIds = customerDeptIds;
    }
    biSalePageReq.onSaleEndTime = statisticEndTime; //默认结束时间
    biSalePageReq.onSaleStartTime = statisticStartTime;
    if(deptId!=null){
      biSalePageReq.filterMerchandiser = true;
    }

    BiDeptApi.selectGoodsNewSaleNumGroupDept(biSalePageReq).then((v) {
      List<String> tags = [];

      deptData.forEach((e) {
        tags.add("new" + e.deptId.toString());
        v.forEach((element) {
          if (e.deptId == element.deptId) {
            e.newSaleNum = element.newSaleNum;
          }
        });
      });
      update(tags);
    });
  }

  //更新收退款
  updateRemit({bool wait = false}) async {
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
    if (wait) {
      biSalePageReq.toAllDept = true;
      await BiDeptApi.selectRemitGroupDept(biSalePageReq).then((v) {
        deptData = v;
      });
    } else {
      BiDeptApi.selectRemitGroupDept(biSalePageReq).then((v) {
        List<String> tags = [];

        deptData.forEach((e) {
          tags.add("remit" + e.deptId.toString());
          v.forEach((element) {
            if (e.deptId == element.deptId) {
              e.refundAmount = element.refundAmount;
              e.receivedAmount = element.receivedAmount;
            }
          });
        });
        update(tags);
      });
    }
  }

  //更新单据结欠和余额
  updateOrderOweAndBalance({bool wait = false}) async {
    BiCustomerPageReq biCustomerPageReq = new BiCustomerPageReq();
    biCustomerPageReq.topDeptId = topDeptId;
    if (customerDeptIds.length != 0) {
      biCustomerPageReq.customerDeptIds = customerDeptIds;
    }
    if(deptId!=null){
      biCustomerPageReq.filterMerchandiser = true;
    }
    if (wait) {
      biCustomerPageReq.toAllDept = true;
      await BiDeptApi.selectCustomerGroupDept(biCustomerPageReq).then((v) {
        deptData = v;
      });
    } else {
      BiDeptApi.selectCustomerGroupDept(biCustomerPageReq).then((v) {
        List<String> tags = [];

        deptData.forEach((e) {
          tags.add("customer" + e.deptId.toString());
          v.forEach((element) {
            if (e.deptId == element.deptId) {
              e.balance = element.balance;
              e.orderOweAmount = element.orderOweAmount;
              e.oweAmount = element.oweAmount;
            }
          });
        });
        update(tags);
      });
    }
  }

  init() async {
    if (orderByField == "saleTaxAmount" || orderByField == "shortageNum") {
      //这时候要先完成销单的请求
      await updateDeptSale(wait: true);
      updateStock();
      updateNew();
      updateRemit();
      updateOrderOweAndBalance();
      updateCustomer();
    }
    if (orderByField == "oweAmount") {
      await updateOrderOweAndBalance(wait: true);
      updateStock();
      updateNew();
      updateRemit();
      updateDeptSale();
      updateCustomer();
    }
    if (orderByField == "receivedAmount") {
      await updateRemit(wait: true);
      updateStock();
      updateNew();
      updateOrderOweAndBalance();
      updateDeptSale();
      updateCustomer();
    }
    sort();
  }

  sort() {
    if (orderByField == "saleTaxAmount") {
      if (orderBy == "ASC") {
        deptData.sort((a, b) => a.saleTaxAmount.compareTo(b.saleTaxAmount));
      } else {
        deptData.sort((a, b) => b.saleTaxAmount.compareTo(a.saleTaxAmount));
      }
    }
    if (orderByField == "oweAmount") {
      if (orderBy == "ASC") {
        deptData.sort((a, b) => a.oweAmount.compareTo(b.oweAmount));
      } else {
        deptData.sort((a, b) => b.oweAmount.compareTo(a.oweAmount));
      }
    }
    if (orderByField == "shortageNum") {
      if (orderBy == "ASC") {
        deptData.sort((a, b) => a.shortageNum.compareTo(b.shortageNum));
      } else {
        deptData.sort((a, b) => b.shortageNum.compareTo(a.shortageNum));
      }
    }
    if (orderByField == "receivedAmount") {
      if (orderBy == "ASC") {
        deptData.sort((a, b) => a.receivedAmount.compareTo(b.receivedAmount));
      } else {
        deptData.sort((a, b) => b.receivedAmount.compareTo(a.receivedAmount));
      }
    }
    update(["deptDetailList"]);
  }

  @override
  void onInit() {
    super.onInit();
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
