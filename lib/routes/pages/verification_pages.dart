import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:haidai_flutter_module/page/gathering_detail/bindings/gathering_detail_bindings.dart';
import 'package:haidai_flutter_module/page/gathering_detail/view/gathering_detail.dart';
import 'package:haidai_flutter_module/page/verification/refund_method/refund_method_binding.dart';
import 'package:haidai_flutter_module/page/verification/refund_method/refund_method_view.dart';
import 'package:haidai_flutter_module/page/verification/verification_binding.dart';
import 'package:haidai_flutter_module/page/verification/verification_mode/verification_mode_binding.dart';
import 'package:haidai_flutter_module/page/verification/verification_mode/verification_mode_view.dart';
import 'package:haidai_flutter_module/page/verification/verification_view.dart';

import '../app_pages.dart';

class VerificationPages {
  static final pages = [
    // 核销
    GetPage(
      name: Routes.VERIFICATION,
      page: () => VerificationPage(),
      binding: VerificationBinding(),
    ),

    // 收退款方式
    GetPage(
      name: Routes.REFUND_METHOD,
      page: () => RefundMethodPage(),
      binding: RefundMethodBinding(),
    ),

    // 收退款单
    GetPage(
      name: Routes.GATHERING_DETAIL,
      page: () => GatheringDetail(),
      binding: GatheringDetailBindings(),
    ),

    // 核销模式
    GetPage(
      name: Routes.VERIFICATION_MODE,
      page: () => VerificationModePage(),
      binding: VerificationModeBinding(),
    ),

  ];
}
