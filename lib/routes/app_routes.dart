part of './app_pages.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const SPLASH = '/splash';
  static const OFFLINEENTER = '/offline-enter';
  static const HOME = '/home';
  static const NAV = '/nav';
  static const NAV_SIMPLE = '/nav-simple';
  static const GOODS = '/goods';
  static const EXPERIENCE = '/experience';
  static const EXPOSURE = '/exposure';
  static const EXPOSURERECORD = '/exposure-record';


  //盘点
  static const DIFFERENCE = '/difference';
  static const ENTER = '/enter';
  static const ENTERNEW = '/enternew';
  static const CHECKEMPTY = '/check';
  static const CHECKHIS = '/check_his';
  static const CHECKING = '/checking';
  static const CHECK_LIST = '/check_list';
  static const CHECK_ADJUST = '/check_Adjust';
  static const VIEW_IMAGE = "/view_image";

  //货品
  static const GOODS_LIST = "/goods_list";

  //客户
  static const SEARCH_CUSTOMER = "/search_customer"; //搜索客户
  static const ADD_CUSTOMER = "/add_customer"; //添加客户

  //库存
  static const STOCK = "/stock";
  static const STOCK_DETAIL = "/stock/detail";
  static const STOCK_SELECT = "/stock/select"; //选择库存单
  static const TRANSFER = '/transfer'; //调拨
  static const TRANSFER_OPERATION = '/transfer/operation'; //调拨记录
  static const TRANSFER_DETAIL = '/transfer/detail'; //调拨
  static const TRANSFER_CENTER = '/transfer/center'; //调拨
  static const TRANSFER_CENTERSELECTGOOD = '/transfer/center/selectgood'; //调拨选选择商品
  static const TRANSFER_DISTRIBUTION = '/transfer/distribution'; //调拨
  static const TRANSFER_DISTRIBUTION_RECORD = '/transfer/distribution/record';
  static const TRANSFER_DISTRIBUTION_SELECTSHOP = '/transfer/distribution/selectshop';

  static const DISTRIBUTION = '/distribution'; //配货调拨

  //销售单
  static const SALE_ENTER = "/sale_enter"; //录入货品
  static const OFFLINE_GATHERING = "/offline_gathering"; //离线收款
  static const SALE_DETAIL = "/sale/detail"; //销售单 详情
  static const SALE_SHARE = "/sale/share"; //销售单 分享
  static const SALE_OPERATION = "/sale/operation"; //销售单操作记录

  //挂单工作台
  static const HANG_ORDER_WORKBENCH = "/hang_order_workbench"; //挂单工作台

  //BI
  static const BI_SALE = "/bi/sale"; //多店铺销售汇总
  static const BI_DEPT_SALE = "/bi/dept/sale"; //单店铺销售
  static const BI_REMIT = "/bi/remit"; //收支
  static const BI_DEPT_REMIT = "/bi/dept/remit"; //单店铺收支
  static const BI_REMIT_RECORD = "/bi/remit/record"; //店铺收支记录列表
  static const BI_CUSTOMER = "/bi/customer"; //客户
  static const BI_GOODS = "/bi/goods"; //货品
  static const BI_DEPT_USER = "/bi/dept_user"; //员工
  static const DEPT_USER_PROFILE = "/bi/dept_user/profile"; //员工画像
  static const GOODS_PROFILE = "/bi/goods/profile"; //货品画像
  static const CUSTOMER_PROFILE = "/bi/customer/profile"; //客户画像
  static const BI_SKU = "/bi/sku"; //sku画像

  //发货
  static const DELIVER_DIRECT = "/deliver/direct";//直接发货

  //核销
  static const VERIFICATION = '/verification'; //核销
  static const REFUND_METHOD = '/refund_method'; // 收款方式
  static const GATHERING_DETAIL = '/gathering_detail'; // 收退款单
  static const VERIFICATION_MODE = '/verification_mode'; // 核销模式
  static const SELECT_SALES_SHEET = '/select_sales_sheet'; // 选择销售单

  static const SALE_REMIT = "/remit"; //收款
  static const REMIT_SORT = "/remit/method/sort"; //收款方式排序

  //帮助中西
  static const HELP = '/help/center';
  static const VIDEO = '/help/video';

  static const DELIVERY_DETAIL = "/delivery/detail"; //发货单 详情

}
