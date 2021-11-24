import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';

Widget pText(String text, int color, double size,
    {TextAlign textAlign = TextAlign.center,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration decoration = TextDecoration.none,
    bool softWrap = false,
    int? maxLines,
    Color? rgb,
    TextOverflow overflow = TextOverflow.ellipsis,
    String? fontFamily,
    double? width,
    double? height,
    int? borderColor,
    double? radius,
    int background: 0x00000000,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Function? onTap,
    HitTestBehavior behavior: HitTestBehavior.opaque,
    Alignment? alignment}) {
  if (width != null || height != null) {
    if (onTap == null) {
      return Container(
          width: width,
          height: height,
          alignment: alignment ?? Alignment.center,
          padding: padding ?? EdgeInsets.all(0),
          margin: margin ?? EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: Color(background),
              borderRadius: BorderRadius.all(
                  Radius.circular(radius != null ? radius : 0)),
              border: Border.all(
                  width: borderColor != null ? 1.w : 0,
                  color:
                      Color(borderColor == null ? 0x00000000 : borderColor))),
          child: Text(text,
              textAlign: textAlign,
              softWrap: softWrap,
              maxLines: maxLines,
              overflow: overflow,
              style: TextStyle(
                  color: rgb ?? Color(color),
                  fontSize: size,
                  fontWeight: fontWeight,
                  decoration: decoration,
                  fontFamily: fontFamily ?? "")));
    } else {
      return GestureDetector(
        behavior: behavior,
        onTap: () {
          onTap.call();
        },
        child: Container(
            width: width,
            height: height,
            alignment: alignment ?? Alignment.center,
            padding: padding ?? EdgeInsets.all(0),
            margin: margin ?? EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Color(background),
                borderRadius: BorderRadius.all(
                    Radius.circular(radius != null ? radius : 0)),
                border: Border.all(
                    width: borderColor != null ? 1.w : 0,
                    color:
                        Color(borderColor == null ? 0x00000000 : borderColor))),
            child: Text(text,
                textAlign: textAlign,
                softWrap: softWrap,
                maxLines: maxLines,
                overflow: overflow,
                style: TextStyle(
                    color: rgb ?? Color(color),
                    fontSize: size,
                    fontWeight: fontWeight,
                    decoration: decoration,
                    fontFamily: fontFamily ?? ""))),
      );
    }
  }
  return Text(text,
      textAlign: textAlign,
      softWrap: softWrap,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          color: rgb ?? Color(color),
          fontSize: size,
          fontWeight: fontWeight,
          decoration: decoration,
          fontFamily: fontFamily ?? ""));
}

Widget pContainerText(
    String text, int color, double size, double width, double height,
    {int? borderColor,
    double? radius,
    FontWeight fontWeight = FontWeight.w400,
    int background: ColorConfig.color_ffffff,
    EdgeInsetsGeometry? margin}) {
  return Container(
    width: width,
    height: height,
    alignment: Alignment.center,
    padding: EdgeInsets.zero,
    margin: margin ?? EdgeInsets.all(0),
    decoration: BoxDecoration(
        color: Color(background),
        borderRadius:
            BorderRadius.all(Radius.circular(radius != null ? radius : 0)),
        border: Border.all(
            width: borderColor != null ? 1.w : 0,
            color: Color(
                borderColor == null ? ColorConfig.color_ffffff : borderColor))),
    child: pText(text, color, size, fontWeight: fontWeight),
  );
}

Widget pActionText(String text, int color, double size, double width,
    double height, Function onTap,
    {int? borderColor,
    double? radius,
    FontWeight fontWeight = FontWeight.w400,
    int background: ColorConfig.color_ffffff,
    HitTestBehavior behavior: HitTestBehavior.opaque,
    EdgeInsetsGeometry? margin}) {
  return GestureDetector(
      behavior: behavior,
      onTap: () {
        onTap.call();
      },
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        margin: margin ?? EdgeInsets.all(0),
        decoration: BoxDecoration(
            color: Color(background),
            borderRadius:
                BorderRadius.all(Radius.circular(radius != null ? radius : 0)),
            border: Border.all(
                width: borderColor != null ? 1.w : 0,
                color: Color(borderColor == null
                    ? ColorConfig.color_ffffff
                    : borderColor))),
        child: pText(text, color, size, fontWeight: fontWeight),
      ));
}

// class pText extends  StatelessWidget{
//   String text;
//   int color;
//   double size;
//   TextAlign textAlign;
//   FontWeight fontWeight;
//
//   pText(this.text, this.color, this.size,{Key? key,this.textAlign = TextAlign.center, this.fontWeight = FontWeight.w400});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(text, textAlign: textAlign, style: TextStyle(color: Color(color), fontSize: size, fontWeight: fontWeight));
//   }
// }

Widget pImage(String address, double width, double height,
    {BoxFit boxFit = BoxFit.cover, var key}) {
  return Image.asset(
    address,
    width: width,
    height: height,
    fit: boxFit,
    key: key,
  );
}

Widget pSizeBoxW(double width) {
  return SizedBox(
    width: width,
  );
}

Widget pSizeBoxH(double height) {
  return SizedBox(
    height: height,
  );
}

Widget pButton(double width, double height, String text, int color, double size,
    Function() onPressed,
    {double radius = 0.0,
    int background: ColorConfig.color_1678FF,
    FontWeight fontWeight = FontWeight.w400}) {
  return FlatButton(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius))),
    color: new Color(background),
    minWidth: width,
    height: height,
    onPressed: onPressed,
    child: pText(text, color, size, fontWeight: fontWeight),
  );
}

