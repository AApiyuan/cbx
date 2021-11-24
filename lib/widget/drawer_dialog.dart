import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

// ignore: must_be_immutable
class DrawerDialog extends StatelessWidget {
  Widget Function(DrawerDialog) builder;
  var _marginHeight = 0.0.obs;
  OverlayEntry? _entry;
  bool? autoDismiss;

  DrawerDialog(this.builder, {this.autoDismiss = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: _marginHeight.value,
          ),
          onTap: () {
            dismiss();
          },
        ),
        builder(this),
        Expanded(
          child: GestureDetector(
              child: Container(color: Color(ColorConfig.color_66000000)),
              onTap: () {
                if (autoDismiss!) {
                  dismiss();
                }
              }),
        ),
      ],
    );
  }

  show(BuildContext context, GlobalKey key) {
    if (_entry == null) {
      _initLocation(key);
      _entry = OverlayEntry(builder: (context) => this);
      Overlay.of(context)?.insert(_entry!);
    }
  }

  _initLocation(GlobalKey key) {
    var box = key.currentContext?.findRenderObject() as RenderBox?;
    var translation = box?.getTransformTo(null).getTranslation();
    _marginHeight.value = (translation?.y ?? 0) + (box?.paintBounds.height ?? 0);
  }

  dismiss() {
    _entry?.remove();
    _entry = null;
  }
}
