import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/experience/bindings/experience_binding.dart';
import 'package:haidai_flutter_module/page/experience/view/experience_view.dart';
import 'package:haidai_flutter_module/page/exposure/bindings/exposure_binding.dart';
import 'package:haidai_flutter_module/page/exposure/view/exposure_view.dart';
import 'package:haidai_flutter_module/page/exposure_record/bindings/exposure_record_binding.dart';
import 'package:haidai_flutter_module/page/exposure_record/view/exposure_record_view.dart';
import 'package:haidai_flutter_module/page/nav/nav_page.dart';
import 'package:haidai_flutter_module/page/nav/simple_page.dart';
import 'package:haidai_flutter_module/page/offline_enter/bindings/offline_enter_binding.dart';
import 'package:haidai_flutter_module/page/offline_enter/view/offline_enter_view.dart';
import 'package:haidai_flutter_module/page/splash/presentation/bindings/splash_binding.dart';
import 'package:haidai_flutter_module/page/splash/presentation/view/splash_view.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

class CommonPages {
  static final pages = [
    /// 闪屏
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      transition: Transition.noTransition,
      binding: SplashBinding(),
    ),
    ///离线落地页
    GetPage(
      name: Routes.OFFLINEENTER,
      page: () => OfflineEnterView(),
      transition: Transition.noTransition,
      binding: OfflineEnterBinding(),
    ),

    GetPage(
      name: Routes.HOME,
      transition: Transition.fade,
      page: () => Container(
        color: Colors.white,
      ),
    ),
    GetPage(
      name: Routes.NAV,
      page: () => NavPage(),
    ),
    GetPage(
      name: Routes.NAV_SIMPLE,
      page: () => NavSimplePage(),
    ),

    GetPage(
      name: Routes.EXPERIENCE,
      page: () => ExperienceView(),
      binding: ExperienceBinding(),
    ),

    GetPage(
      name: Routes.EXPOSURE,
      page: () => ExposureView(),
      binding: ExposureBinding(),
    ),

    GetPage(
      name: Routes.EXPOSURERECORD,
      page: () => ExposureRecordView(),
      binding: ExposureRecordBinding(),
    ),
  ];

}