import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/common_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/model/enum/CustomerUserStatusEnum.dart';
import 'package:haidai_flutter_module/page/customer/controller/add_customer_controller.dart';
import 'package:haidai_flutter_module/page/customer/model/merchandiser_user_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/widget/discount_widget.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/forbid.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_media_query.dart';
import 'package:haidai_flutter_module/widget/merchandiser_select.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddCustomerView extends GetView<AddCustomerController> {

  var f1 = FocusNode();
  var f2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return KeyboardMediaQuery(
      child: Scaffold(
        appBar: pAppBar("客户"),
        backgroundColor: Colors.white,
        body: GestureDetector(
          child: GetBuilder<AddCustomerController>(
            builder: (ctl) => Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      nameWidget(),
                      phoneWidget(),
                      checkDeadbeatWidget(),
                      exposureWidget(),
                      merchandiserWidget(),
                      taxWidget(),
                      levelWidget(),
                      line(),
                      oftenWidget(),
                      line(),
                      dismissWidget(),
                    ],
                  ),
                ),
                submitWidget(),
              ],
            ),
            id: AddCustomerController.page,
          ),
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // FocusScopeNode currentFocus = FocusScope.of(context);
            // if (!currentFocus.hasPrimaryFocus &&
            //     currentFocus.focusedChild != null) {
            //   FocusManager.instance.primaryFocus?.unfocus();
            // }
            f1.unfocus();
            f2.unfocus();
          },
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  line() {
    return SliverToBoxAdapter(
      child: Container(
        color: Color(ColorConfig.color_efefef),
        height: 1.w,
      ),
    );
  }

  phoneWidget() {
    return SliverToBoxAdapter(
      child: GetBuilder<AddCustomerController>(
        builder: (ctl) => Container(
          // height: 84.w,
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Column(
            children: [
              Row(
                children: [
                  pText("手机号码", ColorConfig.color_000000, 28.w),
                  Expanded(
                    child: TextField(
                      focusNode: f1,
                      keyboardType: TextInputType.phone,
                      style: textStyle(bold: true),
                      controller: TextEditingController.fromValue(
                          TextEditingValue(text: controller.phone ?? "")),
                      textAlign: TextAlign.right,
                      onChanged: (text) => controller.updatePhone(text),
                      decoration: InputDecoration(
                        hintText: "请输入",
                        hintStyle: textStyle(color: ColorConfig.color_999999),
                        border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0.0)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 0.0)),
                      ),
                    ),
                  ),
                  pSizeBoxW(24.w),
                  GestureDetector(
                    child: pImage("images/icon_connecter_book.png", 50.w, 50.w),
                    onTap: () => MethodChannel(ChannelConfig.flutterToNative)
                        .invokeMethod(ChannelConfig.methodAddressBook)
                        .then((value) {
                      print("flutter_tag==========$value");
                      controller.updateName(value["name"]);
                      controller.updatePhone(value['phone']);
                      controller.update([
                        AddCustomerController.idPhone,
                        AddCustomerController.idName
                      ]);
                    }),
                  ),
                ],
              ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   margin: EdgeInsets.only(top: 14.w),
              //   child: pText(
              //       "填写正确的手机号码，客户可以接收到我们的物流服务通知", ColorConfig.color_999999, 24.w),
              // ),
            ],
          ),
        ),
        id: AddCustomerController.idPhone,
      ),
    );
  }

  nameWidget() {
    return SliverToBoxAdapter(
      child: GetBuilder<AddCustomerController>(
        builder: (ctl) => Container(
          // height: 84.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Row(
            children: [
              pText("姓名称呼", ColorConfig.color_000000, 28.w),
              pText("*", ColorConfig.color_ff3715, 28.w),
              Expanded(
                child: TextField(
                  focusNode: f2,
                  style: textStyle(bold: true),
                  controller: TextEditingController.fromValue(
                      TextEditingValue(text: controller.name ?? "")),
                  textAlign: TextAlign.right,
                  onChanged: (text) => controller.updateName(text),
                  inputFormatters: CommonUtils.getTextInputFormatter(12),
                  decoration: InputDecoration(
                    hintText: "请输入",
                    hintStyle: textStyle(color: ColorConfig.color_999999),
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0.0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        id: AddCustomerController.idName,
      ),
    );
  }

  levelWidget() {
    return SliverToBoxAdapter(
      child: Container(
        height: 84.w,
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Row(
          children: [
            Expanded(
                child: pText("客户等级", ColorConfig.color_333333, 28.w,
                    textAlign: TextAlign.start)),
            levelBtn(AddCustomerController.idLevelA, "A 销售价"),
            pSizeBoxW(20.w),
            levelBtn(AddCustomerController.idLevelB, "B 拿货价"),
            pSizeBoxW(20.w),
            levelBtn(AddCustomerController.idLevelC, "C 打包价"),
          ],
        ),
      ),
    );
  }

  levelBtn(String id, String text) {
    return GetBuilder<AddCustomerController>(
      builder: (ctl) {
        var isSelect = ctl.isSelectLevel(id);
        var textColor =
            isSelect ? ColorConfig.color_ffffff : ColorConfig.color_666666;
        var bgColor =
            isSelect ? ColorConfig.color_FFA523 : ColorConfig.color_ffffff;
        var shapeStyle = isSelect ? BorderStyle.none : BorderStyle.solid;
        return InkWell(
          child: Container(
            height: 72.w,
            width: 136.w,
            alignment: Alignment.center,
            child: pText(text, textColor, 24.w),
            decoration: ShapeDecoration(
                color: Color(bgColor),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      style: shapeStyle,
                      color: Color(ColorConfig.color_efefef)),
                  borderRadius: BorderRadius.circular(37.w),
                )),
          ),
          onTap: () => ctl.updateLevel(id),
        );
      },
      id: id,
    );
  }

  submitWidget() {
    return Forbid(
      child: Container(
        margin: EdgeInsets.all(24.w),
        height: 96.w,
        decoration: ShapeDecoration(
          color: Color(ColorConfig.color_1678ff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.w),
          ),
        ),
        alignment: Alignment.center,
        child: pText("确定", ColorConfig.color_ffffff, 32.w),
      ),
      onTap: () => controller.createCustomer().then(
          (value) => controller
              .getCustomerData(value is bool ? controller.customerId : value)
              .then((value) => BackUtils.back(result: value))
              .then((value) => Future.delayed(Duration(milliseconds: 150))),
          onError: (t) => t),
    );
  }

  oftenWidget() {
    return SliverToBoxAdapter(
      child: Container(
        child: Row(
          children: [
            pSizeBoxW(24.w),
            pText("常用客户", ColorConfig.color_333333, 28.w),
            Expanded(
                child: pText("（客户列表优先靠前显示）", ColorConfig.color_999999, 28.w,
                    textAlign: TextAlign.start)),
            GetBuilder<AddCustomerController>(
              builder: (ctl) {
                return pSwitch(
                  value: ctl.isOften(),
                  onChanged: (often) => controller.updateOften(often),
                  width: 92.w,
                  height: 52.w,
                );
              },
              id: AddCustomerController.idOften,
            ),
            pSizeBoxW(36.w),
          ],
        ),
        margin: EdgeInsets.only(top: 40.w, bottom: 50.w),
      ),
    );
  }

  taxWidget() {
    return SliverToBoxAdapter(
      child: GetBuilder<AddCustomerController>(
        builder: (ctl) => GestureDetector(
          child: Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Row(
              children: [
                pText("默认税率", ColorConfig.color_333333, 28.w),
                Expanded(
                  child: pText(
                    PriceUtils.priceString(ctl.tax),
                    ColorConfig.color_333333,
                    28.w,
                    textAlign: TextAlign.end,
                  ),
                ),
                pSizeBoxW(5.w),
                pImage("images/icon_goto.png", 23.w, 23.w),
              ],
            ),
            height: 84.w,
          ),
          onTap: () {
            showTaxDialog(Get.context!, ctl.tax, (tax) => ctl.updateTax(tax));
          },
        ),
        id: AddCustomerController.idTax,
      ),
    );
  }

  merchandiserWidget() {
    return SliverToBoxAdapter(
      child: GetBuilder<AddCustomerController>(
        builder: (ctl) => GestureDetector(
          child: Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Row(
              children: [
                pText("跟单人", ColorConfig.color_333333, 28.w),
                Expanded(
                  child: pText(
                    ctl.merchandiserName,
                    ColorConfig.color_333333,
                    28.w,
                    textAlign: TextAlign.end,
                  ),
                ),
                pSizeBoxW(5.w),
                pImage("images/icon_goto.png", 23.w, 23.w),
              ],
            ),
            height: 84.w,
          ),
          onTap: () {
            showCupertinoModalBottomSheet(
              context: Get.context!,
              animationCurve: Curves.easeIn,
              builder: (context) => MerchandiserSelect(
                deptId: ctl.deptId,
                statusEnum: CustomerUserStatusEnum.ENABLE,
                selectMerchandiserId: ctl.merchandiserId,
                callBack: (int selectMerchandiserId,
                    String selectedMerchandiserName) {
                  var merchandiser = MerchandiserUserDoEntity();
                  merchandiser.name = selectedMerchandiserName;
                  merchandiser.id = selectMerchandiserId;
                  ctl.updateMerchandiser(merchandiser);
                },
              ),
            );
          },
        ),
        id: AddCustomerController.idMerchandiser,
      ),
    );
  }

  exposureWidget() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(top: 30.w, bottom: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pText("去曝光，提醒其他店家", ColorConfig.color_999999, 24.w),
              pSizeBoxW(9.w),
              pImage("images/icon_goto.png", 23.w, 23.w),
            ],
          ),
        ),
        onTap: () => Get.toNamed(ArgUtils.map2String(
            path: Routes.EXPOSURE,
            arguments: {
              Constant.DEPT_ID: controller.deptId,
              Constant.PHONE: controller.phone
            })),
      ),
    );
  }

  checkDeadbeatWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 30.w, left: 24.w, right: 24.w),
        padding: EdgeInsets.only(
          left: 48.w,
          right: 48.w,
          top: 12.w,
          bottom: 12.w,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pSizeBoxH(12.w),
                pText(
                  "客户手机号智能老赖检测",
                  ColorConfig.color_282940,
                  30.w,
                  fontWeight: FontWeight.bold,
                ),
                pSizeBoxH(10.w),
                pText("大数据分析，及时提醒对“老赖” 不赊不欠", ColorConfig.color_999999, 28.w,
                    width: 395.w, maxLines: 2, textAlign: TextAlign.start),
                pSizeBoxH(12.w),
              ],
            ),
            Expanded(child: Container()),
            GetBuilder<AddCustomerController>(
              builder: (ctl) {
                var text;
                var bgColor;
                var textColor;
                switch (ctl.checkState) {
                  case AddCustomerController.stateInit:
                    text = "立即检测";
                    bgColor = ColorConfig.color_1678FF;
                    textColor = ColorConfig.color_ffffff;
                    break;
                  case AddCustomerController.stateChecking:
                    text = "检测中...";
                    bgColor = ColorConfig.color_CCCCCC;
                    textColor = ColorConfig.color_ffffff;
                    break;
                  case AddCustomerController.stateEmpty:
                  case AddCustomerController.stateRecord:
                    text = "重新检测";
                    bgColor = ColorConfig.color_ffffff;
                    textColor = ColorConfig.color_999999;
                    break;
                }
                return Column(
                  children: [
                    Visibility(
                      child:
                          pImage("images/icon_check_deadbeat.png", 70.w, 72.w),
                      visible: ctl.checkState ==
                              AddCustomerController.stateInit ||
                          ctl.checkState == AddCustomerController.stateChecking,
                    ),
                    Visibility(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              pImage("images/done_icon.png", 30.w, 30.w),
                              pSizeBoxW(14.w),
                              pText("暂未检测到", ColorConfig.color_1678FF, 24.w),
                            ],
                          ),
                          Row(
                            children: [
                              pSizeBoxW(44.w),
                              pText("赖账记录", ColorConfig.color_1678FF, 24.w),
                            ],
                          ),
                        ],
                      ),
                      visible:
                          ctl.checkState == AddCustomerController.stateEmpty,
                    ),
                    Visibility(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              pImage("images/warning_icon.png", 30.w, 30.w),
                              pSizeBoxW(14.w),
                              pText(
                                "${ctl.checkRecordNum}条关联记录",
                                ColorConfig.color_ff3715,
                                24.w,
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: Row(
                              children: [
                                pSizeBoxW(44.w),
                                pText("点击查看", ColorConfig.color_ff3715, 24.w),
                              ],
                            ),
                            onTap: () => Get.toNamed(ArgUtils.map2String(
                                path: Routes.EXPOSURERECORD,
                                arguments: {
                                  Constant.DEPT_ID: ctl.deptId,
                                  Constant.PHONE: ctl.phone
                                })),
                          ),
                        ],
                      ),
                      visible:
                          ctl.checkState == AddCustomerController.stateRecord,
                    ),
                    pSizeBoxH(14.w),
                    GestureDetector(
                      child: pText(
                        text,
                        textColor,
                        24.w,
                        fontWeight: FontWeight.bold,
                        width: 164.w,
                        height: 52.w,
                        background: bgColor,
                        radius: 29.w,
                      ),
                      onTap: () => ctl.checkDeadbeat(),
                    ),
                  ],
                );
              },
              id: AddCustomerController.idCheck,
            ),
          ],
        ),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.w),
          ),
          color: Color(ColorConfig.color_ECEFFA),
        ),
      ),
    );
  }

  dismissWidget() {
    return SliverToBoxAdapter(
      child: GetBuilder<AddCustomerController>(
        builder: (ctl) => Visibility(
          child: Container(
            child: Row(
              children: [
                pText("停用", ColorConfig.color_FF3715, 28.w),
                Expanded(child: Container()),
                pSwitch(
                  value: ctl.isDismiss,
                  onChanged: (value) => ctl.updateDismiss(value),
                  width: 92.w,
                  height: 52.w,
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 24.w, right: 34.w),
            margin: EdgeInsets.only(top: 40.w),
          ),
          visible: ctl.customerId != null,
        ),
        id: AddCustomerController.idDismiss,
      ),
    );
  }
}
