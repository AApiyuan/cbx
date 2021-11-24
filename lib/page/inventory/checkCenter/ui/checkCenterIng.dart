import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/permission_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/controller/checkCenterController.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/modules/scheduleItem.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkTitle01.dart';
import 'package:haidai_flutter_module/page/inventory/difference/delegate/sliver_app_bar_delegate.dart';
import 'package:haidai_flutter_module/repository/check_api.dart';
import 'package:haidai_flutter_module/repository/order/inventory_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/hint_dialog.dart';

///盘点中：盘点中心
class CheckCenterIng extends StatefulWidget {
  CheckCenterIng({Key? key}) : super(key: key);

  CheckCenterState createState() => CheckCenterState();
}

class CheckCenterState extends State<CheckCenterIng>
    with SingleTickerProviderStateMixin {
  final num? depId = ArgUtils.getArgument2num('depId');
  final num? hisId = ArgUtils.getArgument2num('hisId');
  String? cTag;
  late CheckCenterController _checkCenterController;
  late TabController tabController;
  ScheduleItem si = new ScheduleItem();
  final _refreshController = EasyRefreshController();
  final GlobalKey _tabHeaderKey = GlobalKey();

  @override
  void initState() {
    cTag = hisId.toString();
    _checkCenterController = Get.put(CheckCenterController(), tag: cTag);
    _checkCenterController.deptId = depId;
    if (hisId != null)
      _checkCenterController.checkDetail(hisId);
    else if (depId != null) _checkCenterController.checkCenter(depId);

    this.tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildResult();
  }

  List<Widget> checkListItem(List? ls, int type) {
    List<Widget> list = <Widget>[];
    int size = 0;
    if (ls != null) {
      size = ls.length;

      for (int i = 0; i < size; i++) {
        list.add(GestureDetector(
          onTap: () {
            String arg =
                ArgUtils.map2String(path: Routes.CHECK_LIST, arguments: {
              "userId": ls[i].userId,
              "orderId": _checkCenterController.inventoryDoEntity.id,
              "depId": depId,
              "isSubstandard": tabController.index == 1,
              "orderGoodsType": type == 1 ? "NORMAL" : "SUBSTANDARD",
              "status": _checkCenterController.inventoryDoEntity.status,
            });
            Get.toNamed(arg)?.then((value) {
              if (hisId != null)
                _checkCenterController.checkDetail(hisId);
              else if (depId != null) _checkCenterController.checkCenter(depId);
            });
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 5.w),
            child: Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13.w))),
              child: Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(30.w, 45.w, 0, 45.w),
                      child: Text(ls[i].userName ?? "",
                          style: textStyle(
                              size: 28,
                              color: ColorConfig.color_333333,
                              bold: true))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 45.w, 30.w, 45.w),
                          child: Text(
                              "${ls[i].goodsStyleNum ?? ""}款 ${ls[i].goodsNum ?? ""}件 >",
                              style: textStyle(
                                  size: 28,
                                  color: ColorConfig.color_333333,
                                  bold: true))))
                ],
              ),
            ),
          ),
        ));
      }
    }

    return list;
  }

  Widget buildResult() {
    return Scaffold(
      appBar: CheckTitle01().appBar(
        context,
        "盘点中心",
        callBack: () => BackUtils.backToNative(),
        actions: [
          GetBuilder<CheckCenterController>(
            tag: cTag,
            id: CheckCenterController.ids,
            builder: (ctl) {
              return GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsetsDirectional.only(end: 36.w),
                  child: Text(
                    _checkCenterController.getEntity().status == 'FINISH'
                        ? "盘点撤销"
                        : "盘点历史",
                    textAlign: TextAlign.center,
                    style: textStyle(color: ColorConfig.color_999999, size: 28),
                  ),
                ),
                onTap: () {
                  if (_checkCenterController.getEntity().status == 'FINISH') {
                    PermissionUtils.checkPermission(
                            PermissionUtils.WAREHOUSE_CANCELED_INVENTORY)
                        .then((value) => _showRevokeHintDialog(value));
                  } else {
                    Get.toNamed(
                        ArgUtils.map2String(path: Routes.CHECKHIS, arguments: {
                      "depId": depId,
                    }));
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Color(ColorConfig.color_f5f5f5),
        child: _createBody(),
      ),
      bottomSheet: GetBuilder<CheckCenterController>(
        id: CheckCenterController.ids,
        tag: cTag,
        builder: (ctl) {
          return Visibility(
            child: GestureDetector(
              child: Container(
                  height: 96.w,
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(15.w, 12.w, 15.w, 12.w),
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: Color(ColorConfig.color_1678FF),
                            width: 1.w)),
                    color: Color(ColorConfig.color_1678FF),
                  ),
                  alignment: Alignment.center,
                  child: Text("添加盘点",
                      style: textStyle(
                          color: ColorConfig.color_ffffff, size: 32))),
              onTap: () => PermissionUtils.checkPermission(
                      PermissionUtils.WAREHOUSE_ADD_INVENTORY_DATA)
                  .then((value) => _addRecord(value)),
            ),
            visible: _checkCenterController.getEntity().status == "ON",
          );
        },
      ),
    );
  }

  Widget _createBody() {
    if (hisId != null) {}
    return EasyRefresh.custom(
      controller: _refreshController,
      enableControlFinishRefresh: true,
      header: RefreshUtils.defaultHeader(),
      taskIndependence: true,
      slivers: [
        _createInventoryInfo(),
        _createTab(),
        _createTabBody(),
      ],
      onRefresh: () async {
        Future? future;
        if (hisId != null) {
          future = _checkCenterController.checkDetail(hisId);
        } else if (depId != null) {
          future = _checkCenterController.checkCenter(depId).then((value) {
            if (null == value) {
              Get.offAllNamed(ArgUtils.map2String(
                  path: Routes.CHECKEMPTY, arguments: {"depId": depId}));
              return;
            }
          });
        }
        if (future == null) {
          _refreshController.finishRefresh(success: true);
        } else {
          Future.wait([future])
              .then((value) => _refreshController.finishRefresh(success: true));
        }
      },
    );
  }

  Widget _createInventoryInfo() {
    return GetBuilder<CheckCenterController>(
        // init: CheckHistortController(),
        tag: cTag,
        id: CheckCenterController.ids,
        builder: (ctl) => SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                //创建列表项
                return Container(
                  height: 450.w,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 56.w,
                          left: 24.w,
                          width: 28.w,
                          height: 28.w,
                          child: Image(
                            image:
                                AssetImage("images/icon_check_center_01.png"),
                            fit: BoxFit.cover,
                          )),
                      Positioned(
                          top: 50.w,
                          left: 62.w,
                          child: Text(
                              "盘点任务${_checkCenterController.getEntity().orderSerial}",
                              style: TextStyle(
                                  fontSize: 28.w,
                                  color: Color(ColorConfig.color_333333)))),
                      Positioned(
                          left: 24.w,
                          top: 103.w,
                          child: Text(
                              "账面库存快照时间：${_checkCenterController.getEntity().createdTime}",
                              style: TextStyle(
                                  fontSize: 24.w,
                                  color: Color(ColorConfig.color_999999)))),
                      Positioned(
                          left: 50.w,
                          right: 50.w,
                          top: 183.w,
                          child: Container(
                            height: 100.w,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: si.schedule(_checkCenterController, 0),
                            ),
                          )),
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 15.w,
                            right: 15.w,
                            top: 317.w,
                          ),
                          height: 72.w,
                          // color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 200.w,
                                  height: 72.w,
                                  child: Text("查看差异",
                                      style: TextStyle(
                                          color:
                                              Color(ColorConfig.color_1678FF),
                                          fontSize: 28.w)),
                                  // padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: Color(
                                                  ColorConfig.color_1678FF),
                                              width: 1.w))),
                                ),
                                onTap: () => _toDifferencePage(
                                    _checkCenterController.getEntity().id,
                                    _checkCenterController.deptId),
                              ),
                              SizedBox(width: 30.w),
                              Visibility(
                                child: GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 200.w,
                                    height: 72.w,
                                    child: Text("盘点完成",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28.w)),
                                    // padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    decoration: ShapeDecoration(
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: Color(
                                                  ColorConfig.color_1678FF),
                                              width: 1.w)),
                                      color: Color(ColorConfig.color_1678FF),
                                    ),
                                  ),
                                  onTap: () => PermissionUtils.checkPermission(
                                          PermissionUtils
                                              .WAREHOUSE_FINISHED_ADD_INVENTORY_DATA)
                                      .then(
                                          (value) => _showSuccessDialog(value)),
                                ),
                                visible:
                                    _checkCenterController.getEntity().status ==
                                        "ON",
                              ),
                              Visibility(
                                child: GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 200.w,
                                    height: 72.w,
                                    child: Text("库存调整",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28.w)),
                                    // padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    decoration: ShapeDecoration(
                                        color: Color(ColorConfig.color_1678FF),
                                        shape: StadiumBorder(
                                            side: BorderSide(
                                                color: Color(
                                                    ColorConfig.color_1678FF),
                                                width: 1.w))),
                                  ),
                                  onTap: () => PermissionUtils.checkPermission(
                                          PermissionUtils
                                              .WAREHOUSE_FINISHED_INVENTORY)
                                      .then((value) => _toAdjust(value)),
                                ),
                                visible:
                                    _checkCenterController.getEntity().status ==
                                        "INVENTORY_COMPLETE",
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: 1 //30个列表项
                      ),
            ));
  }

  Widget _createTab() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 100.w,
        maxHeight: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 170.w),
        backgroundColor: Color(ColorConfig.color_f5f5f5),
        child: TabBar(
          key: _tabHeaderKey,
          indicatorColor: Color(ColorConfig.color_00000000),
          unselectedLabelColor: Color(ColorConfig.color_999999),
          labelColor: Color(ColorConfig.color_1678FF),
          controller: this.tabController,
          labelStyle: _textStyle(true),
          unselectedLabelStyle: _textStyle(false),
          tabs: <Widget>[
            Tab(
              text: "正品盘点",
            ),
            Tab(
              text: "次品盘点",
            ),
          ],
        ),
      ),
    );
  }

  Widget _createTabBody() {
    return SliverToBoxAdapter(
      child: GetBuilder<CheckCenterController>(
        id: CheckCenterController.ids,
        tag: cTag,
        builder: (ctl) {
          final normalList =
              _checkCenterController.getEntity().normalInventoryMembers;
          final substandardList =
              _checkCenterController.getEntity().substandardInventoryMembers;
          int size = max(normalList?.length ?? 0, substandardList?.length ?? 0);
          double height = size * 156.00;
          //RenderBox? renderBox =
          RenderBox? renderBox;
          var findRenderObject = _tabHeaderKey.currentContext?.findRenderObject();
          if (findRenderObject is RenderBox) {
            renderBox = findRenderObject;
          }
          if (renderBox != null) {
            final offset =
                renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
            double remaining = Get.size.height - offset.dy;
            height = max(height, remaining);
          } else if (height == 0) {
            height = Get.size.height;
          }
          return Container(
            height: height.w,
            child: TabBarView(
              controller: tabController,
              children: [
                _createList(
                    _checkCenterController.getEntity().normalInventoryMembers,
                    1),
                _createList(
                    _checkCenterController
                        .getEntity()
                        .substandardInventoryMembers,
                    2),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _createList(List? ls, int type) {
    if (ls == null || ls.length == 0) {
      return SizedBox.expand(
        child: Column(
          children: [
            Image.asset(
              "images/bg_check_detail_empty.png",
              width: 270.w,
              height: 270.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.w),
              child: Text(
                "暂无盘点数据~",
                style: textStyle(color: ColorConfig.color_999999),
              ),
            ),
          ],
        ),
      );
    }
    return ListView(
      physics: new NeverScrollableScrollPhysics(),
      //禁用滑动事件
      children: checkListItem(ls, type),
    );
  }

  TextStyle _textStyle(bool select) {
    return textStyle(
        size: 28,
        bold: select,
        color: select ? ColorConfig.color_1678FF : ColorConfig.color_999999);
  }

  void _toDifferencePage(int? orderId, num? deptId) {
    if (orderId == null) {
      toastMsg("任务单id不能为null");
      return;
    }

    final entity = _checkCenterController.getEntity();
    if (entity.substandardInventoryMembers?.length == 0 &&
        entity.normalInventoryMembers?.length == 0) {
      HintDialogUtil.show(
        title: "提示",
        content: "当前没有录入盘点数据，请先录入盘点数据再查看盘点差异",
        singleButton: true,
        singleButtonText: "好的，我知道了",
      );
      return;
    }

    Get.toNamed(ArgUtils.map2String(
        path: Routes.DIFFERENCE, arguments: {"id": orderId, "deptId": deptId}));
  }

  /// 显示撤销提示弹窗
  void _showRevokeHintDialog(bool hasPermission) {
    if (!hasPermission) return;
    HintDialogUtil.show(
        hideTitle: true,
        height: 302,
        contentWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 65.w),
          child: Text(
            "撤销盘点任务会把盘点调整的库存撤销，撤销后不能继续该盘点，但可以查看盘点详情",
            style: textStyle(size: 32, bold: true),
            textAlign: TextAlign.center,
          ),
        ),
        positiveCallBack: (_) => _revokeHistory());
  }

  /// 撤销历史记录
  void _revokeHistory() {
    CheckApi.checkCancel(_checkCenterController.getEntity().id!)
        .then((value) => Get.back(result: true));
  }

  /// 盘点完成提示弹窗
  _showSuccessDialog(bool hasPermission) {
    if (!hasPermission) return;
    showDialog(
      context: Get.context!,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(
              Radius.circular(30.w),
            ),
          ),
          child: Container(
            width: 550.w,
            height: 453.w,
            padding: EdgeInsetsDirectional.only(top: 48.w),
            child: Column(
              children: [
                Text(
                  "确定货品已盘点完成？",
                  style: textStyle(size: 32, bold: true),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 50.w,
                    top: 30.w,
                    right: 50.w,
                    bottom: 20.w,
                  ),
                  child: Text("点击完成后，可以出入库、发货，不会影响盘点数据",
                      textAlign: TextAlign.start,
                      style:
                          textStyle(size: 32, color: ColorConfig.color_999999)),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: Text("不能再新建盘点数据，可以修改已录入的盘点数",
                        style: textStyle(
                            size: 32, color: ColorConfig.color_999999)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1.w,
                  color: Color(ColorConfig.color_efefef),
                ),
                Container(
                  height: 88.w,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Text(
                            "取消",
                            style: textStyle(
                              size: 32,
                              color: ColorConfig.color_999999,
                            ),
                          ),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Color(ColorConfig.color_efefef)),
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                        ),
                      ),
                      Container(
                        width: 1.w,
                        color: Color(ColorConfig.color_efefef),
                      ),
                      Expanded(
                        child: TextButton(
                          child: Text(
                            "确定",
                            style: textStyle(
                              size: 32,
                              color: ColorConfig.color_1678FF,
                            ),
                          ),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Color(ColorConfig.color_efefef)),
                          ),
                          onPressed: () => InventoryApi.inventoryOrderComplete(
                                  _checkCenterController.getEntity().id!)
                              .then((value) =>
                                  _checkCenterController.checkCenter(depId))
                              .then((value) => Navigator.of(ctx).pop(true)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///添加盘点记录
  _addRecord(bool hasPermission) {
    if (!hasPermission) return;

    Get.toNamed(ArgUtils.map2String(path: Routes.ENTERNEW, arguments: {
      "orderId": _checkCenterController.getEntity().id,
      "deptId": depId,
      "isSubstandard": tabController.index == 1
    }))?.then((value) {
      if ("update" == value) _checkCenterController.checkCenter(depId);
    });
  }

  ///库存调整页面
  _toAdjust(bool hasPermission) {
    if (!hasPermission) return;
    Get.toNamed(ArgUtils.map2String(path: Routes.CHECK_ADJUST, arguments: {
      "id": _checkCenterController.getEntity().id,
      "depId": depId
    }));
  }
}

abstract class CancelCallBack {
  callBack();
}
