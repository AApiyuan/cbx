import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkCenterIng.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/repository/check_api.dart';

/**
 * 弹窗：撤销盘点
 */
class CancelCheckDialog extends Dialog{

  final int planId;
  CancelCallBack cancelCallBack;

  CancelCheckDialog(this.planId, this.cancelCallBack);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          color: Color(ColorConfig.color_88000000),
          alignment: Alignment.center,
          child: Container(
            height: 340.w,
            width: 550.w,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.r),
                      ))),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(65.w, 0, 65.w, 0),
                  height: 220.w,
                  alignment: Alignment.center,
                  child: Text("撤销盘点任务会把盘点调整的库存撤销，撤销后不能继续该盘点，但可以查看盘点详情",style: TextStyle(fontSize: 34.w,color: Color(ColorConfig.color_333333),fontWeight: FontWeight.bold)),
                ),
                Container(color: Color(ColorConfig.color_efefef),height: 1),
                Container(
                  height: 88.w,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(flex: 1,child: FlatButton(child:Text("取消",style: TextStyle(color: Color(ColorConfig.color_999999),fontSize: 32.w,fontWeight: FontWeight.bold),textAlign: TextAlign.center),color: Colors.white,onPressed: (){
                        print("取消");
                        Navigator.pop(context);
                      })),
                      Container(color: Color(ColorConfig.color_efefef),width: 1),
                      Expanded(flex: 1,child: FlatButton(child: Text("确定",style: TextStyle(color: Color(ColorConfig.color_ff3715),fontSize: 32.w,fontWeight: FontWeight.bold),textAlign: TextAlign.center),color: Colors.white,onPressed: (){
                        print("确定");

                        CheckApi.checkCancel(planId).then((value) {

                          cancelCallBack.callBack();
                          Navigator.pop(context);

                        }, onError: (e) {
                          print("flutter:   error1:$e");
                        });

                      })),
                    ],
                  ),
                )
              ],
            ),
          )
        )
    );
  }
}