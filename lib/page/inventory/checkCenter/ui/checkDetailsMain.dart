import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/permission_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/model/checkCenter/inventory_record_item_do_entity.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/controller/checkRecordListController.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkTitle01.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/inventory_data_dialog.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/shop_car_dialog.dart';
import 'package:haidai_flutter_module/page/view_image_page.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/hint_dialog.dart';
import 'package:haidai_flutter_module/widget/more_dialog.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'checkTitle01.dart';

///盘点单详情
class CheckDetailsMain extends StatelessWidget {
  //StatefulWidget {

  //CheckDetailsMainState createState() => CheckDetailsMainState();
  late BuildContext _context;
  final CheckRecordListController _checkRecordListController =
      Get.put(CheckRecordListController());

  static final String cGoodsTag = "mainGoods";
  static final String cShopCarTag = "mainShopCar";

  final _refreshController = EasyRefreshController();

  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Scaffold(
      appBar: new CheckTitle01().appBar(context, "盘点记录"),
      body: EasyRefresh(
        controller: _refreshController,
        enableControlFinishRefresh: true,
        header: RefreshUtils.defaultHeader(),
        taskIndependence: true,
        child: _createBody(),
        onRefresh: _onRefresh,
      ),
      bottomSheet: Visibility(
        child: Container(
          height: 96.w,
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(15.w, 12.w, 15.w, 12.w),
          child: FlatButton(
            shape: StadiumBorder(
                side: BorderSide(
                    color: Color(ColorConfig.color_1678FF), width: 1.w)),
            color: Color(ColorConfig.color_1678FF),
            onPressed: () => PermissionUtils.checkPermission(
                    PermissionUtils.WAREHOUSE_ADD_INVENTORY_DATA)
                .then((value) => _addRecord(value)),
            child: Text(
              "添加盘点",
              style: textStyle(color: ColorConfig.color_ffffff, size: 32),
            ),
          ),
        ),
        visible: _checkRecordListController.status == "ON",
      ),
    );
  }

  Widget _createBody() {
    return GetBuilder<CheckRecordListController>(
      id: CheckRecordListController.ids,
      dispose: (state) {
        _refreshController.dispose();
      },
      builder: (ctl) {
        print("flutter=======_createBody");
        return Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(24.w, 30.w, 0, 30.w),
                child: Text(
                    "${_checkRecordListController.goodsStyleNum}款 ${_checkRecordListController.goodsNum}件",
                    style: TextStyle(
                        color: Color(ColorConfig.color_333333),
                        fontWeight: FontWeight.bold,
                        fontSize: 34.w))),
            ListView(
                shrinkWrap: true, //解决无限高度问题
                physics: new NeverScrollableScrollPhysics(), //禁用滑动事件
                padding: EdgeInsets.fromLTRB(0, 0, 0, 100.w),
                children: listItem(_checkRecordListController.getValue()))
          ],
        );
      },
    );
  }

  List<Widget> listItem(List<InventoryRecordItemDoEntity> lists) {
    List<Widget> list = <Widget>[];
    if (lists.length != 0) {
      for (int i = lists.length - 1; i >= 0; i--) {
        InventoryRecordItemDoEntity entity = lists[i];
        list.add(
          GetBuilder<CheckRecordListController>(
            id: "$i",
            builder: (ctl) {
              return _createRecordItem(i, entity);
            },
          ),
        );
      }
    }
    return list;
  }

  Widget _createRecordItem(int index, InventoryRecordItemDoEntity entity) {
    var moreKey = GlobalKey();
    return SizedBox(
      width: double.infinity,
      height: 166.w,
      child: GestureDetector(
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 20.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
          child: Stack(
            children: [
              Positioned(
                top: 30.w,
                left: 30.w,
                child: Row(
                  children: [
                    Card(
                      color: Color(_getColor(entity)),
                      margin: EdgeInsets.only(right: 10.w),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.w))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.w),
                        child: Text(
                          "#${index + 1}",
                          style: textStyle(
                              color: ColorConfig.color_ffffff, size: 24),
                        ),
                      ),
                    ),
                    Text(
                      "${entity.createdTime}",
                      style: textStyle(color: _getColor(entity), size: 24),
                    ),
                    pSizeBoxW(10.w),
                    Visibility(
                      child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            showMoreDialog(
                                _checkRecordListController, entity, moreKey);
                          },
                          child: pImage("images/more.png", 48.w, 32.w,
                              key: moreKey)),
                      visible: !_isCanceled(entity),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 30.w,
                bottom: 30.w,
                child: Text(
                  "${_isCanceled(entity) ? '-' : entity.goodsStyleNum}款 ${_isCanceled(entity) ? '-' : entity.goodsNum}件",
                  style:
                      textStyle(color: _getColor(entity), size: 28, bold: true),
                ),
              ),
              _createImg(entity, 14, 0, true, index),
              _createImg(
                  entity,
                  118,
                  1,
                  _checkRecordListController.getImgUrl(entity, 0)?.isNotEmpty ??
                      false,
                  index),
              Visibility(
                child: Positioned(
                  right: 206.w,
                  child: Image(
                      width: 124.w,
                      height: 124.w,
                      image: AssetImage("images/home_fuction_undo.png")),
                ),
                visible: _isCanceled(entity),
              )
            ],
          ),
        ),
        onTap: () => _itemClick(entity),
      ),
    );
  }

  showMoreDialog(CheckRecordListController ctl,
      InventoryRecordItemDoEntity entity, _moreKey) {
    MoreDialog({"删除": () => ctl.deleteData(entity.id)})
        .show(_context, _moreKey);
  }

  Widget _createImg(InventoryRecordItemDoEntity entity, double right,
      int imgIndex, bool show, int index) {
    final String? imgUrl =
        _checkRecordListController.getImgUrl(entity, imgIndex);
    return Positioned(
      right: right.w,
      bottom: 30.w,
      child: SizedBox(
        height: 84.w,
        width: 84.w,
        child: Stack(
          children: [
            Visibility(
              child: Positioned(
                left: 0,
                bottom: 0,
                child: GestureDetector(
                  child: imgUrl == null || imgUrl.isEmpty
                      ? Image.asset(
                          "images/home_print_pic.png",
                          width: 68.w,
                          height: 68.w,
                        )
                      : NetImageWidget(
                          imgUrl,
                          width: 68,
                          height: 68,
                          placeholder: "images/home_print_pic.png",
                        ),
                  onTap: () => _actionImage(entity, imgIndex, index),
                ),
              ),
              visible: show,
            ),
            Visibility(
              child: Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  child: Image.asset(
                    "images/del_pic.png",
                    width: 32.w,
                    height: 32.w,
                  ),
                  onTap: () => _actionDeleteImg(entity, imgUrl, index),
                ),
              ),
              visible: _checkRecordListController
                      .getImgUrl(entity, imgIndex)
                      ?.isNotEmpty ??
                  false,
            ),
          ],
        ),
      ),
    );
  }

  /// 图片点击事件
  void _actionImage(
      InventoryRecordItemDoEntity entity, int imageIndex, int index) async {
    if (_isCanceled(entity)) {
      return;
    }
    String? imgUrl = _checkRecordListController.getImgUrl(entity, imageIndex);
    if (imgUrl == null || imgUrl.isEmpty) {
      if (GetPlatform.isAndroid) {
        _showChooseImgDialog(entity.id!, index);
      } else {
        MethodChannel channel = MethodChannel(ChannelConfig.flutterToNative);
        String path = await channel
            .invokeMethod(ChannelConfig.methodManuallyGetLocalImages);
        _checkRecordListController.changeRecordImg(entity.id!, path, index);
      }
    } else {
      _viewLargerImage(imgUrl);
    }
  }

  /// 查看大图
  void _viewLargerImage(String imgUrl) {
    ViewImagePage.topViewImagePage(imgUrl);
  }

  /// 选图片弹窗
  void _showChooseImgDialog(int id, int index) {
    showModalBottomSheet(
        backgroundColor: Color(ColorConfig.color_00000000),
        context: Get.context!,
        builder: (BuildContext context) {
          return Container(
            height: 402.w,
            margin: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 0.w),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async => _pickImageFromCamera(id, index)
                      .then((value) => Navigator.pop(context)),
                  child: Container(
                    decoration: ShapeDecoration(
                        color: Color(0xBBFFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(28.w),
                                topRight: Radius.circular(28.w)))),
                    width: double.infinity,
                    height: 113.w,
                    child: Text("拍照上传",
                        style: TextStyle(
                            color: Color(ColorConfig.color_1678FF),
                            fontSize: 40.w,
                            fontWeight: FontWeight.bold)),
                    alignment: Alignment.center,
                  ),
                ),
                GestureDetector(
                  onTap: () async => _pickImageFromGallery(id, index)
                      .then((value) => Navigator.pop(context)),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 2.w, 0, 0),
                    decoration: ShapeDecoration(
                        color: Color(0xBBFFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(28.w),
                                bottomRight: Radius.circular(28.w)))),
                    width: double.infinity,
                    height: 113.w,
                    child: Text("从相册选择",
                        style: TextStyle(
                            color: Color(ColorConfig.color_1678FF),
                            fontSize: 40.w,
                            fontWeight: FontWeight.bold)),
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 12.w, 0, 0),
                      decoration: ShapeDecoration(
                          color: Color(0xFFFFFFFF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(28.w),
                          ))),
                      width: double.infinity,
                      height: 113.w,
                      child: Text("取消",
                          style: TextStyle(
                              color: Color(ColorConfig.color_1678FF),
                              fontSize: 40.w,
                              fontWeight: FontWeight.bold)),
                      alignment: Alignment.center,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  int _getColor(InventoryRecordItemDoEntity entity) {
    return _isCanceled(entity)
        ? ColorConfig.color_999999
        : ColorConfig.color_333333;
  }

  bool _isCanceled(InventoryRecordItemDoEntity entity) {
    return entity.canceled == "CANCELED";
  }

  /// 记录点击事件
  void _itemClick(InventoryRecordItemDoEntity entity) {
    //处理点击事件
    if (entity.canceled != "CANCELED") {
      if (_checkRecordListController.status != "ON") {
        // Get.delete<GoodsController>(tag: cGoodsTag);
        // Get.delete<ShopCarController>(tag: cShopCarTag);
        // GoodsController _goodsController =
        //     Get.put(GoodsController(onlyCheck: true), tag: cGoodsTag);
        // Get.put(ShopCarController(onlyCheck: true), tag: cShopCarTag);
        // _goodsController.recordId = entity.id;
        // _goodsController
        //     .getOrderGoods(tag: cShopCarTag)
        //     .then((value) => showShopCarDialog(context));
        showShopCarDialog(Get.context!, entity.id!);
      } else {
        Get.toNamed(ArgUtils.map2String(path: Routes.ENTERNEW, arguments: {
          "orderId": entity.orderInventoryId,
          "recordId": entity.id,
          "deptId": entity.deptId,
          "isSubstandard": _checkRecordListController.isSubstandard
        }))?.then((value) {
          if ("delete" == value || "update" == value) {
            _checkRecordListController.checkRecordList();
          }
        });
      }
    }
  }

  /// 删除记录图片
  void _actionDeleteImg(
      InventoryRecordItemDoEntity entity, String? imgUrl, int index) {
    if (_isCanceled(entity)) {
      return;
    }
    HintDialogUtil.show(
        height: 220,
        hideTitle: true,
        content: "确定删除这张照片吗？",
        contentTextStyle: textStyle(size: 34, bold: true),
        positiveText: "删除",
        positiveTextColor: Color(ColorConfig.color_ff3715),
        positiveCallBack: (_) {
          _checkRecordListController.deleteRecordImg(entity.id!, imgUrl, index);
        });
  }

  Future<void> _pickImageFromGallery(int id, int index) async {
    final PickedFile? pickedFile = await _picker
        .getImage(source: ImageSource.gallery)
        .whenComplete(() => setStatusBar());
    // setState(() => this._imageFile = File(pickedFile.path));
    if (pickedFile == null) return;
    _checkRecordListController.changeRecordImg(id, pickedFile.path, index);
  }

  Future<void> _pickImageFromCamera(int id, int index) async {
    final PickedFile? pickedFile = (await _picker
        .getImage(source: ImageSource.camera)
        .whenComplete(() => setStatusBar()));
    // setState(() => this._imageFile = File(pickedFile.path));
    if (pickedFile == null) return;
    _checkRecordListController.changeRecordImg(id, pickedFile.path, index);
  }

  void setStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  ///添加盘点记录
  _addRecord(bool hasPermission) {
    if (hasPermission) {
      // Get.toNamed(ArgUtils.map2String(path: Routes.ENTER, arguments: {
      //   "orderId": _checkRecordListController.orderId,
      //   "deptId": _checkRecordListController.depId,
      //   "isSubstandard": _checkRecordListController.isSubstandard
      // }))?.then((value) {
      //   if ("update" == value) _checkRecordListController.checkRecordList();
      // });
      Get.toNamed(ArgUtils.map2String(path: Routes.ENTERNEW, arguments: {
        "orderId": _checkRecordListController.orderId,
        "deptId": _checkRecordListController.depId,
        "isSubstandard": _checkRecordListController.isSubstandard
      }))?.then((value) {
        if ("update" == value) _checkRecordListController.checkRecordList();
      });
    }
  }

  /// 刷新事件
  Future _onRefresh() async {
    _checkRecordListController
        .checkRecordList()
        .whenComplete(() => _refreshController.finishRefresh(success: true));
  }

  showShopCarDialog(BuildContext context, int orderId) {
    // showModalBottomSheet(
    //   context: context,
    //   builder: (context) => InventoryDataDialog(orderId),
    //   isScrollControlled: true,
    //   backgroundColor: Colors.transparent,
    //   barrierColor: Colors.transparent,
    // );
    showCupertinoModalBottomSheet(
      context: Get.context!,
      animationCurve: Curves.easeIn,
      builder: (context) => BottomSheetWidget(
        title: "盘点数据",
        showCertain: false,
        height: 1400.w,
        child: InventoryDataDialog(orderId),
      ),
    );
  }
}

