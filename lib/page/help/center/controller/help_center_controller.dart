import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_detail_do.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_do.dart';
import 'package:haidai_flutter_module/page/help/model/res/admin_video_do.dart';
import 'package:haidai_flutter_module/repository/base/customer_dept_api.dart';
import 'package:haidai_flutter_module/repository/base/store.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';

class HelpCenterController extends SuperController {
  List<AdminVideoDo> videos = [];
  var deptId;
  String deptName = "";
  CustomerDeptDetailDo? deptDetail;
  CustomerDeptDo? loginDeptDetail;
  String? memberTime;
  bool base = false;
  bool staff = false;
  bool offline = false;
  bool bi = false;
  bool bad = false;
  bool transfer = false;
  bool data = false;
  bool customer = false;

  getVideos() {
    UserApi.selectVideo().then((value) {
      videos = value;
      update(["video"]);
    });
  }

  getProduct() {
    StoreApi.selectDeptDetail(deptId).then((value) {
      deptDetail = value;
      if (deptDetail!.baseExpiryDate != null) {
        int time =
            TimeUtils.during(deptDetail!.baseExpiryDate!, TimeUtils.getNow());
        deptDetail!.baseExpiryDate = "已激活(剩${time < 0 ? 0 : time}天)";
        base = true;
      } else {
        deptDetail!.baseExpiryDate = "开单、库存发货";
      }
      if (deptDetail!.offlineExpiryDate != null) {
        int time = TimeUtils.during(
            deptDetail!.offlineExpiryDate!, TimeUtils.getNow());
        deptDetail!.offlineExpiryDate = "已激活(剩${time < 0 ? 0 : time}天)";
        offline = true;
      } else {
        deptDetail!.offlineExpiryDate = "断网不错失客户";
      }
      if (deptDetail!.appBiExpiryDate != null) {
        int time =
            TimeUtils.during(deptDetail!.appBiExpiryDate!, TimeUtils.getNow());
        deptDetail!.appBiExpiryDate = "已激活(剩${time < 0 ? 0 : time}天)";
        bi = true;
      } else {
        deptDetail!.appBiExpiryDate = "分析画像一应俱全";
      }
      if (deptDetail!.substandardStockExpiryDate != null) {
        int time = TimeUtils.during(
            deptDetail!.substandardStockExpiryDate!, TimeUtils.getNow());
        deptDetail!.substandardStockExpiryDate =
            "已激活(剩${time < 0 ? 0 : time}天)";
        bad = true;
      } else {
        deptDetail!.substandardStockExpiryDate = "次品数量精准管理";
      }
      if (deptDetail!.transferExpiryDate != null) {
        int time = TimeUtils.during(
            deptDetail!.transferExpiryDate!, TimeUtils.getNow());
        deptDetail!.transferExpiryDate = "已激活(剩${time < 0 ? 0 : time}天)";
        transfer = true;
      } else {
        deptDetail!.transferExpiryDate = "多店调配效率翻倍";
      }
      if (deptDetail!.dataBackgroundExpiryDate != null) {
        int time = TimeUtils.during(
            deptDetail!.dataBackgroundExpiryDate!, TimeUtils.getNow());
        deptDetail!.dataBackgroundExpiryDate = "已激活(剩${time < 0 ? 0 : time}天)";
        data = true;
      } else {
        deptDetail!.dataBackgroundExpiryDate = "店铺智能数据中心";
      }
      if (deptDetail!.customerQuotationExpiryDate != null) {
        int time = TimeUtils.during(
            deptDetail!.customerQuotationExpiryDate!, TimeUtils.getNow());
        deptDetail!.customerQuotationExpiryDate =
            "已激活(剩${time < 0 ? 0 : time}天)";
        customer = true;
      } else {
        deptDetail!.customerQuotationExpiryDate = "自动生成效率200";
      }
      update(['product', 'title']);
    });
    StoreApi.selectCompanyByLoginCustomerUser().then((value) {
      loginDeptDetail = value;
      if (loginDeptDetail!.createdTime != null) {
        memberTime = "已激活(员工${loginDeptDetail!.customerNum!}人)";
        staff = true;
      } else {
        memberTime = "最大支持100人";
      }
      update(['product']);
    });
  }

  getDeptDetail() {
    CustomerDeptApi.selectCustomerDeptByDeptId(deptId).then((v) {
      deptName = v.name as String;
      update(['title']);
    });
  }

  init() {
    getVideos();
    if (deptId != null) {
      getProduct();
      getDeptDetail();
    }
  }

  @override
  void onInit() {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();

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
