import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit_record/controller/bi_remit_record_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';
import 'package:haidai_flutter_module/repository/base/store_remit_method_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class SelectRemitMethodDraw extends StatefulWidget {
  Function callBack;
  int deptId;
  List<int>? selected;

  SelectRemitMethodDraw({Key? key, required this.callBack, required this.deptId, this.selected});

  @override
  State<StatefulWidget> createState() {
    return _SelectDeptDrawState();
  }
}

class _SelectDeptDrawState extends State<SelectRemitMethodDraw> {
  List<StoreRemitMethodDoEntity> remitMethods = [];
  List<int> selectedIds = [];
  String selectedDeptName = "";

  Future getData() async {}

  @override
  void initState() {
    super.initState();
    BiRemitRecordController ctl = Get.find<BiRemitRecordController>();
    StoreRemitMethodApi.getRemitMethodByDept(widget.deptId).then((v) {
      remitMethods = v;
      selectedIds.addAll(ctl.remitMethodIds);
      setState(() {
        remitMethods.forEach((element) {
          if (selectedIds.contains(element.id)) {
            element.selected = true;
          } else {
            element.selected = false;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 600.w,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(30.w, 160.w, 30.w, 50.w),
        color: Color(ColorConfig.color_282940),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: pText('收款账户', ColorConfig.color_ffffff, 32.w),
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                //解决无限高度问题
                physics: new NeverScrollableScrollPhysics(), itemCount: remitMethods.length,
                itemBuilder: (BuildContext context, int index) {
                  return pText(remitMethods[index].remitMethodName.toString(), ColorConfig.color_ffffff, 28.w,
                      width: double.infinity, height: 72.w, margin: EdgeInsets.only(top: 20.w), onTap: () {
                    remitMethods[index].selected = !remitMethods[index].selected;
                    setState(() {});
                  },
                      borderColor: ColorConfig.color_393a58,
                      background: remitMethods[index].selected ? ColorConfig.color_393a58 : ColorConfig.color_282940,
                      radius: 10.w);
                },
              ),
            ))),
            pSizeBoxH(30.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pText('重置', ColorConfig.color_ffffff, 28.w, width: 200.w, height: 84.w, onTap: () {
                  setState(() {
                    remitMethods.forEach((element) {
                      element.selected = false;
                    });
                  });
                  selectedIds = [];
                }, borderColor: ColorConfig.color_393a58, background: ColorConfig.color_282940, radius: 10.w),
                pSizeBoxW(20.w),
                pText('确定', ColorConfig.color_282940, 28.w, width: 320.w, height: 84.w, onTap: () {
                  Navigator.pop(Get.context as BuildContext);
                  selectedIds = [];
                  remitMethods.forEach((element) {
                    if (element.selected) {
                      selectedIds.add(element.id as int);
                    }
                  });
                  widget.callBack(selectedIds);
                }, borderColor: ColorConfig.color_ffffff, background: ColorConfig.color_ffffff, radius: 10.w),
              ],
            )
          ],
        ));
  }
}
