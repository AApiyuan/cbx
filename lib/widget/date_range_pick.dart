import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'date_pick.dart';

class DateRangePick extends StatefulWidget {
  final Function onCertain;
  final int color;
  final int size;
  final int defaultRange; //初始化默认天数

  DateRangePick({Key? key, required this.onCertain, this.color = ColorConfig.color_1678ff, this.size = 24, this.defaultRange = 1});

  @override
  State<StatefulWidget> createState() {
    return _DateRangePickState();
  }
}

class _DateRangePickState extends State<DateRangePick> {
  String time = "";

  @override
  void initState() {
    super.initState();
    String start = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(widget.defaultRange), format: "MM.dd");
    String end = TimeUtils.getEndOfDay(DateTime.now(), format: "MM.dd");
    time = start + "-" + end;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: pText(time, widget.color, widget.size.w),
      onTap: () => showCupertinoModalBottomSheet(
        context: Get.context!,
        animationCurve: Curves.easeIn,
        builder: (context) => DatePick(
          onCertain: (String start, String end) {
            setState(() {
              if (start == "全部") {
                time = "全部";
              } else {
                time = start.substring(5, 10).replaceRange(2, 3, '.') + "-" + end.substring(5, 10).replaceRange(2, 3, '.');
              }
            });
            widget.onCertain.call(start, end);
          },
          selectionMode: DateRangePickerSelectionMode.range,
        ),
      ),
    );
  }
}
