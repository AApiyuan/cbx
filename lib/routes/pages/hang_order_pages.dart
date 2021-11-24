import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:haidai_flutter_module/page/hang_order/bindings/hang_order_bindings.dart';
import 'package:haidai_flutter_module/page/hang_order/view/hang_order_view.dart';

import '../app_pages.dart';

class HangOrderPages {
  static final pages = [
    GetPage(
      name: Routes.HANG_ORDER_WORKBENCH,
      page: () => HangOrderView(),
      transition: Transition.noTransition,
      binding: HangOrderBindings(),
    ),
  ];
}