import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/model/enum/status.dart';
import 'package:haidai_flutter_module/page/customer/model/merchandiser_user_do_entity.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class PersonDialog extends Dialog {
  List<MerchandiserUserDoEntity> list;
  int? personId;
  Function(int?) onItemClick;
  double top = 0;
  Function onDismiss;

  PersonDialog(this.list, this.personId, this.onItemClick, this.onDismiss, this.top);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            child: Container(height: top),
            behavior: HitTestBehavior.opaque,
            onTap: () => onItemClick.call(null),
          ),
          Container(
            height: 792.w,
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) => itemView(list[index]),
              itemCount: list.length,
            ),
            color: Colors.white,
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                color: Color(ColorConfig.color_88000000),
              ),
              onTap: () => onDismiss.call(),
            ),
          )
        ],
      ),
    );
  }

  Widget itemView(MerchandiserUserDoEntity entity) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        color: Color(personId == entity.id
            ? ColorConfig.color_E7F1FF
            : ColorConfig.color_ffffff),
        height: 92.w,
        child: Row(
          children: [
            pText(
                entity.name ?? "",
                personId == entity.id
                    ? ColorConfig.color_1678FF
                    : ColorConfig.color_333333,
                28.w),
            pText(entity.status == Status.DISABLE ? "（已离职）" : "",
                ColorConfig.color_999999, 28.w),
            Visibility(
              child: Expanded(
                child: Container(
                  child: pImage("images/icon_select_tick.png", 28.w, 28.w),
                  alignment: Alignment.centerRight,
                ),
              ),
              visible: personId == entity.id,
            ),
          ],
        ),
      ),
      onTap: () => onItemClick.call(entity.id!),
    );
  }
}
