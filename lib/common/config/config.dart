import 'dart:io';

class Config {
  //默认分页
  static const int PAGE_SIZE = 20;

  // static const isRelease = bool.fromEnvironment("dart.vm.product", defaultValue: false);
  // static const isProfile = bool.fromEnvironment("dart.vm.profile", defaultValue: false);
  static bool isDebug = false;

  static bool isIOS = Platform.isIOS;
  static bool isAndroid = Platform.isAndroid;

  static int? userId;

  /// //////////////////////////////////////常量/////////////////////////////////////////
  static String GOODS_API_URL = isDebug ? "http://kelp-customer-goods-test.piyuan.cn/" : "https://customer-goods.piyuan.cn/";
  static String ORDER_API_URL = isDebug ? "http://kelp-customer-order-test.piyuan.cn/" : "https://customer-order.piyuan.cn/";
  static String BASE_API_URL = isDebug ? "http://kelp-customer-base-test.piyuan.cn/" : "https://customer-base.piyuan.cn/";
  static String BI_API_URL = isDebug ? "http://kelp-customer-bi-test.piyuan.cn/" : "https://customer-bi.piyuan.cn/";


  static const String CDN = "https://kelp-test-oss.piyuan.cn/";

  static String WEB_URL = isDebug ? "https://test.piyuan.cn/" : "https://www.piyuan.cn/";

  static bool isWebViewFirst = true;//判断是否第一次加载webView


}