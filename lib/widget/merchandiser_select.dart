import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haidai_flutter_module/model/enum/CustomerUserStatusEnum.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_relation_do.dart';
import 'package:haidai_flutter_module/page/customer/model/merchandiser_user_do_entity.dart';
import 'package:haidai_flutter_module/repository/base/customer_user.dart';
import 'package:haidai_flutter_module/repository/base/store.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import 'net_image.dart';

class MerchandiserSelect extends StatefulWidget {
  final int deptId;
  int? selectMerchandiserId;
  Function callBack;
  String? title;
  String? statusEnum;//CustomerUserStatusEnum

  MerchandiserSelect({Key? key, required this.deptId, this.selectMerchandiserId, required this.callBack, this.title, this.statusEnum});

  @override
  State<StatefulWidget> createState() {
    return _MerchandiserSelectState();
  }
}

class _MerchandiserSelectState extends State<MerchandiserSelect> {
  List<MerchandiserUserDoEntity> merchandiserData = [];
  String selectedMerchandiserName = "";

  Future getData() async {}

  @override
  void initState() {
    CustomerUserApi.selectMerchandiserByCustomerDeptId(widget.deptId, statusEnum: widget.statusEnum).then((v) {
      setState(() {
        merchandiserData = v;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
        title: widget.title ?? "更改跟单人",
        height: 1432.w,
        showCertain: false,
        child: Container(
            padding: EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 0),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: merchandiserData.length,
                        itemBuilder: (context, index) {
                          return merchandiseItem(merchandiserData[index], index);
                        })),
              ],
            )));
  }

  Widget merchandiseItem(MerchandiserUserDoEntity item, int index) {
    var name = item.name ?? '--';
    if ((item.name?.length ?? 0) > 2) {
      name = "${item.name?.substring(0, 2)}";
    }
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            widget.selectMerchandiserId = item.id;
            selectedMerchandiserName = item.name as String;
          });
          Navigator.pop(context);
          widget.callBack(widget.selectMerchandiserId, selectedMerchandiserName);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 45.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 90.w,
                    height: 90.w,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(color: Color(ColorConfig.color_282940), shape: CircleBorder()),
                    child: pText(name, ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.bold),
                  ),
                  pSizeBoxW(12.w),
                  Container(
                    height: 95.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            pText(item.name ?? '--', ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w400),
                            pSizeBoxW(6.w),
                            pText(item.roleName.toString(), ColorConfig.color_ffbd10, 20.w,
                                height: 36.w, borderColor: ColorConfig.color_ffbd10, radius: 20, padding: EdgeInsets.only(left: 12.w, right: 12.w))
                          ],
                        ),
                        pText(item.bindPhone.toString(), ColorConfig.color_999999, 24.w, fontWeight: FontWeight.w400),
                      ],
                    ),
                  )
                ],
              ),
              pImage(widget.selectMerchandiserId == item.id ? 'images/checked.png' : 'images/unChecked.png', 38.w, 38.w)
            ],
          ),
        ));
  }
}
