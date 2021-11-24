import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';
import 'package:haidai_flutter_module/page/inventory/difference/controller/filter_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

class ClassifyDialog extends StatelessWidget {
  ClassifyDialog(
    this.type,
    this.onClose,
  ) : super();

  final String type;

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    Get.find<FilterController>(tag: type).initClassifyData();
    return GestureDetector(
      child: Container(
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
      ),
      onTap: () {},
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
                _classify("大类", FilterController.CLASSIFY),
                _classify("中类", FilterController.CLASSIFY_MIDDLE),
                _classify("小类", FilterController.CLASSIFY_SMALL),
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
          onTap: () {
            onClose?.call();
          },
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
            Get.find<FilterController>(tag: type)
                .actionConfirmClassifyCondition();
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
            child: GetBuilder<FilterController>(
              id: tag,
              tag: type,
              builder: (ctl) {
                List<StoreDictData> list = ctl.getClassifyData(tag);
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
      child: GetBuilder<FilterController>(
        id: "$tag$index",
        tag: type,
        builder: (ctl) {
          bool isSelected = ctl.isSelectedClassify(tag, index);
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
            onPressed: () => ctl.actionClassify(tag, item, index),
          );
        },
      ),
    );
  }
}
