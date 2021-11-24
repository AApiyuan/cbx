import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';
import 'package:haidai_flutter_module/repository/base/store_remit_method_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class RemitMethodDialog extends StatefulWidget {
  int depId;
  int? selectId;
  Function(StoreRemitMethodDoEntity)? onSelect;
  bool filterSelect;

  RemitMethodDialog(
    this.depId, {
    this.selectId,
    this.onSelect,
    this.filterSelect = false,
  });

  @override
  State<StatefulWidget> createState() {
    return _RemitMethodDialogState();
  }
}

class _RemitMethodDialogState extends State<RemitMethodDialog> {
  var data = <StoreRemitMethodDoEntity>[];
  int selectIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRemitMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        pText(
          "修改退款方式会影响财务统计，请谨慎修改",
          ColorConfig.color_FF5D1E,
          24.w,
          background: ColorConfig.color_FFFCD9,
          width: double.infinity,
          height: 58.w,
          alignment: Alignment.center,
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (_, index) => item(index),
            itemCount: data.length,
            separatorBuilder: (_, index) => Divider(
              color: Color(ColorConfig.color_efefef),
              indent: 30.w,
              endIndent: 30.w,
              thickness: 1.w,
            ),
          ),
        ),
        pText(
          "确定",
          ColorConfig.color_ffffff,
          32.w,
          height: 96.w,
          margin: EdgeInsets.all(24.w),
          alignment: Alignment.center,
          radius: 48.w,
          background: ColorConfig.color_1678FF,
          onTap: () {
            if (selectIndex != -1) {
              widget.onSelect?.call(data[selectIndex]);
              Get.back();
            } else
              toastMsg("请选择");
          },
        ),
      ],
    );
  }

  item(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        child: Row(
          children: [
            pImage(
              selectIndex == index
                  ? "images/icon_select_on.png"
                  : "images/icon_select_off.png",
              38.w,
              38.w,
            ),
            pSizeBoxW(20.w),
            pText(data[index].remitMethodName ?? "", ColorConfig.color_333333,
                28.w),
          ],
        ),
        height: 96.w,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 30.w),
      ),
      onTap: () => setState(() => selectIndex = index),
    );
  }

  void loadRemitMethod() {
    StoreRemitMethodApi.getRemitMethodByDept(widget.depId)
        .then((value) => filter(value))
        .then((value) => data = value)
        .then((value) => selectIndex =
            value.indexWhere((element) => element.id == widget.selectId))
        .then((value) => setState(() => {}));
  }

  List<StoreRemitMethodDoEntity> filter(List<StoreRemitMethodDoEntity> value) {
    if (widget.filterSelect) {
      value.removeWhere((element) => element.id == widget.selectId);
    }
    return value;
  }
}
