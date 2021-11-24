import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/storeAdjustment.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 弹窗：撤销盘点
 */
class CancelCheckDialog extends Dialog{
  late CancelCallBack cancelCallBack;
  CancelCheckDialog(CancelCallBack cancelCallBack){
    this.cancelCallBack = cancelCallBack;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          color: Color(ColorConfig.color_88000000),
          alignment: Alignment.center,
          child: Container(
            height: 225.w,
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
                  // margin: EdgeInsets.fromLTRB(105, 0, 30, 0),
                  height: 130.w,
                  alignment: Alignment.center,
                  child: Text("确定结束本次盘点吗？",style: TextStyle(fontSize: 34.w,color: Color(ColorConfig.color_333333),fontWeight: FontWeight.bold)),
                ),

                Container(color: Color(ColorConfig.color_efefef),height: 1),
                Container(
                  height: 88.w,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(flex: 1,child: FlatButton(child:Text("取消",style: TextStyle(color: Color(ColorConfig.color_999999),fontSize: 32.w,fontWeight: FontWeight.bold),textAlign: TextAlign.center),color: Colors.white,onPressed: (){
                        print("取消");
                        Navigator.pop(context);
                      })),
                      Container(color: Color(ColorConfig.color_efefef),width: 1),
                      Expanded(flex: 1,child: FlatButton(child: Text("确定",style: TextStyle(color: Color(ColorConfig.color_ff3715),fontSize: 32.w,fontWeight: FontWeight.bold),textAlign: TextAlign.center),color: Colors.white,onPressed: (){

                        cancelCallBack.callBack();
                        Navigator.pop(context);

                      },)),
                      SizedBox(width: 10),
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