import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class SlidingSegment extends StatefulWidget {
  final List<String> items;
  final List<String> badgeitems;
  final Function(int) onSelectedItem;
  int? currentIndex = 0;

  SlidingSegment(
      {Key? key, required this.items, required this.badgeitems, required this.onSelectedItem, this.currentIndex})
      : super(key: key);

  @override
  _SlidingSegmentState createState() => _SlidingSegmentState();
}

class _SlidingSegmentState extends State<SlidingSegment> {
  double itemWidth = 230.w;
  double itemHeight = 70.w;
  int? currentIndex;

  Widget _buildDateRangeItem(String item, String badgeitem, int index) {
    currentIndex = widget.currentIndex;
    return InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
            widget.currentIndex = index;
          });
          widget.onSelectedItem(index);
        },
        child: Container(
            // padding: EdgeInsets.fromLTRB(0, 5, 0, 5),

            alignment: Alignment.center,
            width: itemWidth,
            height: itemHeight,
            decoration: BoxDecoration(color: index == currentIndex ? Color(ColorConfig.color_1678FF) : Color
              (ColorConfig.color_f5f5f5),
            borderRadius: BorderRadius.circular(35.w)),
            child: Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(8.w)),
                    child: (Text(
                      item,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32.w,
                          fontWeight: FontWeight.bold,
                          color: index == currentIndex ? Color(ColorConfig.color_ffffff) : Colors.black.withAlpha(150)),
                    ))),
                Positioned(
                    top: -5.w,
                    right: -20.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(36.w)),
                      child: Text(
                        badgeitem,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.w, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    )),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < widget.items.length; i++) {
      list.add(_buildDateRangeItem(widget.items[i], widget.badgeitems[i], i));
    }
    return Container(
      width: (itemWidth + 1) * widget.items.length,
      padding: EdgeInsets.only(top: 4.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.w)),
      child: Stack(
        children: [
          AnimatedPositioned(
              left: itemWidth * currentIndex!,
              child: Container(
                  height: itemHeight,
                  width: itemWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(itemHeight / 2.w),
                  )),
              duration: Duration(milliseconds: 200)),
          Row(children: list),
        ],
      ),
    );
  }
}
