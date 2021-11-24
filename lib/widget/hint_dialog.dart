import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class HintDialog extends Dialog {
  HintDialog(
    this.context, {
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.hideTitle,
    required this.content,
    required this.contentTextColor,
    this.contentTextStyle,
    required this.negativeText,
    required this.negativeTextColor,
    this.negativeCallBack,
    required this.positiveText,
    required this.positiveTextColor,
    this.positiveCallBack,
    required this.singleButton,
    required this.cancelable,
    this.singleCallBack,
    required this.singleButtonText,
    required this.singleButtonTextColor,
    this.contentWidget,
    required this.autoDismiss,
    required this.hideButton,
  }) : super(key: key);

  final BuildContext context;

  /// 高度
  final double height;

  /// 宽度
  final double width;

  /// 标题
  final String title;

  /// 是否隐藏标题
  final bool hideTitle;

  /// 内容
  final String content;

  /// 内容文本颜色
  final Color contentTextColor;

  /// 内容文本样式
  final TextStyle? contentTextStyle;

  /// 取消按钮文本
  final String negativeText;

  /// 取消按钮文本颜色
  final Color negativeTextColor;

  /// 取消按钮点击回调
  final DialogCallBack? negativeCallBack;

  /// 确定按钮文本
  final String positiveText;

  /// 确定按钮文本颜色
  final Color positiveTextColor;

  /// 确定按钮点击回调
  final DialogCallBack? positiveCallBack;

  /// 是否单按钮
  final bool singleButton;

  /// 单按钮文本
  final String singleButtonText;

  /// 单按钮文本颜色
  final Color singleButtonTextColor;

  /// 单按钮点击回调
  final DialogCallBack? singleCallBack;

  /// 是否可触摸关闭
  final bool cancelable;

  /// 自定义内容
  final Widget? contentWidget;

  /// 自定隐藏对话框
  final bool autoDismiss;

  /// 隐藏按钮
  final bool hideButton;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () {
                if (cancelable) {
                  dismiss();
                }
              },
            ),
            _buildContentView(),
          ],
        ),
      ),
    );
  }

  /// 构建对话框内容
  Widget _buildContentView() {
    return Center(
      child: Container(
        width: width.w,
        height: height.w,
        decoration: ShapeDecoration(
          color: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.w)),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(),
            Expanded(
              child: Center(
                child: contentWidget ?? _buildDefaultContent(),
              ),
            ),
            Visibility(
              child: Divider(color: Color(ColorConfig.color_efefef), height: 1),
              visible: !hideButton,
            ),
            Visibility(
              child: _buildButtonRow(),
              visible: !hideButton,
            ),
          ],
        ),
      ),
    );
  }

  /// 构建标题
  Widget _buildTitle() {
    return Visibility(
      child: Padding(
        padding: EdgeInsets.only(top: 45.w),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 30.w,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      visible: !hideTitle,
    );
  }

  /// 构建内容
  Widget _buildDefaultContent() {
    return Container(
      padding: EdgeInsets.only(left: 24.w, right: 24.w),
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: contentTextStyle ??
            TextStyle(fontSize: 32.w, color: contentTextColor),
      ),
    );
  }

  /// 构建按钮行
  Widget _buildButtonRow() {
    return SizedBox(
      width: double.infinity,
      height: 88.w,
      child: singleButton ? _buildSingleButton() : _buildTowButton(),
    );
  }

  /// 构建两个按钮
  Widget _buildTowButton() {
    return Row(
      children: [
        Expanded(
          child:
              _buildButton(negativeText, negativeTextColor, negativeCallBack),
        ),
        Container(width: 1, color: Color(0xFFEFEFEF)),
        Expanded(
          child:
              _buildButton(positiveText, positiveTextColor, positiveCallBack),
        ),
      ],
    );
  }

  /// 构建单个按钮
  Widget _buildSingleButton() {
    return _buildButton(
        singleButtonText, singleButtonTextColor, singleCallBack);
  }

  /// 构建按钮
  Widget _buildButton(String text, Color color, DialogCallBack? callback) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 32.w, color: color),
      ),
      style:
          ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.black12)),
      onPressed: () {
        if (autoDismiss) {
          dismiss();
        }
        callback?.call(this);
      },
    );
  }

  /// 隐藏对话框
  void dismiss() {
    Navigator.pop(context);
  }
}

typedef DialogCallBack = void Function(HintDialog dialog);

class HintDialogUtil {
  static BuildContext? _context;

  HintDialogUtil._();

  /*factory HintDialogUtil() => _getInstance();

  static HintDialogUtil get instance => _getInstance();
  static HintDialogUtil _instance;

  HintDialogUtil._internal() {
    // 初始化
  }*/

  // 是否显示
  static bool isShow = false;

  /*static HintDialogUtil _getInstance() {
    if (_instance == null) {
      _instance = HintDialogUtil._internal();
    }
    return _instance;
  }*/

  /// 显示弹窗
  static void show({
    Key? key,
    double height = 418.0,
    double width = 550.0,
    String title = "默认标题",
    bool hideTitle = false,
    String content = "",
    Color contentTextColor = const Color(0xFF999999),
    TextStyle? contentTextStyle,
    String negativeText = "取消",
    Color negativeTextColor = const Color(0xFF999999),
    DialogCallBack? negativeCallBack,
    String positiveText = "确定",
    Color positiveTextColor = const Color(0xFF1678FF),
    DialogCallBack? positiveCallBack,
    bool singleButton = false,
    bool cancelable = true,
    DialogCallBack? singleCallBack,
    String singleButtonText = "",
    Color singleButtonTextColor = const Color(0xFF999999),
    Widget? contentWidget,
    bool autoDismiss = true,
    bool hideButton = false,
  }) {
    if (Get.context != null) {
      showDialog(
        context: Get.context!, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          _context = ctx;
          isShow = true;
          return HintDialog(
            ctx,
            height: height,
            width: width,
            title: title,
            hideTitle: hideTitle,
            content: content,
            contentTextColor: contentTextColor,
            contentTextStyle: contentTextStyle,
            negativeText: negativeText,
            negativeTextColor: negativeTextColor,
            negativeCallBack: negativeCallBack,
            positiveText: positiveText,
            positiveTextColor: positiveTextColor,
            positiveCallBack: positiveCallBack,
            singleButton: singleButton,
            cancelable: cancelable,
            singleCallBack: singleCallBack,
            singleButtonText: singleButtonText,
            singleButtonTextColor: singleButtonTextColor,
            contentWidget: contentWidget,
            autoDismiss: autoDismiss,
            hideButton: hideButton,
          );
        },
      );
    }
  }

  static void dismiss() {
    if (_context != null && isShow) {
      Navigator.pop(_context!);
      isShow = false;
      _context = null;
    }
  }
}
