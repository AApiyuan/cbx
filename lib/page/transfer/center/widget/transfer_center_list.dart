import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/transfer/center/controller/transfer_center_controller.dart';
import 'package:haidai_flutter_module/page/transfer/center/widget/transfer_filter.dart';
import 'package:haidai_flutter_module/page/transfer/create/controller/transfer_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/widget/drawer_dialog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/date_pick.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:haidai_flutter_module/common/utils/device_utils.dart';
import 'order_list_view.dart';

class TransferCenterList extends StatefulWidget {
  @override
  _TransferCenterListState createState() => _TransferCenterListState();
}

class _TransferCenterListState extends State<TransferCenterList> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  late EasyRefreshController _controller;
  late TransferCenterController _transController;
  int _pageNo = 1; //页码
  int _pageSize = 15; //页数

  int _count = 20;

  var _toolbarKey = GlobalKey();
  var _context;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    _controller = EasyRefreshController();
    _transController = Get.find<TransferCenterController>();
    _transController.tabController = _tabController;
    _tabController.index = _transController.topIndex;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  List<String> titles() {
    if (_transController.groupValue == 0) {
      var countEntity = _transController.countEntity;
      var ph = '配货调入' + (countEntity.distributeInNum == null ? '' : ('(' + countEntity.distributeInNum.toString() + ')'));
      var zj = '直接调入' + (countEntity.directStockInNum == null ? '' : ('(' + countEntity.directStockInNum.toString() + ')'));
      var bd = '本店申请' + (countEntity.applyStockInNum == null ? '' : ('(' + countEntity.applyStockInNum.toString() + ')'));
      var cp = '次品调入' + (countEntity.substandardInNum == null ? '' : ('(' + countEntity.substandardInNum.toString() + ')'));
      return [ph, zj, bd, cp];
    } else {
      var countEntity = _transController.countEntity;
      var ph = '配货调出' + (countEntity.distributeOutNum == null ? '' : ('(' + countEntity.distributeOutNum.toString() + ')'));
      var zj = '直接调出' + (countEntity.directStockOutNum == null ? '' : ('(' + countEntity.directStockOutNum.toString() + ')'));
      var td = '他店申请' + (countEntity.applyStockOutNum == null ? '' : ('(' + countEntity.applyStockOutNum.toString() + ')'));
      var cp = '次品调出' + (countEntity.substandardOutNum == null ? '' : ('(' + countEntity.substandardOutNum.toString() + ')'));
      return [ph, zj, td, cp];
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _context = context;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(86.w),
          child: GetBuilder<TransferCenterController>(
              id: "TransferCenterPageTitle",
              builder: (ctl) {
                var padding = ((DeviceUtil.isPad()?1536:750)/4-150) /2;

                return Material(
                    color: Color(ColorConfig.color_ffffff),
                    child: TabBar(
                      onTap: (index) {
                        print(index);
                      },

                      labelColor: Color(ColorConfig.color_333333),
                      labelPadding: EdgeInsets.only(bottom: 15.w, top: 20.w, right: padding.w, left: padding.w),
                      isScrollable: true,
                      labelStyle: TextStyle(fontSize: 28.w, color: Colors.white, fontWeight: FontWeight.w600),
                      unselectedLabelColor: Color(ColorConfig.color_999999),
                      unselectedLabelStyle: TextStyle(fontSize: 28.w, color: Colors.white, fontWeight: FontWeight.w400),
                      controller: _tabController,
                      indicatorWeight: 8.w,
                      indicatorPadding: EdgeInsets.only(left: (padding+30).w, right: (padding+30).w),
                      indicatorColor: Color(ColorConfig.color_1678ff),
                      tabs: titles()
                          .map((e) => Tab(
                                text: e,
                              ))
                          .toList(),
                    ));
              }),
        ),
        body:GetBuilder<TransferCenterController>(
            id: "TransferCenterFilter",
            builder: (ctl) {
              return Column(
                children: [
                  Container(
                      key: _toolbarKey,
                      height: 96.w,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                pText('货品', ColorConfig.color_999999, 24.w),
                                pImage("images/icon_down.png", 24.w, 24.w),
                              ]),
                              onTap: () {
                                Get.toNamed(ArgUtils.map2String(path: Routes.TRANSFER_CENTERSELECTGOOD, arguments: {
                                  "depId": _transController.stockInDeptId,
                                }));
                              },
                            ),
                          ),
                          Expanded(
                              child: GestureDetector(
                                child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                  pText('单据状态', ColorConfig.color_999999, 24.w),
                                  pImage("images/icon_down.png", 24.w, 24.w),
                                ]),
                                onTap: () {
                                  DrawerDialog((dialog) => docStateContent(dialog, () {
                                    print("单据");
                                    print(_transController.docStateList);
                                    print(_transController.revocationList);
                                    print(_transController.differencesList);
                                  })).show(_context, _toolbarKey);
                                },
                              )),
                          Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  _transController.loadHisShop().then((value) {
                                    DrawerDialog((dialog) => hisShopContent(dialog, value, () {
                                      print("他店");
                                      print(_transController.selectedHisShopId);
                                    })).show(_context, _toolbarKey);
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    pText('他店', ColorConfig.color_999999, 24.w),
                                    pImage("images/icon_down.png", 24.w, 24.w),
                                  ],
                                )),
                          ),
                          Expanded(
                              child: GestureDetector(
                                child: GetBuilder<TransferCenterController>(builder: (ctl) {
                                  return pText("${_transController.dateTurnString()}", ColorConfig.color_999999, 24.w);
                                }),
                                onTap: () => showCupertinoModalBottomSheet(
                                  context: Get.context!,
                                  animationCurve: Curves.easeIn,
                                  builder: (context) => DatePick(
                                    selectionMode: DateRangePickerSelectionMode.range,
                                    initialSelectedDate: _transController.endDate,
                                    onCertain: (v1, v2) {
                                      print(v1);
                                      print(v2);
                                      if(v1 == "全部"){
                                        _transController.startDate = null;
                                        _transController.endDate = null;
                                      }else{
                                        _transController.startDate = DateTime.parse(v1);
                                        _transController.endDate = DateTime.parse(v2);
                                      }
                                      print('----');
                                      print(_transController.startDate);
                                      print(_transController.endDate);
                                      _transController.update(["TransferCenterFilter"]);
                                      _transController.pageRefresh(_transController.lastListType, _transController.lastCtr, refresh: true);
                                    },
                                  ),
                                ),
                              )),
                        ],
                      )),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        OrderListView('DISTRIBUTION'),
                        OrderListView('DIRECT'),
                        OrderListView('APPLY'),
                        OrderListView('SUBSTANDARD'),
                      ],
                    ),
                  )
                ],
              );
            })



    );
  }
}
