import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/remit/controller/remit_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class RemitTabBar extends StatefulWidget {
  List<StoreRemitMethodDoEntity> remitMethods;
  Function onChange;

  RemitTabBar({Key? key, required this.remitMethods, required this.onChange}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RemitTabBarState();
}

class _RemitTabBarState extends State<RemitTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: widget.remitMethods.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 550.w,
        padding: EdgeInsets.only(bottom: 8.w),
        child: DefaultTabController(
            length: widget.remitMethods.length,
            child: TabBar(
              onTap: (index) {
                widget.onChange.call(index);
              },
              labelColor: Color(ColorConfig.color_1678ff),
              labelPadding: EdgeInsets.only(bottom: 10.w, top: 0.w, right: 48.w, left: 0.w),
              isScrollable: true,
              labelStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_1678ff), fontWeight: FontWeight.w600),
              unselectedLabelColor: Color(ColorConfig.color_666666),
              unselectedLabelStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_666666), fontWeight: FontWeight.w400),
              indicatorWeight: 8.w,
              indicatorPadding: EdgeInsets.only( right: 58.w,left: 10.w),
              indicatorColor: Color(ColorConfig.color_1678ff),
              tabs: widget.remitMethods
                  .map((e) => Tab(
                        text: e.remitMethodName,
                      ))
                  .toList(),
            )));
  }
}