/*class CheckDetailsMainState extends State<CheckDetailsMain>
    with WidgetsBindingObserver {
  CheckRecordListController _checkRecordListController =
      Get.put(CheckRecordListController());
  static final String cGoodsTag = "mainGoods";
  static final String cShopCarTag = "mainShopCar";

  final int userId = ArgUtils.getArgument2num('userId');
  final int orderId = ArgUtils.getArgument2num('orderId');
  final int depId = ArgUtils.getArgument2num('depId');
  final isSubstandard = ArgUtils.getArgument2bool('isSubstandard');
  String orderGoodsType = ArgUtils.getArgument('orderGoodsType');
  String status = ArgUtils.getArgument('status');

  final _refreshController = EasyRefreshController();

  final _picker = ImagePicker();

  @override
  void initState() {
    _checkRecordListController.checkRecordList(orderId, userId, orderGoodsType);
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new CheckTitle01().appBar(context, "盘点记录"),
      body: EasyRefresh(
        controller: _refreshController,
        enableControlFinishRefresh: true,
        header: RefreshUtils.defaultHeader(),
        taskIndependence: true,
        child: _createBody(),
        onRefresh: _onRefresh,
      ),
      bottomSheet: Visibility(
        child: Container(
          height: 96.w,
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(15.w, 12.w, 15.w, 12.w),
          child: FlatButton(
            shape: StadiumBorder(
                side: BorderSide(
                    color: Color(ColorConfig.color_1678FF), width: 1.w)),
            color: Color(ColorConfig.color_1678FF),
            onPressed: () => PermissionUtils.checkPermission(
                    PermissionUtils.WAREHOUSE_ADD_INVENTORY_DATA)
                .then((value) => _addRecord(value)),
            child: Text(
              "添加盘点",
              style: textStyle(color: ColorConfig.color_ffffff, size: 32),
            ),
          ),
        ),
        visible: status == "ON",
      ),
    );
  }

  showShopCarDialog(BuildContext context, int orderId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ShopCarDialog(
        onlyCheck: true,
        orderId: orderId,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
    );
  }

  /// 刷新事件
  Future _onRefresh() async {
    _checkRecordListController
        .checkRecordList(orderId, userId, orderGoodsType)
        .whenComplete(() => _refreshController.finishRefresh(success: true));
  }

  Widget _createBody() {
    return GetBuilder<CheckRecordListController>(
      id: CheckRecordListController.ids,
      builder: (ctl) {
        print("flutter=======_createBody");
        return Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(24.w, 30.w, 0, 30.w),
                child: Text(
                    "${_checkRecordListController.goodsStyleNum}款 ${_checkRecordListController.goodsNum}件",
                    style: TextStyle(
                        color: Color(ColorConfig.color_333333),
                        fontWeight: FontWeight.bold,
                        fontSize: 34.w))),
            ListView(
                shrinkWrap: true, //解决无限高度问题
                physics: new NeverScrollableScrollPhysics(), //禁用滑动事件
                padding: EdgeInsets.fromLTRB(0, 0, 0, 100.w),
                children: listItem(_checkRecordListController.getValue()))
          ],
        );
      },
    );
  }

  List<Widget> listItem(List<InventoryRecordItemDoEntity> lists) {
    List<Widget> list = <Widget>[];
    if (lists.length != 0) {
      for (int i = lists.length - 1; i >= 0; i--) {
        InventoryRecordItemDoEntity entity = lists[i];
        list.add(
          GetBuilder<CheckRecordListController>(
            id: "$i",
            builder: (ctl) {
              return _createRecordItem(i, entity);
            },
          ),
        );
      }
    }
    return list;
  }

  Widget _createRecordItem(int index, InventoryRecordItemDoEntity entity) {
    return SizedBox(
      width: double.infinity,
      height: 166.w,
      child: GestureDetector(
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 20.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))),
          child: Stack(
            children: [
              Positioned(
                top: 30.w,
                left: 30.w,
                child: Row(
                  children: [
                    Card(
                      color: Color(_getColor(entity)),
                      margin: EdgeInsets.only(right: 10.w),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.w))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.w),
                        child: Text(
                          "#${index + 1}",
                          style: textStyle(
                              color: ColorConfig.color_ffffff, size: 24),
                        ),
                      ),
                    ),
                    Text(
                      "${entity.createdTime}",
                      style: textStyle(color: _getColor(entity), size: 24),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 30.w,
                bottom: 30.w,
                child: Text(
                  "${_isCanceled(entity) ? '-' : entity.goodsStyleNum}款 ${_isCanceled(entity) ? '-' : entity.goodsNum}件",
                  style:
                      textStyle(color: _getColor(entity), size: 28, bold: true),
                ),
              ),
              _createImg(entity, 14, 0, true, index),
              _createImg(
                  entity,
                  118,
                  1,
                  _checkRecordListController.getImgUrl(entity, 0).isNotEmpty,
                  index),
              Visibility(
                child: Positioned(
                  right: 206.w,
                  child: Image(
                      width: 124.w,
                      height: 124.w,
                      image: AssetImage("images/home_fuction_undo.png")),
                ),
                visible: _isCanceled(entity),
              )
            ],
          ),
        ),
        onTap: () => _itemClick(entity),
      ),
    );
  }

  Widget _createImg(InventoryRecordItemDoEntity entity, double right,
      int imgIndex, bool show, int index) {
    final imgUrl = _checkRecordListController.getImgUrl(entity, imgIndex);
    return Positioned(
      right: right.w,
      bottom: 30.w,
      child: SizedBox(
        height: 84.w,
        width: 84.w,
        child: Stack(
          children: [
            Visibility(
              child: Positioned(
                left: 0,
                bottom: 0,
                child: GestureDetector(
                  child: imgUrl.isEmpty
                      ? Image.asset(
                          "images/home_print_pic.png",
                          width: 68.w,
                          height: 68.w,
                        )
                      : NetImageWidget(
                          imgUrl,
                          width: 68,
                          height: 68,
                          placeholder: "images/home_print_pic.png",
                        ),
                  onTap: () => _actionImage(entity, imgIndex, index),
                ),
              ),
              visible: show,
            ),
            Visibility(
              child: Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  child: Image.asset(
                    "images/del_pic.png",
                    width: 32.w,
                    height: 32.w,
                  ),
                  onTap: () => _actionDeleteImg(entity, imgUrl, index),
                ),
              ),
              visible: _checkRecordListController
                      .getImgUrl(entity, imgIndex)
                      ?.isNotEmpty ??
                  false,
            ),
          ],
        ),
      ),
    );
  }

  /// 图片点击事件
  void _actionImage(
      InventoryRecordItemDoEntity entity, int imageIndex, int index) async {
    if (_isCanceled(entity)) {
      return;
    }
    String imgUrl = _checkRecordListController.getImgUrl(entity, imageIndex);
    if (imgUrl.isEmpty) {
      if (GetPlatform.isAndroid) {
        _showChooseImgDialog(entity.id, index);
      } else {
        MethodChannel channel = MethodChannel(ChannelConfig.flutterToNative);
        String path = await channel
            .invokeMethod(ChannelConfig.methodManuallyGetLocalImages);
        print("flutter_tag=====$path");
        _checkRecordListController.changeRecordImg(
            depId, entity.id, path, index);
      }
    } else {
      _viewLargerImage(imgUrl);
    }
  }

  /// 查看大图
  void _viewLargerImage(String imgUrl) {
    ViewImagePage.topViewImagePage(imgUrl);
  }

  /// 选图片弹窗
  void _showChooseImgDialog(int id, int index) {
    showModalBottomSheet(
        backgroundColor: Color(ColorConfig.color_00000000),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 402.w,
            margin: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 0.w),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async => _pickImageFromCamera(id, index)
                      .then((value) => Navigator.pop(context)),
                  child: Container(
                    decoration: ShapeDecoration(
                        color: Color(0xBBFFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(28.w),
                                topRight: Radius.circular(28.w)))),
                    width: double.infinity,
                    height: 113.w,
                    child: Text("拍照上传",
                        style: TextStyle(
                            color: Color(ColorConfig.color_1678FF),
                            fontSize: 40.w,
                            fontWeight: FontWeight.bold)),
                    alignment: Alignment.center,
                  ),
                ),
                GestureDetector(
                  onTap: () async => _pickImageFromGallery(id, index)
                      .then((value) => Navigator.pop(context)),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 2.w, 0, 0),
                    decoration: ShapeDecoration(
                        color: Color(0xBBFFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(28.w),
                                bottomRight: Radius.circular(28.w)))),
                    width: double.infinity,
                    height: 113.w,
                    child: Text("从相册选择",
                        style: TextStyle(
                            color: Color(ColorConfig.color_1678FF),
                            fontSize: 40.w,
                            fontWeight: FontWeight.bold)),
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 12.w, 0, 0),
                      decoration: ShapeDecoration(
                          color: Color(0xFFFFFFFF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(28.w),
                          ))),
                      width: double.infinity,
                      height: 113.w,
                      child: Text("取消",
                          style: TextStyle(
                              color: Color(ColorConfig.color_1678FF),
                              fontSize: 40.w,
                              fontWeight: FontWeight.bold)),
                      alignment: Alignment.center,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  int _getColor(InventoryRecordItemDoEntity entity) {
    return _isCanceled(entity)
        ? ColorConfig.color_999999
        : ColorConfig.color_333333;
  }

  bool _isCanceled(InventoryRecordItemDoEntity entity) {
    return entity.canceled == "CANCELED";
  }

  /// 记录点击事件
  void _itemClick(InventoryRecordItemDoEntity entity) {
    //处理点击事件
    if (entity.canceled != "CANCELED") {
      if (status != "ON") {
        // Get.delete<GoodsController>(tag: cGoodsTag);
        // Get.delete<ShopCarController>(tag: cShopCarTag);
        // GoodsController _goodsController =
        //     Get.put(GoodsController(onlyCheck: true), tag: cGoodsTag);
        // Get.put(ShopCarController(onlyCheck: true), tag: cShopCarTag);
        // _goodsController.recordId = entity.id;
        // _goodsController
        //     .getOrderGoods(tag: cShopCarTag)
        //     .then((value) => showShopCarDialog(context));
        showShopCarDialog(context, entity.id);
      } else {
        Get.toNamed(ArgUtils.map2String(path: Routes.ENTER, arguments: {
          "orderId": entity.orderInventoryId,
          "recordId": entity.id,
          "deptId": entity.deptId,
          "isSubstandard": isSubstandard
        })).then((value) {
          if ("delete" == value || "update" == value) {
            _checkRecordListController.checkRecordList(
                orderId, userId, orderGoodsType);
          }
        });
      }
    }
  }

  /// 删除记录图片
  void _actionDeleteImg(
      InventoryRecordItemDoEntity entity, String imgUrl, int index) {
    if (_isCanceled(entity)) {
      return;
    }
    HintDialogUtil.instance.show(
        height: 220,
        hideTitle: true,
        content: "确定删除这张照片吗？",
        contentTextStyle: textStyle(size: 34, bold: true),
        positiveText: "删除",
        positiveTextColor: Color(ColorConfig.color_ff3715),
        positiveCallBack: (_) {
          _checkRecordListController.deleteRecordImg(
              depId, entity.id, imgUrl, index);
        });
  }

  Future<void> _pickImageFromGallery(int id, int index) async {
    final PickedFile pickedFile = await _picker
        .getImage(source: ImageSource.gallery)
        .whenComplete(() => setStatusBar());
    // setState(() => this._imageFile = File(pickedFile.path));
    _checkRecordListController.changeRecordImg(
        depId, id, pickedFile.path, index);
  }

  Future<void> _pickImageFromCamera(int id, int index) async {
    final PickedFile pickedFile = await _picker
        .getImage(source: ImageSource.camera)
        .whenComplete(() => setStatusBar());
    // setState(() => this._imageFile = File(pickedFile.path));
    _checkRecordListController.changeRecordImg(
        depId, id, pickedFile.path, index);
  }

  void setStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  ///添加盘点记录
  _addRecord(bool hasPermission) {
    if (hasPermission) {
      Get.toNamed(ArgUtils.map2String(path: Routes.ENTER, arguments: {
        "orderId": orderId,
        "deptId": depId,
        "isSubstandard": isSubstandard
      })).then((value) {
        if ("update" == value)
          _checkRecordListController.checkRecordList(
              orderId, userId, orderGoodsType);
      });
    }
  }
}*/
