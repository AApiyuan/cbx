import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';

/// 经典Header
class RefreshHeader extends Header {
  /// Key
  final Key? key;

  /// 方位
  final AlignmentGeometry? alignment;

  /// 提示刷新文字
  final String? refreshText;

  /// 准备刷新文字
  final String? refreshReadyText;

  /// 正在刷新文字
  final String? refreshingText;

  /// 刷新完成文字
  final String? refreshedText;

  /// 刷新失败文字
  final String? refreshFailedText;

  /// 没有更多文字
  final String? noMoreText;

  /// 显示额外信息(默认为时间)
  final bool showInfo;

  /// 更多信息
  final String? infoText;

  /// 背景颜色
  final Color bgColor;

  /// 字体颜色
  final Color textColor;

  RefreshHeader({
    bool float = false,
    Duration? completeDuration = const Duration(seconds: 1),
    bool enableInfiniteRefresh = false,
    bool enableHapticFeedback = true,
    bool overScroll = true,
    this.key,
    this.alignment,
    this.refreshText,
    this.refreshReadyText,
    this.refreshingText,
    this.refreshedText,
    this.refreshFailedText,
    this.noMoreText,
    this.showInfo: true,
    this.infoText,
    this.bgColor: Colors.transparent,
    this.textColor: const Color(ColorConfig.color_999999),
  }) : super(
          extent: 140.w,
          triggerDistance: 150.w,
          float: float,
          completeDuration: float
              ? completeDuration == null
                  ? Duration(milliseconds: 400)
                  : completeDuration + Duration(milliseconds: 400)
              : completeDuration,
          enableInfiniteRefresh: enableInfiniteRefresh,
          enableHapticFeedback: enableHapticFeedback,
          overScroll: overScroll,
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration? completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    return CustomizeRefreshHeaderWidget(
      key: key,
      classicalHeader: this,
      refreshState: refreshState,
      pulledExtent: pulledExtent,
      refreshTriggerPullDistance: refreshTriggerPullDistance,
      refreshIndicatorExtent: refreshIndicatorExtent,
      axisDirection: axisDirection,
      float: float,
      completeDuration: completeDuration,
      enableInfiniteRefresh: enableInfiniteRefresh,
      success: success,
      noMore: noMore,
    );
  }
}

/// 经典Header组件
class CustomizeRefreshHeaderWidget extends StatefulWidget {
  final RefreshHeader classicalHeader;
  final RefreshMode refreshState;
  final double pulledExtent;
  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final AxisDirection axisDirection;
  final bool float;
  final Duration? completeDuration;
  final bool enableInfiniteRefresh;
  final bool success;
  final bool noMore;

  CustomizeRefreshHeaderWidget(
      {Key? key,
      required this.refreshState,
      required this.classicalHeader,
      required this.pulledExtent,
      required this.refreshTriggerPullDistance,
      required this.refreshIndicatorExtent,
      required this.axisDirection,
      required this.float,
      required this.completeDuration,
      required this.enableInfiniteRefresh,
      required this.success,
      required this.noMore})
      : super(key: key);

  @override
  CustomizeRefreshHeaderWidgetState createState() => CustomizeRefreshHeaderWidgetState();
}

class CustomizeRefreshHeaderWidgetState extends State<CustomizeRefreshHeaderWidget> with TickerProviderStateMixin<CustomizeRefreshHeaderWidget> {
  // 是否到达触发刷新距离
  bool _overTriggerDistance = false;

  bool get overTriggerDistance => _overTriggerDistance;

  set overTriggerDistance(bool over) {
    if (_overTriggerDistance != over) {
      _overTriggerDistance ? _readyController.forward() : _restoreController.forward();
      _overTriggerDistance = over;
    }
  }

  /// 文本
  String get _refreshText {
    return widget.classicalHeader.refreshText ?? '下拉刷新';
  }

  String get _refreshReadyText {
    return widget.classicalHeader.refreshReadyText ?? '松手刷新';
  }

  String get _refreshingText {
    return widget.classicalHeader.refreshingText ?? '正在刷新...';
  }

  String get _refreshedText {
    return widget.classicalHeader.refreshedText ?? '刷新完成';
  }

  String get _refreshFailedText {
    return widget.classicalHeader.refreshFailedText ?? '刷新失败';
  }

  String get _noMoreText {
    return widget.classicalHeader.noMoreText ?? 'No more';
  }

  // 是否刷新完成
  bool _refreshFinish = false;

