// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Used with [TabBar.indicator] to draw a horizontal line below the
/// selected tab.
///
/// The selected tab underline is inset from the tab's boundary by [insets].
/// The [borderSide] defines the line's color and weight.
///
/// The [TabBar.indicatorSize] property can be used to define the indicator's
/// bounds in terms of its (centered) widget with [TabIndicatorSize.label],
/// or the entire tab with [TabIndicatorSize.tab].
class TabSizeIndicator extends Decoration {

  final double wantWidth;//传入的指示器宽度，默认20


  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const TabSizeIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.blue),
    this.insets = EdgeInsets.zero,
    this.wantWidth = 20
  });

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;//指示器高度以及颜色 ，默认高度2，颜色蓝

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the
  /// tab indicator's bounds in terms of its (centered) tab widget with
  /// [TabIndicatorSize.label], or the entire tab with [TabIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t) ?? EdgeInsets.zero,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is TabSizeIndicator) {
      return TabSizeIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t) ?? EdgeInsets.zero,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([ VoidCallback? onChanged ]) {
    return _MyUnderlinePainter(this, wantWidth, onChanged);
  }
}

class _MyUnderlinePainter extends BoxPainter {
  final double wantWidth;
  _MyUnderlinePainter(this.decoration, this.wantWidth,VoidCallback? onChanged)
      : super(onChanged);

  final TabSizeIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;
  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);

    //希望的宽度
    // double wantWidth = 20;
    //取中间坐标
    double cw = (indicator.left + indicator.right) / 2;
    return Rect.fromLTWH(cw - wantWidth / 2,
        indicator.bottom - borderSide.width, wantWidth, borderSide.width);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & (configuration.size ?? Size(0, 0));
    final TextDirection textDirection = configuration.textDirection ?? TextDirection.ltr;
    final Rect indicator = _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    final Paint paint = borderSide.toPaint()..strokeCap = StrokeCap.square;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}