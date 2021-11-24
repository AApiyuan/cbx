import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PubScaffold extends StatefulWidget {
  final Widget child;

  PubScaffold({required this.child});

  @override
  _PubScaffoldState createState() => _PubScaffoldState();
}

class _PubScaffoldState extends State<PubScaffold> {
  bool draggable = false;

  //静止状态下的offset
  Offset idleOffset = Offset(0, 0);

  //本次移动的offset
  Offset moveOffset = Offset(0, 0);

  //最后一次down事件的offset
  Offset lastStartOffset = Offset(0, 0);

  int count = 0;

  final List<String> testWidgetList = [
    '测试1',
    '测试2',
  ];

  testAppFun(e) {
    // TODO: 你的代码逻辑
  }

  // 显示一个底部弹窗，这里是一个测试列表
  showTestList() {
    showCupertinoModalBottomSheet(
        context: Get.context!,
        builder: (BuildContext context) {
        return ListView(
          children: testWidgetList
              .map(
                (e) => Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFe3e3e3)),
                    ),
                  ),
                  child: ListTile(
                    onTap: () => testAppFun(e),
                    title: Text(e),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 显示悬浮按钮
        WidgetsBinding.instance!.addPostFrameCallback((_) => _insertOverlay(context));
        return widget.child;
      },
    );
  }

  // 悬浮按钮，可以拖拽（可自定义样式）
  void _insertOverlay(BuildContext context) {
    return Overlay.of(context)!.insert(
      OverlayEntry(builder: (context) {
        final size = MediaQuery.of(context).size;
        print(size.width);
        return Positioned(
          top: draggable ? moveOffset.dy : size.height - 102,
          left: draggable ? moveOffset.dx : size.width - 72,
          child: GestureDetector(
            // 移动开始
            onPanStart: (DragStartDetails details) {
              setState(() {
                lastStartOffset = details.globalPosition;
                draggable = true;
              });
              if (count <= 1) {
                count++;
              }
            },
            // 移动中
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                moveOffset = details.globalPosition - lastStartOffset + idleOffset;
                if (count > 1) {
                  moveOffset = Offset(max(0, moveOffset.dx), moveOffset.dy);
                } else {
                  moveOffset = Offset(max(0, moveOffset.dx + (size.width - 72)), moveOffset.dy + (size.height - 102));
                }
              });
            },
            // 移动结束
            onPanEnd: (DragEndDetails detail) {
              setState(() {
                idleOffset = moveOffset * 1;
              });
            },
            child: TestContainer(onPress: () {showTestList();}),
          ),
        );
      }),
    );
  }
}

// 悬浮按钮的样式
class TestContainer extends StatelessWidget {
  final Function onPress;

  TestContainer({required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          onPress();
        },
        child: Container(
          width: 56.w,
          height: 56.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green[600],
          ),
          child: Text(
            "开单",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
