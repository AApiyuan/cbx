import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MoreDialog extends StatelessWidget {
  Map<String, Function> content;
  OverlayEntry? entry;
  var top = 0.0.obs; //已坐标
  var left = 0.0.obs; //x坐标
  final triangleWidth = 32.w; //三角形的宽度
  var adapterFlag; //是否自适应
  var adapterWidth; //自适应宽度
  var adapterHeight; //自适应高度

  MoreDialog(this.content,
      {this.adapterFlag = false, this.adapterWidth, this.adapterHeight});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    var addLine = false;
    content.entries.forEach((element) {
      if (addLine) {
        widgets.add(line());
      }
      widgets.add(adapterFlag
          ? adapterItemWidget(element)
          : itemWidget(element));
      addLine = true;
    });
    return GestureDetector(
      onTap: () => dismiss(),
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => pSizeBoxH(top.value)),
            Obx(
              () => Container(
                child: pImage("images/black_triangle.png", triangleWidth, 16.w),
                margin: EdgeInsets.only(left: left.value),
              ),
            ),
            Container(
              height: 80.w,
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              decoration: ShapeDecoration(
                color: Color(ColorConfig.color_202020),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.w),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: widgets,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemWidget(MapEntry<String, Function> entry) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.w),
          decoration: new BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color.fromRGBO(255, 255, 255, 0.1),
                width: 2.w,
              ),
            ),
          ),
          child: pText(entry.key, ColorConfig.color_ffffff, 28.w),
        ),
        onTap: () {
          entry.value.call();
          dismiss();
        },
      ),
    );
  }

  void show(BuildContext context, GlobalKey key) {
    if (entry == null) {
      _initLocation(key);
      entry = OverlayEntry(builder: (context) => this);
      Overlay.of(context)?.insert(entry!);
    }
  }

  _initLocation(GlobalKey key) {
    var box = key.currentContext?.findRenderObject() as RenderBox?;
    var translation = box?.getTransformTo(null).getTranslation();
    top.value = (translation?.y ?? 0) + (box?.paintBounds.height ?? 0);
    left.value = (translation?.x ?? 0) +
        (box?.paintBounds.width ?? 0) / 2 -
        triangleWidth / 2;
  }

  void dismiss() {
    entry?.remove();
    entry = null;
  }

  Widget line() {
    return Container(
      width: 1.w,
      height: 80.w,
      color: Color(ColorConfig.color_635b57),
    );
  }

  adapterItemWidget(MapEntry<String, Function> entry) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: adapterWidth,
        height: adapterHeight,
        decoration: new BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Color.fromRGBO(255, 255, 255, 0.1),
              width: 2.w,
            ),
          ),
        ),
        child: pText(entry.key, ColorConfig.color_ffffff, 28.w),
      ),
      onTap: () {
        entry.value.call();
        dismiss();
      },
    );
  }
}
