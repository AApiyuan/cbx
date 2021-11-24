import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_bottom.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_collection_and_refund_card.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_header.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_list.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_order_Info_card.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_user_info_card.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import 'verification_logic.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>
    with TickerProviderStateMixin {
  final logic = Get.find<VerificationLogic>();

  late TabController _tabController;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _tabController = TabController(length: 0, vsync: this);
    logic.tabController = _tabController;

    _textEditingController = TextEditingController();
    logic.textEditingController = _textEditingController;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //this._context = context;
    return WillPopScope(
        child: SafeArea(
          top: false,
          child: Scaffold(
              bottomNavigationBar: BottomAppBar(
                  child: verificationBottom()),
              backgroundColor: Color(ColorConfig.color_f5f5f5),
              appBar: pAppBar("收退/核销",
                  type: 1,
                  backgroundColor: ColorConfig.color_282940, backFunc: () {
                BackUtils.backToNative();
              }),
              body: GetBuilder<VerificationLogic>(builder: (ctl) {
                return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());

                      ctl.updateBottom();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage("images/payment_bg.png"),
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverList(
                            delegate:
                                SliverChildBuilderDelegate((content, index) {
                              return GetBuilder<VerificationLogic>(
                                  builder: (ctl) {
                                return Column(
                                  children: [
                                    userInfoCard(),
                                    collectionAndRefundCard(_tabController,
                                        _textEditingController, context, this),
                                    orderInfoCard(),
                                    pSizeBoxH(20.w),
                                  ],
                                );
                              });
                            }, childCount: 1),
                          ),

                          verificationHeader(),

                          verificationList(),
                        ],
                      ),
                    ));
              })),
        ),
        onWillPop: () {
          BackUtils.backToNative();
          return new Future.value(true);
        });
  }

  @override
  void dispose() {
    Get.delete<VerificationLogic>();
    super.dispose();
  }
}
