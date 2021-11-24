import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/transfer/center/controller/transfer_center_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/distribution_salegroup_entity.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';

class TransferDistributionController extends SuperController {
  var deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();
  var data = [];
  var pageNo = 1; //页码
  var pageSize = 60; //页数
  var count = 0; //页数
  var notPrint = true; //页数
  //title
  var barTitle = "调拨中心";

  // 他店选择的id
  List<DistributionSalegroupEntity> shopData = [];
  String? selectedShopId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadListData();
  }

  Future<List<DistributionSalegroupEntity>> loadShopData() {
    BasePage basePage = new BasePage();
    var param = {'customerDeptId':deptId,
      'type':'WAREHOUSE',};
    basePage.param = param;
    return TransferApi.getDistributionShopList(basePage);
  }

  void loadListCountData() {
    BasePage basePage = new BasePage();
    var param = {'customerDeptId':deptId,
      'type':'WAREHOUSE',
      'saleCustomerDeptId':selectedShopId,
      'notPrint':notPrint};
    basePage.param = param;
    TransferApi.getDistributionOrderListCount(basePage).then((entity) {
      count = int.parse(entity);
      pageNo = 1;
      loadListData();
      update(["transferListSwitch"]);
      update(["TransferDistribution"]);
    });
  }

  void loadListData() {
    loadListCountData();
    BasePage basePage = new BasePage();
    basePage.pageSize = pageSize;
    basePage.pageNo = pageNo;
    var param = {'customerDeptId':deptId,
      'saleCustomerDeptId':selectedShopId,
      'type':'WAREHOUSE',
      'notPrint':notPrint };
    basePage.param = param;
    TransferApi.getDistributionOrderList(basePage).then((entity) {

      if(pageNo == 1){
        data = entity;
      }else{
        data.addAll(entity);
      }
      count = data.length;
      update(["TransferDistribution",]);
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
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

  init() {

  }
}