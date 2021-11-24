import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkCenterIng.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 弹窗：删除图片
 */
class DelImgDialog extends Dialog{

  @override
  Widget build(BuildContext context) {

    return Material(
        child: Container(
          color: Color(ColorConfig.color_88000000),
          alignment: Alignment.center,
          child: Container(
            height: 220.w,
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
                SizedBox(height: 48.w),
                Container(
                  margin: EdgeInsets.fromLTRB(115.w, 0, 115.w, 0),
                  child: Text("确定删除这张照片吗？",style: TextStyle(fontSize: 34.w,color: Color(ColorConfig.color_333333),fontWeight: FontWeight.bold)),
                ),

                SizedBox(height: 30.w),
                Container(color: Color(ColorConfig.color_efefef),height: 1,),
                Container(
                  height: 92.w,
                  child: Row(
                    children: [
                      SizedBox(width: 5,),
                      Expanded(flex: 1,child: FlatButton(child:Text("取消",style: TextStyle(color: Color(ColorConfig.color_999999),fontSize: 32.w,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),highlightColor: Colors.white,splashColor: Colors.white,color: Colors.white,onPressed: (){
                        print("取消");
                        Navigator.pop(context);
                      })),
                      Container(color: Color(ColorConfig.color_efefef),width: 1),
                      Expanded(flex: 1,child: FlatButton(child: Text("确定",style: TextStyle(color: Color(ColorConfig.color_1678FF),fontSize: 32.w,fontWeight: FontWeight.bold),textAlign: TextAlign.center),highlightColor: Colors.white,splashColor: Colors.white,color: Colors.white,onPressed: (){
                        print("确定");
                        Navigator.pop(context);

                        // Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context){
                        //           return CheckCenterIng(); //传值
                        //         }
                        //     )
                        // );

                      },)),
                      SizedBox(width: 5),
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