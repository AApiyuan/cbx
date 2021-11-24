
import 'dart:ui';

import 'package:haidai_flutter_module/theme/color.dart';

class CircleChartData {
  static List<Color> colors = [Color(ColorConfig.color_1678ff),Color(ColorConfig.color_ffed4b),Color(ColorConfig.color_27cc8c),Color(ColorConfig.color_ff6940),Color(ColorConfig.color_8e20ff),Color(ColorConfig.color_ffbb4b)];
  CircleChartData(this.x, this.y, [this.color,this.info]);

  final String x;
  final double y;
  final String? info;
  final Color? color;
}
