import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class CustomerTab extends StatefulWidget {
  final int type;
  final List<String> tabs;
  final Function change;
  final double? width;

  final double? height;
  final double? radius;
  final Color? contentBackgroundColor;
  TextStyle? labelStyle;
  TextStyle? unselectedLabelStyle;
  int? indicatorColor;
  int? labelColor;

  final double? divideHeight;
  final Color? divideColor;

  final EdgeInsetsGeometry? margin;

  final TabController? tabController; //可以自由传入，也可以用控件的

  // final int tabBackColor;//kua

  CustomerTab(
      {Key? key,
      this.type = 0,
      required this.tabs,
      required this.change,
      this.width,
      this.height,
      this.radius,
      this.contentBackgroundColor,
      this.tabController,
      this.labelStyle,
      this.unselectedLabelStyle,
      this.divideHeight,
      this.indicatorColor,
      this.labelColor,
      this.divideColor,
      this.margin = EdgeInsets.zero})
      : super(key: key);

  @override
  CustomerTabState createState() => CustomerTabState();
}

class CustomerTabState extends State<CustomerTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int curIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = widget.tabController ?? TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 0) {
      //滑块类型 的tab
      if (widget.labelStyle == null) {
        widget.labelStyle = TextStyle(fontSize: 24.w, color: Color(ColorConfig.color_333333), fontWeight: FontWeight.w500);
      }
      if (widget.unselectedLabelStyle == null) {
        widget.unselectedLabelStyle = TextStyle(fontSize: 24.w, color: Color(ColorConfig.color_999999), fontWeight: FontWeight.w400);
      }
      return Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 50.w,
        padding: EdgeInsets.all(4.w),
        margin: widget.margin,
        decoration: new BoxDecoration(
            color: widget.contentBackgroundColor ?? Color(ColorConfig.color_ffffff), borderRadius: new BorderRadius.circular((widget.radius ?? 0))),
        child: TabBar(
          onTap: (index) {
            if(curIndex != index){
              curIndex = index;
              widget.change.call(index);
            }
          },
          labelPadding:EdgeInsets.all(0.w),
          controller: _tabController,
          indicator: ShapeDecoration(
            color: Color(widget.indicatorColor ?? ColorConfig.color_4e4b6a),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 0),
            ),
          ),
          labelStyle: widget.labelStyle,
          labelColor: Color(widget.labelColor ?? ColorConfig.color_333333),
          unselectedLabelStyle: widget.unselectedLabelStyle,
          tabs: widget.tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
      );
    } else if (widget.type == 1) {
      if (widget.labelStyle == null) {
        widget.labelStyle = TextStyle(fontSize: 24.w, color: Color(ColorConfig.color_333333), fontWeight: FontWeight.w500);
      }
      if (widget.unselectedLabelStyle == null) {
        widget.unselectedLabelStyle = TextStyle(fontSize: 24.w, color: Color(ColorConfig.color_999999), fontWeight: FontWeight.w400);
      }
      return Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 50.w,
        padding: EdgeInsets.all(4.w),
        decoration: new BoxDecoration(
            color: widget.contentBackgroundColor ?? Color(ColorConfig.color_ffffff), borderRadius: new BorderRadius.circular((widget.radius ?? 0))),
        child: TabBar(
          onTap: (index) {
            if(curIndex != index){
              curIndex = index;
              setState(() {});
              widget.change.call(index);
            }
          },
          controller: _tabController,
          indicator: ShapeDecoration(
            // color: Color(ColorConfig.color_4e4b6a),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 0),
            ),
          ),
          labelPadding: EdgeInsets.all(0),
          tabs: widget.tabs
              .map((e) => Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          e.toString(),
                          style: e == widget.tabs[curIndex] ? widget.labelStyle : widget.unselectedLabelStyle,
                        ),
                        SizedBox(
                          width: e == widget.tabs[widget.tabs.length - 1] ? 0 : 1.w,
                          height: widget.divideHeight ?? 25.w,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: widget.divideColor ?? Color.fromRGBO(142, 142, 147, 0.3)),
                          ),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      );
    } else {
      return Container();
    }
  }
}
