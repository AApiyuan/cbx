import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/customer/bindings/add_customer_binding.dart';
import 'package:haidai_flutter_module/page/customer/bindings/search_customer_binding.dart';
import 'package:haidai_flutter_module/page/customer/view/add_customer_view.dart';
import 'package:haidai_flutter_module/page/customer/view/search_customer_view.dart';

import '../app_pages.dart';

class CustomerPages {
  static final pages = [
    GetPage(
      name: Routes.SEARCH_CUSTOMER,
      page: () => SearchCustomerView(),
      binding: SearchCustomerBinding(),
    ),
    GetPage(
      name: Routes.ADD_CUSTOMER,
      page: () => AddCustomerView(),
      binding: AddCustomerBinding(),
    ),
  ];
}