import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/classify_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

// ignore: must_be_immutable
class ClassifyDialog extends StatelessWidget {
  final _controller = Get.put(ClassifyController());
  late BuildContext _context;
  Function(Map<String, StoreDictData?>)? onClassifyTap;
  Function? onClose;

  ClassifyDialog(
    Map<String, List<StoreDictData>?> classifyData, {
    int? big,
    int? middle,
    int? small,
    this.onClassifyTap,
    this.onClose,
  }) {
    _controller.initData(classifyData, big: big, middle: middle, small: small);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 740.w,
          width: double.infinity,
          child: Material(
            type: MaterialType.canvas,
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(top: 30.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.w),
                    topLeft: Radius.circular(30.w)),
                color: Colors.white,
              ),
              child: _createDialogContainer(),
            ),
          ),
        ),
      ),
      color: Colors.black87,
    );
  }

  /// 创建内容
  Widget _createDialogContainer() {
    return Column(
      children: [
        _titleBar(),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(top: 46.w),
            child: Row(
              children: [
                _classify("大类", ClassifyController.CLASSIFY),
                _classify("中类", ClassifyController.CLASSIFY_MIDDLE),
                _classify("小类", ClassifyController.CLASSIFY_SMALL),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleBar() {
    return Row(
      children: [
        GestureDetector(
          child: Padding(
            child: Image.asset(
              "images/home_check_back.png",
              width: 40.w,
              height: 41.w,
              fit: BoxFit.fill,
            ),
            padding: EdgeInsetsDirectional.only(start: 18.w),
          ),
          onTap: () => onClose?.call(),
        ),
        Expanded(
          child: Center(
            child: Text(
              "货品分类",
              style: textStyle(size: 32, bold: true),
            ),
          ),
        ),
        GestureDetector(
          child: Padding(
            child: Text(
              "确定",
              style: textStyle(size: 32, color: ColorConfig.color_1678FF),
            ),
            padding: EdgeInsetsDirectional.only(end: 24.w),
          ),
          onTap: () {
            onClassifyTap?.call(_controller.getSelectMap());
            onClose?.call();
          },
        ),
      ],
    );
  }

  Widget _classify(String classify, String tag) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 10.w),
            child: Text(classify, style: textStyle(size: 32, bold: true)),
          ),
          Expanded(
            child: GetBuilder<ClassifyController>(
              id: tag,
              builder: (ctl) {
                List<StoreDictData>? list = ctl.getClassifyData(tag);
                if (list == null) {
                  return Container();
                }
                return ListView.builder(
                  padding: EdgeInsetsDirectional.zero,
                  itemBuilder: (_, index) {
                    StoreDictData item = list[index];
                    return _classifyItem(tag, index, item);
                  },
                  itemCount: list.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _classifyItem(String tag, int index, StoreDictData item) {
    return Container(
      height: 79.w,
      alignment: Alignment.center,
      child: GetBuilder<ClassifyController>(
        id: "$tag${item.id}",
        builder: (ctl) {
          bool isSelected = ctl.isSelectedClassify(tag, item.id!);
          int textColor =
              isSelected ? ColorConfig.color_333333 : ColorConfig.color_999999;
          return TextButton(
            child: Text(
              item.dictName!,
              style: textStyle(
                size: 24,
                bold: isSelected,
                color: textColor,
              ),
            ),
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(Color(ColorConfig.color_efefef)),
            ),
            onPressed: () => ctl.actionClassify(tag, item.id!),
          );
        },
      ),
    );
  }
}
