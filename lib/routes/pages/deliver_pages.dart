
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/direct_deliver/bindings/direct_deliver_bindings.dart';
import 'package:haidai_flutter_module/page/direct_deliver/view/direct_deliver_view.dart';

import '../app_pages.dart';

class DeliverPages {
  static final pages = [
    //直接发货
    GetPage(
      name: Routes.DELIVER_DIRECT,
      page: () => DirectDeliverView(),
      binding: DirectDeliverBindings(),
    ),
  ];
}