import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/bindings/bi_customer_bindings.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/view/bi_customer.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/bingdings/bi_dept_user_binding.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/views/bi_dept_user_view.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/bindings/bi_goods_bindings.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/view/bi_goods.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/bindings/bi_remit_binding.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/views/bi_remit_one_dept_view.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/views/bi_remit_view.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit_record/bindings/bi_remit_record_binding.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit_record/views/bi_remit_record_view.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/bindings/bi_sale_binding.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/views/bi_sale_one_dept_view.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/views/bi_sale_view.dart';
import 'package:haidai_flutter_module/page/bi/bi_sku/bindings/sku_binding.dart';
import 'package:haidai_flutter_module/page/bi/bi_sku/views/sku_view.dart';
import 'package:haidai_flutter_module/page/bi/customer_profile/bindinds/customer_profile_binding.dart';
import 'package:haidai_flutter_module/page/bi/customer_profile/views/customer_profile_view.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/bindinds/dept_user_profile_binding.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/views/dept_user_profile_view.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/bindinds/goods_profile_binding.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/views/goods_profile_view.dart';

import '../app_pages.dart';

class BiPages {
  static final pages = [
    //销售报表
    GetPage(
      name: Routes.BI_SALE,
      page: () => BiSaleView(),
      binding: BiSaleBinding(),
    ),
    GetPage(
      name: Routes.BI_DEPT_SALE,
      page: () => BiOneDeptSaleView(),
      binding: BiSaleBinding(),
    ),

    //收支
    GetPage(
      name: Routes.BI_REMIT,
      page: () => BiRemitView(),
      binding: BiRemitBinding(),
    ),
    GetPage(
      name: Routes.BI_DEPT_REMIT,
      page: () => BiOneDeptRemitView(),
      binding: BiRemitBinding(),
    ),
    GetPage(
      name: Routes.BI_REMIT_RECORD,
      page: () => BiRemitRecordView(),
      binding: BiRemitRecordBinding(),
    ),
    GetPage(
      name: Routes.BI_CUSTOMER,
      page: () => BiCustomer(),
      binding: BiCustomerBindings(),
    ),

    //员工
    GetPage(
      name: Routes.BI_DEPT_USER,
      page: () => BiDeptUserView(),
      binding: BiDeptUserBinding(),
    ),
    //员工画像
    GetPage(
      name: Routes.DEPT_USER_PROFILE,
      page: () => DeptUserProfileView(),
      binding: DeptUserProfileBinding(),
    ),
    //货品报表
    GetPage(
      name: Routes.BI_GOODS,
      page: () => BiGoods(),
      binding: BiGoodsBindings(),
    ),
    //货品画像
    GetPage(
      name: Routes.GOODS_PROFILE,
      page: () => GoodsProfileView(),
      binding: GoodsProfileBinding(),
    ),

    GetPage(
      name: Routes.CUSTOMER_PROFILE,
      page: () => CustomerProfileView(),
      binding: CustomerProfileBinding(),
    ),

    //sku明细
    GetPage(
      name: Routes.BI_SKU,
      page: () => SkuView(),
      binding: SkuBinding(),
    ),
  ];
}
