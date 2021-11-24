import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/sale/util/DateUtils.dart' as Date;
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/common_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/page/direct_deliver/controller/direct_deliver_controller.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/req/delivery_create_delivery_req_entity.dart';
import 'package:haidai_flutter_module/page/view_image_page.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/date_pick.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget orderInfoWidget() {
  return Column(
    children: [
      Expanded(
        child: ListView(
          children: [
            _remarkWidget(),
            _orderDate(),
            _logisticsNum(),
            _photoVoucher(),
            _logisticsCompany(),
            _historyLogisticsCompany(),
          ],
        ),
      ),
      submitBtn(),
    ],
  );
}

_photoVoucher() {
  return GetBuilder<DirectDeliverController>(
    builder: (ctl) => Container(
      padding:
          EdgeInsets.only(left: 24.w, right: 24.w, top: 28.w, bottom: 28.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _hintText("照片凭证"),
          pSizeBoxH(4.w),
          Visibility(
            child: Stack(
              children: [
                GestureDetector(
                  child: Container(
                    child: NetImageWidget(
                      ctl.deliverData?.consigneeImg ?? "",
                      width: 126,
                      height: 126,
                    ),
                    margin: EdgeInsets.only(top: 20.w, right: 20.w),
                  ),
                  onTap: () => ViewImagePage.topViewImagePage(
                      ctl.deliverData?.consigneeImg ?? ""),
                ),
                Positioned(
                  child: GestureDetector(
                    child: pImage("images/del_pic.png", 42.w, 42.w),
                    onTap: () {
                      ctl.deliverData?.consigneeImg = null;
                      ctl.param.consigneeImg = "";
                      ctl.update([DirectDeliverController.idPhotoVoucher]);
                    },
                  ),
                  right: 0,
                ),
              ],
            ),
            visible: ctl.deliverData?.consigneeImg?.isNotEmpty ?? false,
          ),
          Visibility(
            child: GestureDetector(
              child: Container(
                child: pImage("images/icon_good_add.png", 126.w, 126.w),
                margin: EdgeInsets.only(top: 20.w, right: 20.w),
              ),
              onTap: () => _actionPhoto(ctl),
            ),
            visible: ctl.deliverData?.consigneeImg?.isEmpty ?? true,
          ),
        ],
      ),
    ),
    id: DirectDeliverController.idPhotoVoucher,
  );
}

_actionPhoto(DirectDeliverController ctl) async {
  if (GetPlatform.isAndroid) {
    _showChooseImgDialog(ctl);
  } else {
    MethodChannel channel = MethodChannel(ChannelConfig.flutterToNative);
    String path =
        await channel.invokeMethod(ChannelConfig.methodManuallyGetLocalImages);
    ctl.upload(path);
  }
}

_historyLogisticsCompany() {
  return Container(
    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 28.w, bottom: 28.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _hintText("历史使用的物流公司"),
            pText("（可直接选择）", ColorConfig.color_999999, 28.w),
          ],
        ),
        pSizeBoxH(24.w),
        GetBuilder<DirectDeliverController>(
          builder: (ctl) => GridView.builder(
            shrinkWrap: true,
            itemCount: ctl.logisticsCompanyList.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.w,
              childAspectRatio: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  child: pText(
                    ctl.logisticsCompanyList[index].dictName ?? "",
                    ColorConfig.color_666666,
                    28.w,
                  ),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    color: Color(ColorConfig.color_f5f5f5),
                  ),
                ),
                onTap: () =>
                    ctl.selectLogisticsCompany(ctl.logisticsCompanyList[index]),
              );
            },
          ),
        ),
      ],
    ),
  );
}

_logisticsCompany() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hintText("物流公司"),
        pSizeBoxH(24.w),
        Container(
          height: 76.w,
          child: GetBuilder<DirectDeliverController>(
            builder: (ctl) => TextField(
              maxLines: 1,
              style: textStyle(color: ColorConfig.color_333333),
              controller: TextEditingController.fromValue(
                  TextEditingValue(text: ctl.param.logisticsCompanyName ?? "")),
              decoration: InputDecoration(
                hintText: "请输入",
                hintStyle: textStyle(color: ColorConfig.color_999999),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (text) {
                ctl.param.logisticsCompanyName = text;
                ctl.param.logisticsCompanyId = null;
              },
            ),
            id: DirectDeliverController.idLogisticsCompany,
          ),
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.w),
            ),
            color: Color(ColorConfig.color_f5f5f5),
          ),
        ),
      ],
    ),
    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 28.w, bottom: 28.w),
  );
}

_logisticsNum() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hintText("物流单号"),
        pSizeBoxH(24.w),
        Container(
          height: 76.w,
          child: GetBuilder<DirectDeliverController>(
            builder: (ctl) => TextField(
              maxLines: 1,
              style: textStyle(color: ColorConfig.color_333333),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-z,A-Z,0-9]"))
              ],
              controller: TextEditingController.fromValue(
                  TextEditingValue(text: ctl.param.logisticsNo ?? "")),
              decoration: InputDecoration(
                hintText: "请输入",
                hintStyle: textStyle(color: ColorConfig.color_999999),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (text) => ctl.param.logisticsNo = text,
            ),
          ),
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.w),
            ),
            color: Color(ColorConfig.color_f5f5f5),
          ),
        ),
      ],
    ),
    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 28.w, bottom: 28.w),
  );
}

