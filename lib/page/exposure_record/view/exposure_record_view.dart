import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/common_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';

// import 'package:haidai_flutter_module/page/exposure/controller/exposure_controller.dart';
import 'package:haidai_flutter_module/page/exposure_record/controller/exposure_record_controller.dart';
import 'package:haidai_flutter_module/page/exposure_record/model/customer_risk_article_entity.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:path/path.dart';

class ExposureRecordView extends GetView<ExposureRecordController> {
  bool show = true;
  ExposureRecordController ctl = Get.find<ExposureRecordController>();
  EasyRefreshController _controller = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExposureRecordController>(
        id: "exposureview",
        builder: (ctl) {
          return Scaffold(
              appBar: pAppBar('关联记录'),
              backgroundColor: Color(ColorConfig.color_ffffff),
              body: EasyRefresh.custom(
                  enableControlFinishLoad: false,
                  controller: _controller,
                  header: RefreshUtils.defaultHeader(),
                  footer: RefreshUtils.defaultFooter(),
                  onRefresh: () async {
                    ctl.pageNo = 1;
                    ctl.getRetailStoreCustomer();
                  },
                  onLoad: () async {
                    await Future.delayed(Duration(seconds: 1), () {
                      ctl.pageNo++;
                      ctl.getRetailStoreCustomer();
                    });
                  },
                  slivers: <Widget>[
                    GetBuilder<ExposureRecordController>(builder: (ctl) {
                      if (ctl.data.length == 0) {
                        return SliverToBoxAdapter(
                          child: Center(
                              child: emptyWidget(
                                  bgColor: ColorConfig.color_00000000)),
                        );
                      } else {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (ctl.data.length == 0) {
                                return SliverToBoxAdapter(
                                  child: Center(
                                      child: emptyWidget(
                                          bgColor: ColorConfig.color_00000000)),
                                );
                              }
                              return getItemContainer(ctl.data[index], index);

                            },
                            childCount: ctl.data.length,
                          ),
                        );
                      }
                    }),
                  ]));
        });
  }

  Future<void> showActionSheet(BuildContext context) async {
    return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            // title: Text("123456"),
            // message: Text("123456"),

            actions: [
              CupertinoActionSheetAction(
                  onPressed: () {
                    ctl.show = true;
                    ctl.update(["exposureview"]);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      pSizeBoxW(10.w),
                      pImage(
                          !ctl.show
                              ? "images/unChecked.png"
                              : "images/checked.png",
                          40.w,
                          40.w),
                      pSizeBoxW(20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pText('显示', ColorConfig.color_333333, 34.w),
                          pText('全国所有店铺及人员可见', ColorConfig.color_999999, 28.w)
                        ],
                      )
                    ],
                  )),
              CupertinoActionSheetAction(
                  onPressed: () {
                    ctl.show = false;
                    ctl.update(["exposureview"]);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      pSizeBoxW(10.w),
                      pImage(
                          ctl.show
                              ? "images/unChecked.png"
                              : "images/checked.png",
                          40.w,
                          40.w),
                      pSizeBoxW(20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pText('不显示', ColorConfig.color_333333, 34.w),
                          pText('只本公司可见店铺名称，其他显示“***”',
                              ColorConfig.color_999999, 28.w)
                        ],
                      )
                    ],
                  ))
            ],
          );
        });
  }

  Widget getItemContainer(CustomerRiskArticleEntity item, int recordIndex) {
    List imgs = item.contentImgs!.split(',');
    List images = [];

    imgs.forEach((element) {
      if(element != ""){
        images.add(element);
      }
    });


    return Column(children: [
      pSizeBoxH(15.w),
      Row(
        children: [
          pSizeBoxW(24.w),
          NetImageWidget(
            item.logo!,
            height: 54,
            width: 54,
              clickEnable:true
          ),
          pSizeBoxW(24.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pText(item.showDept == "YES"?item.deptName! : item.deptName![0] + "***", ColorConfig.color_333333, 24.w),
              pSizeBoxH(5.w),
              pText(item.createdTime!, ColorConfig.color_999999, 22.w)
            ],
          )
        ],
      ),
      pSizeBoxH(10.w),
      Visibility(
        visible: item.content!.length > 0,
        child: Container(
          padding:EdgeInsets.only(left: 24.w, right: 24.w),
          alignment: Alignment.centerLeft,
          child: pText(
            item.content!,
            ColorConfig.color_333333,
            28.w,
            textAlign: TextAlign.start,
            alignment: Alignment.centerLeft,
            maxLines: 999),),
      ),

      GetBuilder<ExposureRecordController>(
          id: "gridview",
          builder: (ctl) {
            int line = (images.length) ~/ 3 + 1;

            if(images.length < 4){
              line = 1;
            }
            if(images.length == 0){
              return pSizeBoxH(10.w);
            }
            return Container(
                // width: 500.w,
                height: (line * 236 + 48).w,
                padding: EdgeInsets.all(24.w),
                child: GridView.builder(
                  physics: new NeverScrollableScrollPhysics(),
                  //禁用滑动事件
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: 230.w,
                        height: 236.w,
                        child: NetImageWidget(
                          item.imgPath! + images[index],
                          height: 230,
                          width: 230,
                        ));
                  },
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      //单个子Widget的水平最大宽度
                      maxCrossAxisExtent: 230.w,
                      //水平单个子Widget之间间距
                      mainAxisSpacing: 6.0.w,
                      //垂直单个子Widget之间间距
                      crossAxisSpacing: 6.0.w),
                ));
          }),
      Container(height: 20.w,color:Color(ColorConfig.color_f5f5f5,) ,)
    ]);
  }
}
