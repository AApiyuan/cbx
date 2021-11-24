import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    this.backgroundColor = ColorConfig.color_1678ff,
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;
  int backgroundColor;
  EdgeInsets padding;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: child,
      height: double.infinity,
      width: double.infinity,
      padding: padding,
      color: Color(backgroundColor),
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
