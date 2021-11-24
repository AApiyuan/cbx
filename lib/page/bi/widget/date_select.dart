import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/date_pick.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateSelect extends StatefulWidget {
  Function callback;
  String? startTime;
  String? endTime;

  DateSelect({Key? key, required this.callback, this.startTime, this.endTime}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BiSaleViewState();
}

class _BiSaleViewState extends State<DateSelect> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> tabs = ["今日", "昨天", "7日", "30日", "自定义"];
  String dateStr = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    if (widget.startTime != null && widget.endTime != null) {
      if (widget.endTime == TimeUtils.getEndOfDay(DateTime.now()) &&
          widget.startTime == TimeUtils.getStartOfDay(DateTime.now())) {
        //今天
        _tabController.index = 0;
      } else if (widget.startTime == TimeUtils.getStartOfDay(TimeUtils.getDateBefore(1)) &&
          widget.endTime == TimeUtils.getStartOfDay(DateTime.now())) {
        //昨天
        _tabController.index = 1;
      } else if (widget.startTime == TimeUtils.getStartOfDay(TimeUtils.getDateBefore(7)) &&
          widget.endTime == TimeUtils.getEndOfDay(DateTime.now())) {
        //七日
        _tabController.index = 2;
      } else if (widget.startTime == TimeUtils.getStartOfDay(TimeUtils.getDateBefore(30)) &&
          widget.endTime == TimeUtils.getEndOfDay(DateTime.now())) {
        //30日
        _tabController.index = 3;
      } else {
        _tabController.index = 4;

        dateStr = widget.startTime!.substring(5, 10).replaceRange(2, 3, '.') +
            "-" +
            widget.endTime!.substring(5, 10).replaceRange(2, 3, '.');
        tabs[4] = "";
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomerTab(
            tabs: tabs,
            height: 56.w,
            radius: 8.w,
            labelStyle: TextStyle(
              fontSize: 26.w,
            ),
            labelColor: ColorConfig.color_ffffff,
            unselectedLabelStyle: TextStyle(fontSize: 26.w),
            contentBackgroundColor: Color.fromRGBO(57, 58, 88, 0.5),
            tabController: _tabController,
            change: (index) {
              if (index == 0) {
                //今天
                String statisticEndTime = TimeUtils.getEndOfDay(DateTime.now());
                String statisticStartTime = TimeUtils.getStartOfDay(DateTime.now());
                widget.callback(statisticStartTime, statisticEndTime);
              }
              if (index == 1) {
                //昨天
                String statisticEndTime = TimeUtils.getStartOfDay(DateTime.now());
                String statisticStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(1));
                widget.callback(statisticStartTime, statisticEndTime);
              }
              if (index == 2) {
                //七日
                String statisticEndTime = TimeUtils.getEndOfDay(DateTime.now());
                String statisticStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(7));
                widget.callback(statisticStartTime, statisticEndTime);
              }
              if (index == 3) {
                //30日
                String statisticEndTime = TimeUtils.getEndOfDay(DateTime.now());
                String statisticStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(30));
                widget.callback(statisticStartTime, statisticEndTime);
              }
              if (index == 4) {
                showCupertinoModalBottomSheet(
                  context: Get.context!,
                  animationCurve: Curves.easeIn,
                  builder: (context) => DatePick(
                    onCertain: (String start, String end) {
                      String statisticEndTime = "";
                      String statisticStartTime = "";

                      if (start == "全部") {
                        statisticEndTime = TimeUtils.getEndOfDay(DateTime.now());
                        statisticStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(365 * 2));
                      } else {
                        statisticEndTime = end;
                        statisticStartTime = start;
                      }

                      setState(() {
                        if (start == "全部") {
                          dateStr = "全部";
                        } else {
                          dateStr = start.substring(5, 10).replaceRange(2, 3, '.') +
                              "-" +
                              end.substring(5, 10).replaceRange(2, 3, '.');
                        }
                        tabs[4] = "";
                      });

                      widget.callback(statisticStartTime, statisticEndTime);
                    },
                    selectionMode: DateRangePickerSelectionMode.range,
                  ),
                );
              }
            }),
        Positioned(
            right: 10.w,
            top: 0,
            child: IgnorePointer(
              child: pText(dateStr, ColorConfig.color_ffffff, 20.w,
                  height: 56.w,
                  width: 130.w,
                  alignment: Alignment.center, onTap: () {
                showCupertinoModalBottomSheet(
                  context: Get.context!,
                  animationCurve: Curves.easeIn,
                  builder: (context) => DatePick(
                    onCertain: (String start, String end) {
                      String statisticEndTime = "";
                      String statisticStartTime = "";

                      if (start == "全部") {
                        statisticEndTime = TimeUtils.getEndOfDay(DateTime.now());
                        statisticStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(365 * 2));
                      } else {
                        statisticEndTime = end;
                        statisticStartTime = start;
                      }

                      setState(() {
                        if (start == "全部") {
                          dateStr = "全部";
                        } else {
                          dateStr = start.substring(5, 10).replaceRange(2, 3, '.') +
                              "-" +
                              end.substring(5, 10).replaceRange(2, 3, '.');
                        }
                        tabs[4] = "";
                      });

                      widget.callback(statisticStartTime, statisticEndTime);
                    },
                    selectionMode: DateRangePickerSelectionMode.range,
                  ),
                );
              }),
            ))
      ],
    );
  }
}
