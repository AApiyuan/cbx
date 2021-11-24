import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'refund_method_logic.dart';

class RefundMethodPage extends StatefulWidget {
  @override
  _RefundMethodPageState createState() => _RefundMethodPageState();
}

class _RefundMethodPageState extends State<RefundMethodPage> {
  final logic = Get.find<RefundMethodLogic>();

  List list = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  List<String> items = List.generate(20, (int i) => '$i');

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(ColorConfig.color_f5f5f5),
          appBar: pAppBar("收款方式", backFunc: () {
            BackUtils.back();
          }),
          body: GetBuilder<RefundMethodLogic>(builder: (ctl){
            return Column(
              children: [
                Container(
                  color: Colors.red,
                  height: 100.w,
                  child: Column(
                    children: [
                      pText("同一店铺下所有员工共用", ColorConfig.color_333333, 33.w),
                      Row(
                        children: [
                          pText("可根据需求拖动调序", ColorConfig.color_333333, 33.w),
                          pText("长按拖动", ColorConfig.color_333333, 33.w),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ReorderableListView(
                    children: <Widget>[
                      for (String item in items)
                        Container(
                          key: ValueKey(item),
                          height: 100.w,
                          // margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          // decoration: BoxDecoration(
                          //     color: Colors
                          //         .primaries[int.parse(item) % Colors.primaries.length],
                          //     borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: pText("${item.toString()}",
                                ColorConfig.color_333333, 22.w,
                                textAlign: TextAlign.left),
                            trailing: Icon(Icons.menu),
                          ),
                          color: Colors.white,
                        )
                    ],
                    onReorder: (int oldIndex, int newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      var child = items.removeAt(oldIndex);
                      items.insert(newIndex, child);
                      setState(() {});
                    },
                  ),
                )
              ],
            );
          } ,)),
    );
  }

  _onReorder(int oldIndex, int newIndex) {
    print('oldIndex: $oldIndex , newIndex: $newIndex');
    setState(() {
      if (newIndex == list.length) {
        newIndex = list.length - 1;
      }
      var item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }

  @override
  void dispose() {
    Get.delete<RefundMethodLogic>();
    super.dispose();
  }
}