Widget pImageButton(
    String url, double width, double height, Function() onPressed,
    {double radius = 0.0}) {
  return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(image: AssetImage(url)),
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        width: width,
        height: height,
      ));
}

Widget pImageCenterButton(
  String url,
  double width,
  double height,
  Function() onPressed,
  double imgHeight,
  double imgWidth, {
  int background: ColorConfig.color_1678FF,
  double radius = 0.0,
}) {
  return FlatButton(
      padding: EdgeInsets.zero,
      focusNode: FocusNode(skipTraversal: true),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      minWidth: width,
      height: height,
      onPressed: onPressed,
      color: new Color(background),
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: pImage(url, imgHeight, imgWidth), // 设计图
      ));
}

Widget pWidgetButton(
    double width, double height, Widget widget, Function() onPressed,
    {double radius = 0.0}) {
  return FlatButton(
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius))),
    minWidth: width,
    height: height,
    onPressed: onPressed,
    child: widget,
  );
}

/// 导航
/// type : 0 白底（默认），1 蓝底, 2 暗蓝色
PreferredSizeWidget pAppBar(String text,
    {bool back = true,
    int type = 0,
    Widget? title,
    List<Widget>? actions,
    Function? backFunc,
    int? backIconColor,
    double? elevation,
    int? backgroundColor}) {
  var titleWidget;
  if (title != null) {
    titleWidget = title;
  } else {
    titleWidget = pText(text,
        type == 0 ? ColorConfig.color_000000 : ColorConfig.color_ffffff, 34.w,
        fontWeight: FontWeight.bold);
  }
  if (type == 0) {
    backgroundColor = backgroundColor ?? ColorConfig.color_ffffff;
    backIconColor = backIconColor ?? ColorConfig.color_000000;
  }
  if (type == 1) {
    backgroundColor = backgroundColor ?? ColorConfig.color_1678FF;
    backIconColor = backIconColor ?? ColorConfig.color_ffffff;
  }
  if (type == 2) {
    backgroundColor = backgroundColor ?? ColorConfig.color_282940;
    backIconColor = backIconColor ?? ColorConfig.color_ffffff;
  }

  return AppBar(
    title: titleWidget,
    elevation: elevation ?? 0,
    backgroundColor: Color(backgroundColor!),
    centerTitle: true,
    toolbarHeight: 87.w,
    leading: back
        ? Container(
            margin: EdgeInsets.only(left: 0.w),
            child: IconButton(
                iconSize: 34.w,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(backIconColor!),
                ),
                tooltip: "返回",
                onPressed: () {
                  if (backFunc != null) {
                    backFunc.call();
                  } else {
                    BackUtils.back();
                  }
                }),
          )
        : Container(),
    actions: actions ?? [],
  );
}

//height在expand为false时候生效
Widget pBottomSheet(BuildContext context,
    {Widget? child,
    bool showTitle = true,
    title = "",
    Function? onClose,
    String buttonText = "确定",
    double? height,
    Function? onCertain}) {
  return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
          width: double.infinity,
          height: height != null ? height : Get.height,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 150.w),
                decoration: BoxDecoration(
                    color: new Color(ColorConfig.color_ffffff),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.w),
                        topRight: Radius.circular(30.w))),
                child: Container(
                  padding: EdgeInsets.fromLTRB(24.w, 24.w, 24.w, 0),
                  child: Column(
                    children: [
                      Container(
                        height: 60.w,
                        alignment: Alignment.center,
                        child: pText(showTitle ? title : "",
                            ColorConfig.color_333333, 32.w,
                            fontWeight: FontWeight.w600),
                      ),
                      pSizeBoxH(50.w),
                      Expanded(
                          child: ListView.builder(
                              shrinkWrap: true, //解决无限高度问题
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: child,
                                );
                              }))
                    ],
                  ),
                ),
              ),
              new Positioned(
                  top: 0.w,
                  right: 0.w,
                  child: pImageButton("images/close.png", 60.w, 60.w, () {
                    Navigator.pop(Get.context!);
                    if (onClose != null) {
                      onClose();
                    }
                  })),
              new Positioned(
                  bottom: 40.w,
                  child: Container(
                      width: 700.w,
                      margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0.w),
                      child: pButton(
                        double.infinity,
                        96.w,
                        buttonText,
                        ColorConfig.color_ffffff,
                        28.w,
                        () {
                          if (onCertain != null) {
                            onCertain();
                          }
                          Navigator.pop(Get.context!);
                        },
                        radius: 96.w,
                      )))
            ],
          )));
}

Widget pSwitch(
    {required bool value,
    required Function(bool)? onChanged,
    double? width,
    double? height}) {
  return GestureDetector(
    child: pImage(
      value ? "images/icon_switch_on.png" : "images/icon_switch_off.png",
      width ?? 92.w,
      height ?? 52.w,
    ),
    onTap: () => onChanged?.call(!value),
  );
}

Widget pRadio(
    {required dynamic value,
    required dynamic groupValue,
    required Function(dynamic)? onChange,
    double? width,
    double? height}) {
  return InkWell(
    child: pImage(
        value == groupValue
            ? "images/icon_radio_on.png"
            : "images/icon_radio_off.png",
        width ?? 36.w,
        height ?? 36.w),
    onTap: () => onChange?.call(value),
  );
}
