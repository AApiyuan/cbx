import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkTitle01.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/checkCenter/inventory_history_entity.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/controller/checkHistortController.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

///盘点历史
class CheckHistory extends StatelessWidget {
  //StatefulWidget {
  //CheckHistoryState createState() => CheckHistoryState();
  final EasyRefreshController _controller = EasyRefreshController();
  final BasePage basePage = new BasePage();
  final CheckHistortController _checkHistortController =
      Get.put(CheckHistortController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CheckTitle01().appBar(context, "盘点历史"),
        body: Stack(
          children: [
            GetBuilder<CheckHistortController>(
              dispose: (_) {
                _controller.dispose();
              },
              initState: (_) {
                _checkHistortController.reset();
              },
              id: CheckHistortController.ids,
              builder: (ctl) => _checkHistortController.getValue().length == 0
                  ? emptyWidget()
                  : listWidget(),
            )
          ],
        ));
  }

  Widget emptyWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(ColorConfig.color_f5f5f5),
      padding: EdgeInsets.only(top: 200.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage("images/bg_check_detail_empty.png")),
          Text(
            "暂无盘点历史~",
            style: TextStyle(
                fontSize: 28.w, color: Color(ColorConfig.color_999999)),
          )
        ],
      ),
    );
  }

  Widget listWidget() {
    return Container(
      color: Color(ColorConfig.color_f5f5f5),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: EasyRefresh.custom(
        enableControlFinishRefresh: false,
        enableControlFinishLoad: true,
        controller: _controller,
        taskIndependence: true,
        //这个参数最好设置true，要不感觉有问题，下拉后，上拉加载失效
        header: RefreshUtils.defaultHeader(),
        footer: RefreshUtils.defaultFooter(),
        onRefresh: () async {
          await _checkHistortController
              .reset()
              .whenComplete(() => _controller.finishRefresh(success: true));
        },
        onLoad: () async {
          await _checkHistortController.next().whenComplete(() =>
              _controller.finishLoad(
                  success: true, noMore: _checkHistortController.noMore));
        },
        slivers: <Widget>[
          GetBuilder<CheckHistortController>(
              id: CheckHistortController.ids,
              builder: (ctl) => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return GestureDetector(
                        onTap: () {
                          if (_checkHistortController
                                  .getItem(index)
                                  ?.canceled !=
                              "CANCELED") {
                            Get.toNamed(
                              ArgUtils.map2String(
                                path: Routes.CHECKING,
                                arguments: {
                                  "hisId": _checkHistortController
                                      .getItem(index)
                                      ?.id,
                                  "depId": _checkHistortController.deptId
                                },
                              ),
                            )?.then(
                              (value) {
                                if (value) _checkHistortController.reset();
                              },
                            );
                          }
                        },
                        child: Container(
                            height: 176.w,
                            margin: EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 0),
                            decoration: ShapeDecoration(
                                color: Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(20.r),
                                ))),
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 30.w,
                                    left: 30.w,
                                    child: Image(
                                        width: 28.w,
                                        height: 28.w,
                                        image: AssetImage(
                                            "images/2.0x/icon_check_center_01.png"))),
                                Positioned(
                                    top: 23.w,
                                    left: 68.w,
                                    child: Text(
                                        "盘点任务" +
                                            (_checkHistortController
                                                    .getItem(index)
                                                    ?.orderSerial ??
                                                ""),
                                        style: TextStyle(
                                            fontSize: 28.w,
                                            color: Color(
                                                ColorConfig.color_333333)))),
                                Positioned(
                                    right: 35.w,
                                    top: 30.w,
                                    child: Text(
                                        _checkHistortController
                                                .getItem(index)
                                                ?.createdTime ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 24.w,
                                            color: Color(
                                                ColorConfig.color_999999)))),
                                Positioned(
                                    left: 30.w,
                                    top: 82.w,
                                    child: Text(
                                        "正品已盘：${_checkHistortController.getItem(index)?.inventoryStyleNum}款/${_checkHistortController.getItem(index)?.inventoryNum}",
                                        style: TextStyle(
                                            fontSize: 24.w,
                                            color: Color(
                                                ColorConfig.color_999999)))),
                                Positioned(
                                    left: 30.w,
                                    top: 122.w,
                                    child: Text(
                                        "次品已盘：${_checkHistortController.getItem(index)?.substandardInventoryStyleNum}款/${_checkHistortController.getItem(index)?.substandardInventoryNum}",
                                        style: TextStyle(
                                            fontSize: 24.w,
                                            color: Color(
                                                ColorConfig.color_999999)))),
                                Visibility(
                                  child: Positioned(
                                    bottom: 1.w,
                                    right: 36.w,
                                    child: Image(
                                        width: 124.w,
                                        height: 124.w,
                                        image: AssetImage(
                                            "images/home_fuction_undo_01.png")),
                                  ),
                                  visible: _checkHistortController
                                          .getItem(index)
                                          ?.canceled ==
                                      "CANCELED",
                                ),
                              ],
                            )));
                  }, childCount: _checkHistortController.getValue().length)))
        ],
      ),
    );
  }

  List<Widget> historyListItem() {
    List<InventoryHistoryEntity> inventoryHistoryEntity =
        _checkHistortController.getValue();

    List<Widget> list = <Widget>[];
    for (int i = 0; i < inventoryHistoryEntity.length; i++) {
      InventoryHistoryEntity entity = inventoryHistoryEntity[i];
      list.add(GestureDetector(
          // onTap: () {
          //   setState(() {
          //
          //   });
          // },
          child: Container(
              height: 176.w,
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              decoration: ShapeDecoration(
                  color: Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ))),
              child: Stack(
                children: [
                  Positioned(
                      top: 30.w,
                      left: 30.w,
                      child: Image(
                          width: 28.w,
                          height: 28.w,
                          image: AssetImage(
                              "images/2.0x/icon_check_center_01.png"))),
                  Positioned(
                      top: 30.w,
                      left: 68.w,
                      child: Text("盘点任务" + entity.orderSerial.toString(),
                          style: TextStyle(
                              fontSize: 28.w,
                              color: Color(ColorConfig.color_333333)))),
                  Positioned(
                      right: 30.w,
                      top: 30.w,
                      child: Text(entity.createdTime!,
                          style: TextStyle(
                              fontSize: 24.w,
                              color: Color(ColorConfig.color_999999)))),
                  Positioned(
                      left: 30.w,
                      top: 82.w,
                      child: Text(
                          "正品已盘：${entity.inventoryStyleNum}款/${entity.inventoryStyleNum}",
                          style: TextStyle(
                              fontSize: 24.w,
                              color: Color(ColorConfig.color_999999)))),
                  Positioned(
                      left: 30.w,
                      top: 122.w,
                      child: Text(
                          "次品已盘：${entity.substandardInventoryStyleNum}款/${entity.substandardInventoryNum}",
                          style: TextStyle(
                              fontSize: 24.w,
                              color: Color(ColorConfig.color_999999)))),
                ],
              ))));
    }

    return list;
  }
}

