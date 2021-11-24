import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_status.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget TransferOrderStatus({required String orderType, required String status}) {
  return Container(
    width: double.infinity,
    child: Column(
      children: [
        Row(
          children: [
            Visibility(
              visible: orderType == TransferOrderTypeEnum.APPLY,
              child: Container(
                  width: 214.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      pImage("images/icon_check_center_02.png", 40.w, 40.w),
                      Container(padding: EdgeInsets.fromLTRB(6.w, 0, 10.w, 0), child: pText('待出库', ColorConfig.color_44D75C, 24.w)),
                      Expanded(
                        child: Container(
                          color: Color(
                              status != TransferStatusEnum.WAIT_STOCK_OUT ? ColorConfig.color_44D75C : ColorConfig.color_dcdcdc),
                          height: 3.w,
                          width: double.infinity,
                        ),
                      )
                    ],
                  )),
            ),
            Container(
                width: 155.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    pImage(
                        status != TransferStatusEnum.WAIT_STOCK_OUT ? "images/icon_check_center_02.png" : "images/icon_no.png",
                        40.w,
                        40.w),
                    Container(
                        padding: EdgeInsets.fromLTRB(6.w, 0, 10.w, 0),
                        child: pText(
                            '已出待收',
                            status != TransferStatusEnum.WAIT_STOCK_OUT ? ColorConfig.color_44D75C : ColorConfig.color_999999,
                            24.w)),
                  ],
                )),
            Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Color((status != TransferStatusEnum.WAIT_STOCK_OUT &&
                            status != TransferStatusEnum.WAIT_STOCK_IN)
                            ? ColorConfig.color_44D75C
                            : ColorConfig.color_dcdcdc),
                        height: 3.w,
                        width: double.infinity,
                      ),
                    ),
                    pImage(
                        (status != TransferStatusEnum.WAIT_STOCK_OUT &&
                            status != TransferStatusEnum.WAIT_STOCK_IN)
                            ? "images/icon_check_center_02.png"
                            : "images/icon_no.png",
                        40.w,
                        40.w),
                    Container(
                        padding: EdgeInsets.fromLTRB(6.w, 0, 10.w, 0),
                        child: pText(
                            '已收货',
                            (status != TransferStatusEnum.WAIT_STOCK_OUT &&
                                status != TransferStatusEnum.WAIT_STOCK_IN)
                                ? ColorConfig.color_44D75C
                                : ColorConfig.color_999999,
                            24.w)),
                  ],
                )),
            Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(status == TransferStatusEnum.FINISH ? ColorConfig.color_44D75C : ColorConfig.color_dcdcdc),
                        height: 3.w,
                        width: double.infinity,
                      ),
                    ),
                    pImage(
                        status == TransferStatusEnum.FINISH ? "images/icon_check_center_02.png" : "images/icon_no.png", 40.w, 40.w),
                    Container(
                        padding: EdgeInsets.fromLTRB(6.w, 0, 10.w, 0),
                        child: pText(
                            '完成', status == TransferStatusEnum.FINISH ? ColorConfig.color_44D75C : ColorConfig.color_999999, 24.w)),
                  ],
                ))
          ],
        ),
      ],
    ),
  );;
}
