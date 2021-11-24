import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkCenterEmpty.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkCenterIng.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkDetailsMain.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkHistory.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/storeAdjustment.dart';
import 'package:haidai_flutter_module/page/inventory/difference/ui/difference_page.dart';
import 'package:haidai_flutter_module/page/inventory/enter/enter_inventory_page.dart';
import 'package:haidai_flutter_module/page/inventory/enternew/controller/inventoryentry_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

abstract class InventoryPages {
  static final pages = [

    GetPage(
      name: Routes.DIFFERENCE,
      page: () => DifferencePage(),
    ),
    GetPage(
      name: Routes.ENTER,
      page: () => EnterInventoryPage(),
    ),
    GetPage(
      name: Routes.CHECKEMPTY,
      page: () => CheckCenterEmpty(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.CHECKING,
      page: () => CheckCenterIng(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.CHECKHIS,
      page: () => CheckHistory(),
    ),
    GetPage(
      name: Routes.CHECK_LIST,
      page: () => CheckDetailsMain(),
    ),
    GetPage(
      name: Routes.CHECK_ADJUST,
      page: () => StoreAdjustMent(),
    ),


  ];
}