_orderDate() {
  return GetBuilder<DirectDeliverController>(
    id: DirectDeliverController.idOrderInfoDate,
    builder: (ctl) => GestureDetector(
      child: Container(
        child: Row(
          children: [
            pSizeBoxW(24.w),
            _hintText("单据日期"),
            Expanded(child: Container()),
            pText(ctl.param.customizeTime?.split(" ")[0] ?? "",
                ColorConfig.color_333333, 28.w),
            pSizeBoxW(6.w),
            Visibility(
              child: pImage("images/icon_goto.png", 22.w, 22.w),
              visible: ctl.orderId == null,
            ),
            pSizeBoxW(24.w),
          ],
        ),
        height: 84.w,
      ),
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (ctl.orderId != null) return;
        showCupertinoModalBottomSheet(
          context: Get.context!,
          animationCurve: Curves.easeIn,
          builder: (context) => DatePick(
            initialSelectedDate:
                Date.DateUtils.string2Date(ctl.param.customizeTime) ??
                    DateTime.now(),
            onCertain: (v) {
              ctl.param.customizeTime =
                  TimeUtils.getTime(v, format: "yyyy-MM-dd HH:mm:ss");
              ctl.update([DirectDeliverController.idOrderInfoDate]);
            },
          ),
        );
      },
    ),
  );
}

_remarkWidget() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _hintText("录入备注"),
        pSizeBoxH(8.w),
        Container(
          child: GetBuilder<DirectDeliverController>(
            builder: (ctl) => TextField(
              maxLines: 3,
              minLines: 3,
              controller: TextEditingController.fromValue(
                  TextEditingValue(text: ctl.param.remark ?? "")),
              inputFormatters: CommonUtils.getTextInputFormatter(50),
              style: textStyle(size: 24, color: ColorConfig.color_F3AE1F),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (text) => ctl.param.remark = text,
            ),
          ),
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.w),
            ),
            color: Color(ColorConfig.color_FAFAFA),
          ),
        ),
      ],
    ),
    padding: EdgeInsets.all(30.w),
  );
}

submitBtn() {
  return GetBuilder<DirectDeliverController>(
    builder: (ctl) => GestureDetector(
      child: Container(
        child: pText("确定发货", ColorConfig.color_ffffff, 32.w),
        alignment: Alignment.center,
        height: 96.w,
        margin: EdgeInsets.all(24.w),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.w),
          ),
          color: Color(ColorConfig.color_1678FF),
        ),
      ),
      onTap: () => ctl.createDeliverOrder().then(
        (value) {
          if (value is DeliveryCreateDeliveryReqEntity) {
            showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (_) => CustomDialog(
                type: 1,
                // height: 260,
                outsideDismiss: false,
                content: pText(
                  "确认发货吗？\n发货数超库存，会导致负库存",
                  ColorConfig.color_333333,
                  32.w,
                  fontWeight: FontWeight.bold,
                ),
                confirmTextColor: ColorConfig.color_1678FF,
                confirmContent: "确定",
                confirmCallback: (_) => ctl
                    .createDeliverOrder(checkStock: false)
                    .then((value) => _back(ctl, value)),
              ),
            );
          } else {
            _back(ctl, value);
          }
        },
      ),
    ),
  );
}

_back(DirectDeliverController ctl, dynamic value) {
  int id;
  if (value is int) {
    id = value;
  } else {
    id = value.id;
  }
  BackUtils.back();
  Get.offAndToNamed(
      ArgUtils.map2String(path: Routes.DELIVERY_DETAIL, arguments: {
    Constant.DEPT_ID: ctl.deptId,
    Constant.DELIVERY_ORDER_ID: id,
  }));
}

_hintText(String hint) {
  return pText(
    hint,
    ColorConfig.color_333333,
    28.w,
    fontWeight: FontWeight.bold,
  );
}

/// 选图片弹窗
void _showChooseImgDialog(DirectDeliverController controller) {
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
                onTap: () async => _pickImageFromCamera(controller)
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
                onTap: () async => _pickImageFromGallery(controller)
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

Future<void> _pickImageFromCamera(DirectDeliverController controller) async {
  final PickedFile? pickedFile = (await ImagePicker()
      .getImage(source: ImageSource.camera)
      .whenComplete(() => _setStatusBar()));
  if (pickedFile == null) return;
  controller.upload(pickedFile.path);
}

Future<void> _pickImageFromGallery(DirectDeliverController controller) async {
  final PickedFile? pickedFile = await ImagePicker()
      .getImage(source: ImageSource.gallery)
      .whenComplete(() => _setStatusBar());
  if (pickedFile == null) return;
  controller.upload(pickedFile.path);
}

void _setStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
}
