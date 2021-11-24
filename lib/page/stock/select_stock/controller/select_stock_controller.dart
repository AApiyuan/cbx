import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/customer/model/merchandiser_user_do_entity.dart';
import 'package:haidai_flutter_module/page/stock/model/req/stock_page_req.dart';
import 'package:haidai_flutter_module/repository/base/customer_user.dart';
import 'package:haidai_flutter_module/repository/order/stock_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

class SelectStockController extends SuperController {
  var deptId;
  Map<int, bool> selectedIds = new Map();
  var selectType;

  List data = [];

  //分页搜索
  var startTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(30));
  var endTime = TimeUtils.getEndOfDay(DateTime.now());
  Map<String, bool> selectedOrderType = new Map(); //选择的类型
  List<MerchandiserUserDoEntity> personListData = [];
  Map<String, bool> selectedStatus = new Map(); //状态选择

  var onlyOnJob = false.obs; //只看在职
  Map<int, bool> selectedMerchandisers = new Map();

  //跳转到单据详情
  toStockDetail(int id) {
    Map<String, dynamic> param = new Map();
    param[Constant.DEPT_ID] = deptId;
    param[Constant.ORDER_STOCK_ID] = id;
    Get.toNamed(ArgUtils.map2String(path: Routes.STOCK_DETAIL, arguments: param));
  }

  returnSelect() {
    List<int> ids = [];
    if (selectedIds.length != 0) {
      selectedIds.forEach((key, value) {
        ids.add(key);
      });
    }
    if (ids.length > 0) {
      Get.back(result: ids);
    } else {
      toastMsg("请选择单据");
      // Get.back();
    }
  }

  Future getStockList({int pageSize: 15, int pageNo: 1}) {
    BasePage basePage = new BasePage();
    basePage.pageSize = pageSize;
    basePage.pageNo = pageNo;

    var param = StockPageReq();
    param.deptId = deptId;

    //类型
    if (selectedOrderType.length == 0) {
      param.orderTypes = [
        OrderStockTypeEnum.DIRECT_IN,
        OrderStockTypeEnum.TRANSFER_IN,
        OrderStockTypeEnum.DISTRIBUTION_IN,
        OrderStockTypeEnum.BACK_IN,
        OrderStockTypeEnum.SUBSTANDARD_BACK,
        OrderStockTypeEnum.SUBSTANDARD_TRANSFER_IN
      ];
    } else {
      List<String> types = [];
      selectedOrderType.forEach((key, value) {
        types.add(key);
      });
      param.orderTypes = types;
    }
    //状态
    if (selectedStatus.length == 1) {
      List<String> status = [];
      selectedStatus.forEach((key, value) {
        status.add(key);
      });
      param.canceled = status[0];
    }
    //跟单人
    if (selectedMerchandisers.length > 0) {
      List<int> merchandisersIds = [];
      selectedMerchandisers.forEach((key, value) {
        merchandisersIds.add(key);
      });
      param.createdBys = merchandisersIds;
    }

    if (startTime != "全部") {
      param.startTime = startTime;
      param.endTime = endTime;
    }
    basePage.param = param;
    return StockApi.page(basePage);
  }

  Future getPersonListData() async {
    if (personListData.length == 0) {
      await CustomerUserApi.selectMerchandiserByCustomerDeptId(deptId).then((v) {
        personListData = v;
        update(['orderStatusSelect']);
      });
    }
    return true;
  }

  updatePersonListData() {
    if (onlyOnJob.value) {
    } else {}
    selectedMerchandisers.clear();
    update(['merchandiser']);
  }

  @override
  void onInit() async {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();
    selectedStatus[CanceledEnum.ENABLE] = true; //默认显示选中正常的
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
