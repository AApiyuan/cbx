import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/enum/customer_dept_status.dart';
import 'package:haidai_flutter_module/model/enum/customer_dept_type.dart';
import 'package:haidai_flutter_module/model/store/req/dept_and_relation_req.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_detail_and_role_do.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';
import 'package:haidai_flutter_module/repository/bi/bi_dept_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class SelectDeptDraw extends StatefulWidget {
  Function callBack;

  SelectDeptDraw({Key? key, required this.callBack});

  @override
  State<StatefulWidget> createState() {
    return _SelectDeptDrawState();
  }
}

class _SelectDeptDrawState extends State<SelectDeptDraw> {
  List<CustomerDeptDetailAndRoleDo> deptData = [];
  List<int> selectedIds = [];
  String selectedDeptName = "";

  Future getData() async {}

  @override
  void initState() {
    DeptAndRelationReq deptAndRelationReq = new DeptAndRelationReq();
    deptAndRelationReq.deptTypes = [CustomerDeptTypeEnum.SHOP_AND_STOREHOUSE];
    deptAndRelationReq.returnRelation = false;
    deptAndRelationReq.returnRoleName = false;
    deptAndRelationReq.status = CustomerDeptStatusEnum.ENABLE;
    UserApi.selectByLoginCustomerUserAndAppBi(deptAndRelationReq).then((value) {
      BiDeptApi.getDeptSelected(showOnlyHasAuth: false).then((v) {
        setState(() {
          List deptIds = [];
          if (value.length == 0) {
            selectedIds = [];
          } else {
            value.forEach((element) {
              deptIds.add(element.id);
            });
          }

          selectedIds = v.where((element) => deptIds.contains(element)).toList();
          value.forEach((element) {
            if (selectedIds.contains(element.id)) {
              element.selected = true;
            }
          });
          deptData = value;
        });
      });
    });
    super.initState();
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
              child: pText('店铺', ColorConfig.color_ffffff, 32.w),
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Container(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: deptData.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 20.w,
                  childAspectRatio: 260.0 / 72,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return pText(deptData[index].name.toString(), deptData[index].selected ? ColorConfig.color_282940 : ColorConfig.color_ffffff, 28.w, width: 260.w, height: 72.w, onTap: () {
                    deptData[index].selected = !deptData[index].selected;
                    selectedIds.clear();
                    deptData.forEach((element) {
                      if (element.selected) {
                        selectedIds.add(element.id as int);
                      }
                    });
                    setState(() {});
                  },
                      borderColor: ColorConfig.color_393a58,
                      background: deptData[index].selected ? ColorConfig.color_ffffff : ColorConfig.color_282940,
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
                    deptData.forEach((element) {
                      // if (selectedIds.contains(element.id)) {
                      //   element.selected = true;
                      // } else {
                      //   element.selected = false;
                      // }
                      element.selected = false;
                    });
                    selectedIds = [];
                  });
                }, borderColor: ColorConfig.color_393a58, background: ColorConfig.color_282940, radius: 10.w),
                pSizeBoxW(20.w),
                pText('确定${selectedIds.length > 0 ? "(${selectedIds.length})" : ''}', ColorConfig.color_282940, 28.w, width: 320.w, height: 84.w,
                    onTap: () {
                  Navigator.pop(Get.context as BuildContext);
                  selectedIds.clear();
                  deptData.forEach((element) {
                    if (element.selected) {
                      selectedIds.add(element.id as int);
                    }
                  });
                  BiDeptApi.setDeptSelected(selectedIds);
                  widget.callBack(selectedIds);
                }, borderColor: ColorConfig.color_ffffff, background: ColorConfig.color_ffffff, radius: 10.w),
              ],
            )
          ],
        ));
  }
}