  set refreshFinish(bool finish) {
    if (_refreshFinish != finish) {
      if (finish && widget.float) {
        Future.delayed(widget.completeDuration! - Duration(milliseconds: 400), () {
          if (mounted) {
            _floatBackController.forward();
          }
        });
        Future.delayed(widget.completeDuration!, () {
          _floatBackDistance = null;
          _refreshFinish = false;
        });
      }
      _refreshFinish = finish;
    }
  }

  // 动画
  late AnimationController _readyController;
  late Animation<double> _readyAnimation;
  late AnimationController _restoreController;
  late Animation<double> _restoreAnimation;
  late AnimationController _floatBackController;
  late Animation<double> _floatBackAnimation;

  // 浮动时,收起距离
  double? _floatBackDistance;

  // 显示文字
  String get _showText {
    if (widget.noMore) return _noMoreText;
    if (widget.enableInfiniteRefresh) {
      if (widget.refreshState == RefreshMode.refreshed || widget.refreshState == RefreshMode.inactive || widget.refreshState == RefreshMode.drag) {
        return _finishedText;
      } else {
        return _refreshingText;
      }
    }
    switch (widget.refreshState) {
      case RefreshMode.refresh:
        return _refreshingText;
      case RefreshMode.armed:
        return _refreshingText;
      case RefreshMode.refreshed:
        return _finishedText;
      case RefreshMode.done:
        return _finishedText;
      default:
        if (overTriggerDistance) {
          return _refreshReadyText;
        } else {
          return _refreshText;
        }
    }
  }

  // 刷新结束文字
  String get _finishedText {
    if (!widget.success) return _refreshFailedText;
    if (widget.noMore) return _noMoreText;
    return _refreshedText;
  }

  @override
  void initState() {
    super.initState();
    // 准备动画
    _readyController = new AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _readyAnimation = new Tween(begin: 0.5, end: 1.0).animate(_readyController);
    _readyAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _readyController.reset();
      }
    });
    // 恢复动画
    _restoreController = new AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _restoreAnimation = new Tween(begin: 1.0, end: 0.5).animate(_restoreController);
    _restoreAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _restoreController.reset();
      }
    });
    // float收起动画
    _floatBackController = new AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _floatBackAnimation = new Tween(begin: widget.refreshIndicatorExtent, end: 0.0).animate(_floatBackController)
      ..addListener(() {
        setState(() {
          if (_floatBackAnimation.status != AnimationStatus.dismissed) {
            _floatBackDistance = _floatBackAnimation.value;
          }
        });
      });
    _floatBackAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _floatBackController.reset();
      }
    });
  }

  @override
  void dispose() {
    _readyController.dispose();
    _restoreController.dispose();
    _floatBackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 是否反向
    bool isReverse = widget.axisDirection == AxisDirection.up || widget.axisDirection == AxisDirection.left;
    // 是否到达触发刷新距离
    overTriggerDistance = widget.refreshState != RefreshMode.inactive && widget.pulledExtent >= widget.refreshTriggerPullDistance;
    if (widget.refreshState == RefreshMode.refreshed) {
      //refreshFinish = true;
    }
    return Stack(
      children: <Widget>[
        Positioned(
          top: isReverse
              ? _floatBackDistance == null
                  ? 0.0
                  : (widget.refreshIndicatorExtent - _floatBackDistance!)
              : null,
          bottom: !isReverse
              ? _floatBackDistance == null
                  ? 0.0
                  : (widget.refreshIndicatorExtent - _floatBackDistance!)
              : null,
          left: 0.0,
          right: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: widget.classicalHeader.alignment ?? (isReverse ? Alignment.topCenter : Alignment.bottomCenter),
              width: double.infinity,
              height: _floatBackDistance == null
                  ? (widget.refreshIndicatorExtent > widget.pulledExtent ? widget.refreshIndicatorExtent : widget.pulledExtent)
                  : widget.refreshIndicatorExtent,
              color: widget.classicalHeader.bgColor,
              child: Container(
                height: widget.refreshIndicatorExtent,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildContent(isReverse),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 构建显示内容
  List<Widget> _buildContent(bool isReverse) {
    return <Widget>[
      Visibility(
          visible:
              widget.refreshState == RefreshMode.drag || widget.refreshState == RefreshMode.refreshed || widget.refreshState == RefreshMode.armed,
          child: Image.asset(
            "images/pic_refresh.gif",
            width: 44.w,
            height: 44.w,
          )),
      Padding(
        padding: EdgeInsets.only(top: 10.w),
        child: Text(
          _showText,
          style: TextStyle(
            fontSize: 20.w,
            color: widget.classicalHeader.textColor,
          ),
        ),
      ),
    ];
  }
}
