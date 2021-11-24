import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/common_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/experience/controller/experience_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class ExperienceView extends GetView<ExperienceController> {
  Widget verificationCode() {
    return GetBuilder<ExperienceController>(
        id: "verificationCode",
        builder: (ctl) {
          return pActionText(ctl.getCountdownInfo(), ColorConfig.color_1678FF,
              24.w, 165.w, 60.w, () {
            if (ctl.countdown != 0) {
              return;
            }
            if (ctl.phone.length < 11) {
              toastMsg("请输入11位手机号码");
              return;
            }
            ctl.getVerificationCode();
          }, background: ColorConfig.color_dfefff, radius: 30.w);
        });
  }

  Widget roleItem(String name) {
    return GetBuilder<ExperienceController>(
        id: "roleItem",
        builder: (ctl) {
          var selected = ctl.roleName == name;
          return pActionText(
              name,
              selected ? ColorConfig.color_1678FF : ColorConfig.color_666666,
              24.w,
              (24 + name.length * 26).w,
              48.w, () {
            ctl.roleName = name;
            ctl.update(['roleItem','experienceButtom']);
            ctl.update(["experienceButtom"]);
          },
              background: selected
                  ? ColorConfig.color_dfefff
                  : ColorConfig.color_f5f5f5,
              radius: 30.w);
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExperienceController>(builder: (ctl) {
      return Scaffold(
        appBar: pAppBar('体验'),
        backgroundColor: Color(ColorConfig.color_ffffff),
        body: SingleChildScrollView(
            child: Column(
          children: [
            pSizeBoxH(15.w),
            Row(
              children: [
                pSizeBoxW(30.w),
                pText('*', ColorConfig.color_ff1a43, 30.w, width: 20.w),
                pSizeBoxW(10.w),
                pText('手机号', ColorConfig.color_333333, 30.w,
                    alignment: Alignment.centerLeft, width: 150.w),
                Container(
                    width: 500.w,
                    height: 45.w,
                    // padding: EdgeInsets.all(5.w),
                    // margin: EdgeInsets.fromLTRB(50.w, 0, 50.w, 0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10.w))),
                    child: TextField(
                      // controller: TextEditingController.fromValue(TextEditingValue(text: '${widget.value}')),
                      maxLines: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: CommonUtils.getTextInputFormatter(11),
                      decoration: InputDecoration(
                        hintText: '请输入手机号',
                        counterText: "",
                        hintStyle: TextStyle(
                            fontSize: 30.w,
                            color: Color(ColorConfig.color_999999)),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      autofocus: true,
                      style: TextStyle(
                          fontSize: 30.w,
                          color: Color(ColorConfig.color_333333)),
                      onChanged: (value) {
                        ctl.phone = value;
                        ctl.update(["experienceButtom"]);
                      },
                    )),
                pSizeBoxH(30),
              ],
            ),
            Container(
                // width: 500.w,
                height: 21.w,
                padding: EdgeInsets.only(top: 20.w),
                margin: EdgeInsets.fromLTRB(210.w, 0, 30.w, 0),
                // decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(10.w))),
                child: Container(
                  color: Color(ColorConfig.color_efefef),
                )),
            pSizeBoxH(15.w),
            Row(
              children: [
                pSizeBoxW(30.w),
                pText('*', ColorConfig.color_ff1a43, 30.w, width: 20.w),
                pSizeBoxW(10.w),
                pText('验证码', ColorConfig.color_333333, 30.w,
                    alignment: Alignment.centerLeft, width: 150.w),
                Expanded(
                    child: Container(
                        width: 500.w,
                        height: 45.w,
                        // padding: EdgeInsets.all(5.w),
                        // margin: EdgeInsets.fromLTRB(50.w, 0, 50.w, 0),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.w))),
                        child: TextField(
                          // controller: TextEditingController.fromValue(TextEditingValue(text: '${widget.value}')),
                          maxLines: 10,
                          keyboardType: TextInputType.number,
                          inputFormatters: CommonUtils.getTextInputFormatter(4),
                          decoration: InputDecoration(
                            hintText: '请输入验证码',
                            counterText: "",
                            hintStyle: TextStyle(
                                fontSize: 30.w,
                                color: Color(ColorConfig.color_999999)),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          autofocus: true,
                          style: TextStyle(
                              fontSize: 30.w,
                              color: Color(ColorConfig.color_333333)),
                          onChanged: (value) {
                            ctl.code = value;
                            ctl.update(["experienceButtom"]);
                          },
                        ))),
                verificationCode(),
                pSizeBoxW(30.w),
              ],
            ),
            Container(
                // width: 500.w,
                height: 21.w,
                padding: EdgeInsets.only(top: 20.w),
                margin: EdgeInsets.fromLTRB(210.w, 0, 30.w, 0),
                // decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(10.w))),
                child: Container(
                  color: Color(ColorConfig.color_efefef),
                )),
            pSizeBoxH(15.w),
            Row(
              children: [
                pSizeBoxW(30.w),
                pText('  ', ColorConfig.color_333333, 30.w, width: 20.w),
                pSizeBoxW(10.w),
                pText('称呼', ColorConfig.color_333333, 30.w,
                    alignment: Alignment.centerLeft, width: 150.w),
                Container(
                    width: 500.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10.w))),
                    child: TextField(
                      // controller: TextEditingController.fromValue(TextEditingValue(text: '${widget.value}')),
                      maxLines: 10,
                      inputFormatters: CommonUtils.getTextInputFormatter(11),
                      decoration: InputDecoration(
                        hintText: '请输入',
                        counterText: "",
                        hintStyle: TextStyle(
                            fontSize: 30.w,
                            color: Color(ColorConfig.color_999999)),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      autofocus: true,
                      style: TextStyle(
                          fontSize: 30.w,
                          color: Color(ColorConfig.color_333333)),
                      onChanged: (value) {
                        ctl.name = value;
                        ctl.update(["experienceButtom"]);
                      },
                    )),
                pSizeBoxH(30),
              ],
            ),
            Container(
                // width: 500.w,
                height: 21.w,
                padding: EdgeInsets.only(top: 20.w),
                margin: EdgeInsets.fromLTRB(210.w, 0, 30.w, 0),
                child: Container(
                  color: Color(ColorConfig.color_efefef),
                )),
            pSizeBoxH(21.w),
            Row(children: [
              pSizeBoxW(30.w),
              pText('  ', ColorConfig.color_333333, 30.w, width: 20.w),
              pSizeBoxW(10.w),
              pText('角色', ColorConfig.color_333333, 30.w,
                  alignment: Alignment.centerLeft, width: 150.w),
              roleItem('档口老板'),
              pSizeBoxW(20.w),
              roleItem('店员'),
              pSizeBoxW(20.w),
              roleItem('仓库人员')
            ]),
            pSizeBoxH(15.w),
            Row(children: [
              pSizeBoxW(210.w),
              roleItem('财务'),
              pSizeBoxW(20.w),
              roleItem('设计'),
              pSizeBoxW(20.w),
              roleItem('二批')
            ]),
            pSizeBoxH(15.w),
            pSizeBoxH(15.w),
            Row(
              children: [
                pSizeBoxW(60.w),
                Expanded(
                    child: GetBuilder<ExperienceController>(
                        id: "experienceButtom",
                        builder: (ctl) {
                          return pActionText('立即体验', ColorConfig.color_ffffff,
                              32.w, 630.w, 96.w, () {

                                FocusScope.of(context).requestFocus(FocusNode());
                            if (ctl.phone.length < 11) {
                              toastMsg("请输入11位手机号码");
                              return;
                            }
                            if (ctl.code.length < 4) {
                              toastMsg("请输入4位验证码");
                              return;
                            }
                            if (ctl.name.length < 1) {
                              toastMsg("您的称呼");
                              return;
                            }
                            if (ctl.roleName.length < 1) {
                              toastMsg("请选择角色");
                              return;
                            }

                            ctl.loginExperienceAccount();
                          },
                              background: ctl.experienceButtonEnable()
                                  ? ColorConfig.color_1678FF
                                  : ColorConfig.color_991678FF,
                              radius: 60.w);
                        })),
                pSizeBoxW(60.w),
              ],
            ),
          ],
        )),
      );
    });
  }
}
