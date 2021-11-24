import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/experience/bindings/experience_binding.dart';
import 'package:haidai_flutter_module/page/experience/view/experience_view.dart';
import 'package:haidai_flutter_module/page/help/center/bindings/help_center_bindings.dart';
import 'package:haidai_flutter_module/page/help/center/view/help_center_view.dart';
import 'package:haidai_flutter_module/page/help/video/bindings/video_bindings.dart';
import 'package:haidai_flutter_module/page/help/video/view/video_view.dart';
import 'package:haidai_flutter_module/page/nav/nav_page.dart';
import 'package:haidai_flutter_module/page/nav/simple_page.dart';
import 'package:haidai_flutter_module/page/splash/presentation/bindings/splash_binding.dart';
import 'package:haidai_flutter_module/page/splash/presentation/view/splash_view.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

class HelpPages {
  static final pages = [
    GetPage(
      name: Routes.HELP,
      page: () => HelpCenterView(),
      transition: Transition.fadeIn,
      binding: HelpCenterBindings(),
    ),

    GetPage(
      name: Routes.VIDEO,
      transition: Transition.fade,
        page: () => VideoView(),
      binding: VideoBindings(),
    ),
  ];

}