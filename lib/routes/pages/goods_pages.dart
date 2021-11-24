


import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/goods/bindings/goods_list_binding.dart';
import 'package:haidai_flutter_module/page/goods/view/goods_list_view.dart';

import '../app_pages.dart';

class GoodsPages {
  static final pages = [
    /// 闪屏
    GetPage(
      name: Routes.GOODS_LIST,
      transition: Transition.fadeIn,
      page: () => GoodsListView(),
      binding: GoodsListBinding(),
    ),
  ];
}