/*class CheckHistoryState extends State<CheckHistory> {
  EasyRefreshController _controller = EasyRefreshController();
  final int depId = ArgUtils.getArgument2num('depId');
  CheckHistortController _checkHistortController;
  BasePage basePage = new BasePage();

  // InventoryHistoryEntityEntity _inventoryHistoryEntity = new InventoryHistoryEntityEntity();

  @override
  void initState() {
    _checkHistortController = Get.put(CheckHistortController(deptId: depId));
    _checkHistortController.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CheckTitle01().appBar(context, "盘点历史"),
        body: Stack(
          children: [
            GetBuilder<CheckHistortController>(
              // init: CheckHistortController(),
              id: CheckHistortController.ids,
              builder: (ctl) => _checkHistortController.getValue().length == 0
                  ? emptyWidget()
                  : listWidget(),
            )
          ],
        ));
  }

  Widget emptyWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(ColorConfig.color_f5f5f5),
      padding: EdgeInsets.only(top: 200.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage("images/bg_check_detail_empty.png")),
          Text(
            "暂无盘点历史~",
            style: TextStyle(
                fontSize: 28.w, color: Color(ColorConfig.color_999999)),
          )
        ],
      ),
    );
  }

  Widget listWidget() {
    return Container(
      color: Color(ColorConfig.color_f5f5f5),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: EasyRefresh.custom(
        enableControlFinishRefresh: false,
        enableControlFinishLoad: true,
        controller: _controller,
        taskIndependence: true,
        //这个参数最好设置true，要不感觉有问题，下拉后，上拉加载失效
        header: RefreshUtils.defaultHeader(),
        footer: RefreshUtils.defaultFooter(),
        onRefresh: () async {
          _checkHistortController.reset().whenComplete(() => _controller.finishRefresh(success: true));
        },
        onLoad: () async {
          _checkHistortController.next().whenComplete(() => _controller.finishLoad(success: true, noMore: _checkHistortController.noMore));
        },
        slivers: <Widget>[
          GetBuilder<CheckHistortController>(
              // init: CheckHistortController(),
              id: CheckHistortController.ids,
              builder: (ctl) => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return GestureDetector(
                        onTap: () {
                          if (_checkHistortController
                                  .getValue()[index]
                                  .canceled !=
                              "CANCELED") {
                            Get.toNamed(
                              ArgUtils.map2String(
                                path: Routes.CHECKING,
                                arguments: {
                                  "hisId": _checkHistortController
                                      .getValue()[index]
                                      .id,
                                  "depId": depId
                                },
                              ),
                            ).then(
                              (value) {
                                if (value)
                                  _checkHistortController.reset();
                              },
                            );
                          }
                        },
                        child: Container(
                            height: 176.w,
                            margin: EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 0),
                            decoration: ShapeDecoration(
                                color: Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(20.r),
                                ))),
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 30.w,
                                    left: 30.w,
                                    child: Image(
                                        width: 28.w,
                                        height: 28.w,
                                        image: AssetImage(
                                            "images/2.0x/icon_check_center_01.png"))),
                                Positioned(
                                    top: 23.w,
                                    left: 68.w,
                                    child: Text(
                                        "盘点任务" +
                                            _checkHistortController
                                                .getValue()[index]
                                                .orderSerial
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 28.w,
                                            color: Color(
                                                ColorConfig.color_333333)))),
                                Positioned(
                                    right: 35.w,
                                    top: 30.w,
                                    child: Text(
                                        _checkHistortController
                                            .getValue()[index]
                                            .createdTime,
                                        style: TextStyle(
                                            fontSize: 24.w,
                                            color: Color(
                                                ColorConfig.color_999999)))),
                                Positioned(
                                    left: 30.w,
                                    top: 82.w,
                                    child: Text(
                                        "正品已盘：${_checkHistortController.getValue()[index].inventoryStyleNum}款/${_checkHistortController.getValue()[index].inventoryNum}",
                                        style: TextStyle(
                                            fontSize: 24.w,
                                            color: Color(
                                                ColorConfig.color_999999)))),
                                Positioned(
                                    left: 30.w,
                                    top: 122.w,
                                    child: Text(
                                        "次品已盘：${_checkHistortController.getValue()[index].substandardInventoryStyleNum}款/${_checkHistortController.getValue()[index].substandardInventoryNum}",
                                        style: TextStyle(
                                            fontSize: 24.w,
                                            color: Color(
                                                ColorConfig.color_999999)))),
                                Visibility(
                                  child: Positioned(
                                    bottom: 1.w,
                                    right: 36.w,
                                    child: Image(
                                        width: 124.w,
                                        height: 124.w,
                                        image: AssetImage(
                                            "images/home_fuction_undo_01.png")),
                                  ),
                                  visible: _checkHistortController
                                          .getValue()[index]
                                          .canceled ==
                                      "CANCELED",
                                ),
                              ],
                            )));
                  }, childCount: _checkHistortController.getValue().length)))
        ],
      ),
    );
  }

  List<Widget> historyListItem() {
    List<InventoryHistoryEntity> inventoryHistoryEntity =
        _checkHistortController.getValue();

    List<Widget> list = <Widget>[];
    for (int i = 0; i < inventoryHistoryEntity.length; i++) {
      InventoryHistoryEntity entity = inventoryHistoryEntity[i];
      list.add(GestureDetector(
          // onTap: () {
          //   setState(() {
          //
          //   });
          // },
          child: Container(
              height: 176.w,
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              decoration: ShapeDecoration(
                  color: Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ))),
              child: Stack(
                children: [
                  Positioned(
                      top: 30.w,
                      left: 30.w,
                      child: Image(
                          width: 28.w,
                          height: 28.w,
                          image: AssetImage(
                              "images/2.0x/icon_check_center_01.png"))),
                  Positioned(
                      top: 30.w,
                      left: 68.w,
                      child: Text("盘点任务" + entity.orderSerial.toString(),
                          style: TextStyle(
                              fontSize: 28.w,
                              color: Color(ColorConfig.color_333333)))),
                  Positioned(
                      right: 30.w,
                      top: 30.w,
                      child: Text(entity.createdTime,
                          style: TextStyle(
                              fontSize: 24.w,
                              color: Color(ColorConfig.color_999999)))),
                  Positioned(
                      left: 30.w,
                      top: 82.w,
                      child: Text(
                          "正品已盘：${entity.inventoryStyleNum}款/${entity.inventoryStyleNum}",
                          style: TextStyle(
                              fontSize: 24.w,
                              color: Color(ColorConfig.color_999999)))),
                  Positioned(
                      left: 30.w,
                      top: 122.w,
                      child: Text(
                          "次品已盘：${entity.substandardInventoryStyleNum}款/${entity.substandardInventoryNum}",
                          style: TextStyle(
                              fontSize: 24.w,
                              color: Color(ColorConfig.color_999999)))),
                ],
              ))));
    }

    return list;
  }
}*/
