import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePick extends StatefulWidget {
  final Function onCertain;
  final DateTime? initialSelectedDate;
  final DateRangePickerSelectionMode? selectionMode;

  DatePick({Key? key, required this.onCertain, this.initialSelectedDate, this.selectionMode = DateRangePickerSelectionMode.single});

  @override
  State<StatefulWidget> createState() {
    return _DatePickState();
  }
}

class _DatePickState extends State<DatePick> {
  DateTime selectTime = DateTime.now();
  String start = "";
  String end = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
        title: "选择",
        height: widget.selectionMode == DateRangePickerSelectionMode.range ? 1150.w : 1000.w,
        child: Container(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.w),
          child: Column(
            children: [
              Visibility(visible: widget.selectionMode == DateRangePickerSelectionMode.range, child: operation()),
              Expanded(
                  child: SfDateRangePicker(
                selectionMode: widget.selectionMode ?? DateRangePickerSelectionMode.single,
                headerHeight: 100.w,
                maxDate: DateTime.now(),
                viewSpacing: 100.w,
                onSelectionChanged: _selectChange,
                initialSelectedDate: widget.initialSelectedDate,
                selectionTextStyle: TextStyle(fontSize: 28.w),
                rangeTextStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_333333)),
                monthCellStyle: DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_333333)),
                    disabledDatesTextStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_efefef)),
                    weekendTextStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_333333)),
                    todayTextStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_1678ff))),
                monthViewSettings: DateRangePickerMonthViewSettings(
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(textStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_333333))),
                ),
                yearCellStyle: DateRangePickerYearCellStyle(
                    disabledDatesTextStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_efefef)),
                    textStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_333333)),
                    todayTextStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_1678ff))),
                headerStyle: DateRangePickerHeaderStyle(textStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_333333))),
                navigationDirection: DateRangePickerNavigationDirection.vertical,
              ))
            ],
          ),
        ),
        onCertain: () {
          if (widget.selectionMode == DateRangePickerSelectionMode.single) {
            widget.onCertain.call(selectTime);
          } else if (widget.selectionMode == DateRangePickerSelectionMode.range) {
            widget.onCertain.call(start, end);
          }
        });
  }

  //值改变
  _selectChange(DateRangePickerSelectionChangedArgs args) {
    if (widget.selectionMode == DateRangePickerSelectionMode.single) {
      selectTime = args.value;
    } else if (widget.selectionMode == DateRangePickerSelectionMode.range) {
      start = TimeUtils.getTime(args.value.startDate, format: "yyyy-MM-dd HH:mm:ss");
      if(args.value.endDate!=null){
        end = TimeUtils.getEndOfDay(args.value.endDate);
      }
    }
  }

  Widget operation() {
    return Container(
        height: 150.w,
        width: double.infinity,
        padding: EdgeInsets.only(left: 0.w, right: 0.w),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pActionText("今天", ColorConfig.color_333333, 28.w, 160.w, 60.w, () => _selectRange("今天"),
                  radius: 10.w, background: ColorConfig.color_efefef),
              pActionText("昨天", ColorConfig.color_333333, 28.w, 160.w, 60.w, () => _selectRange("昨天"),
                  radius: 10.w, background: ColorConfig.color_efefef),
              pActionText("最近7天", ColorConfig.color_333333, 28.w, 160.w, 60.w, () => _selectRange("最近7天"),
                  radius: 10.w, background: ColorConfig.color_efefef),
              pActionText("最近15天", ColorConfig.color_333333, 28.w, 160.w, 60.w, () => _selectRange("最近15天"),
                  radius: 10.w, background: ColorConfig.color_efefef),
            ],
          ),
          pSizeBoxH(20.w),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            pActionText("最近30天", ColorConfig.color_333333, 28.w, 160.w, 60.w, () => _selectRange("最近30天"),
                radius: 10.w, background: ColorConfig.color_efefef),
            pActionText("最近3个月", ColorConfig.color_333333, 28.w, 160.w, 60.w, () => _selectRange("最近3个月"),
                radius: 10.w, background: ColorConfig.color_efefef),
            pActionText("最近6个月", ColorConfig.color_333333, 28.w, 160.w, 60.w, () => _selectRange("最近6个月"),
                radius: 10.w, background: ColorConfig.color_efefef),
            pActionText("全部", ColorConfig.color_333333, 28.w, 160.w, 60.w, () => _selectRange("全部"),
                radius: 10.w, background: ColorConfig.color_efefef),
          ])
        ]));
  }

  _selectRange(String type) {
    String start = "";
    String end = "";
    if (type == "今天") {
      start = TimeUtils.getStartOfDay(DateTime.now());
      end = TimeUtils.getEndOfDay(DateTime.now());
    } else if (type == "昨天") {
      start = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(1));
      end = TimeUtils.getStartOfDay(DateTime.now());
    } else if (type == "最近7天") {
      start = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(7));
      end = TimeUtils.getEndOfDay(DateTime.now());
    } else if (type == "最近15天") {
      start = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(15));
      end = TimeUtils.getEndOfDay(DateTime.now());
    } else if (type == "最近30天") {
      start = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(30));
      end = TimeUtils.getEndOfDay(DateTime.now());
    } else if (type == "最近3个月") {
      start = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(90));
      end = TimeUtils.getEndOfDay(DateTime.now());
    } else if (type == "最近6个月") {
      start = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(180));
      end = TimeUtils.getEndOfDay(DateTime.now());
    } else if (type == "全部") {
      start = "全部";
      end = "全部";
    }
    widget.onCertain.call(start, end);
    Navigator.pop(context);
  }
}
