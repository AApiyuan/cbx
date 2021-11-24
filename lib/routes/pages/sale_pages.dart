import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/delivery_detail/bindings/delivery_detail_binding.dart';
import 'package:haidai_flutter_module/page/delivery_detail/view/delivery_detail.dart';
import 'package:haidai_flutter_module/page/remit/binding/remit_binding.dart';
import 'package:haidai_flutter_module/page/remit/binding/remit_method_sort_binding.dart';
import 'package:haidai_flutter_module/page/remit/view/remit_method_sort.dart';
import 'package:haidai_flutter_module/page/remit/view/remit_view.dart';
import 'package:haidai_flutter_module/page/sale/bindings/offline_gathering_bindings.dart';
import 'package:haidai_flutter_module/page/sale/bindings/sale_enter_binding.dart';
import 'package:haidai_flutter_module/page/sale/view/offline_gathering_view.dart';
import 'package:haidai_flutter_module/page/sale/view/sale_enter_view.dart';
import 'package:haidai_flutter_module/page/sale_detail/bindings/sail_detail_binding.dart';
import 'package:haidai_flutter_module/page/sale_detail/bindings/sail_share_binding.dart';
import 'package:haidai_flutter_module/page/sale_detail/view/sale_detail.dart';
import 'package:haidai_flutter_module/page/sale_detail/view/sale_share.dart';
import 'package:haidai_flutter_module/page/sale_operation/bindings/sale_operation_binding.dart';
import 'package:haidai_flutter_module/page/sale_operation/view/sale_operaton_view.dart';

import '../app_pages.dart';

class SalePages {
  static final pages = [
    GetPage(
      name: Routes.SALE_ENTER,
      page: () => SaleEnterView(),
      binding: SaleEnterBinding(),
    ),
    GetPage(
      name: Routes.OFFLINE_GATHERING,
      page: () => OfflineGatheringVIew(),
      binding: OfflineGatheringBindings(),
    ),
    GetPage(
      name: Routes.SALE_DETAIL,
      page: () => SaleDetail(),
      binding: SaleDetailBinding(),
    ),
    GetPage(
      name: Routes.SALE_SHARE,
      page: () => SaleShare(),
      binding: SaleShareBinding(),
    ),

    GetPage(
      name: Routes.SALE_OPERATION,
      page: () => SaleOperationView(),
      binding: SaleOperationBinding(),
    ),
    GetPage(
      name: Routes.SALE_REMIT,
      page: () => Remit(),
      binding: RemitBinding(),
    ),
    GetPage(
      name: Routes.REMIT_SORT,
      page: () => RemitMethodSort(),
      binding: RemitMethodSortBinding(),
    ),
    GetPage(
      name: Routes.DELIVERY_DETAIL,
      page: () => DeliveryDetail(),
      binding: DeliveryDetailBinding(),
    ),
  ];
}
