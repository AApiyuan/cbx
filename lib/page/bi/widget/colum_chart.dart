import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColumnChart extends StatefulWidget {
  final List<Map> chartData;
  final String xName;
  final String yName;
  final double? height;
  final double space;
  final double? dataWidth;
  final int? xRotation;
  final String? yTitle;

  ColumnChart(
      {Key? key,
      required this.chartData,
      required this.xName,
      required this.yName,
      this.height,
      this.space = 0.2,
      this.dataWidth,
      this.xRotation = 0,
      this.yTitle})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        controller: scrollController,
        child: Container(
            width: widget.chartData.length * (widget.dataWidth ?? 100.w),
            height: widget.height ?? 400.w,
            child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                enableAxisAnimation: true,
                primaryXAxis: CategoryAxis(
                    labelRotation: widget.xRotation,
                    axisLine: AxisLine(color: Color.fromRGBO(255, 255, 255, 0.1)),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20.w),
                    majorGridLines: MajorGridLines(width: 0)),
                primaryYAxis: CategoryAxis(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.inside,
                    tickPosition: TickPosition.inside,
                    title: AxisTitle(
                        text: widget.yTitle??"",
                        alignment: ChartAlignment.center,
                        textStyle: TextStyle(
                          color: Color(ColorConfig.color_ffffff),
                          fontSize: 20.w,
                        )),
                    // maximum:99999,
                    // arrangeByIndex:true,
                    maximumLabels: 2,
                    axisLine: AxisLine(color: Color.fromRGBO(255, 255, 255, 0.1)),
                    majorGridLines: MajorGridLines(width: 1.w, color: Color.fromRGBO(255, 255, 255, 0.1))),
                series: <ChartSeries>[
                  ColumnSeries<Map, String>(
                    dataSource: widget.chartData,
                    borderRadius: BorderRadius.all(Radius.circular(8.w)),
                    color: Color(ColorConfig.color_1678ff),
                    spacing: widget.space,
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true, alignment: ChartAlignment.center, textStyle: TextStyle(color: Colors.white, fontSize: 20.w)),
                    borderColor: Colors.red,
                    xValueMapper: (Map item, _) => item[widget.xName],
                    yValueMapper: (Map item, _) => item[widget.yName],
                  )
                ])));
  }
}
