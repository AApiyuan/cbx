import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoadingDialog extends Dialog {
  final BuildContext context;

  LoadingDialog(
    this.context, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 200.w,
          height: 200.w,
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xFF40000000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.w),
                ),
              ),
            ),
            child: Center(
              child: SizedBox(
                width: 90.w,
                height: 90.w,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dismiss() {
    Navigator.pop(context);
  }
}

class LoadingUtil {

  static Map<String, BuildContext> _map = {};

  LoadingUtil._();

  static void show(String tag) {
    showDialog(
        context: Get.context!, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          _map[tag] = ctx;
          print("flutter_tag===========show=====${_map.containsKey(tag)}==============${_map[tag]}");
          return LoadingDialog(ctx);
        });
  }

  static void dismiss(String tag) {
    print("flutter_tag===========dismiss=====${_map.containsKey(tag)}==============${_map[tag]}");
    if (_map.containsKey(tag)) {
      var _context = _map[tag];
      if (_context != null) {
        Navigator.pop(_context);
        _context = null;
        _map.remove(tag);
      }

    }
  }
}
