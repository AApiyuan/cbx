import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/distribution/controller/distribution_controller.dart';
import 'package:haidai_flutter_module/page/distribution/widget/dept_title.dart';
import 'package:haidai_flutter_module/page/distribution/widget/distribution_confirm.dart';
import 'package:haidai_flutter_module/page/distribution/widget/goods_list_widget.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_media_query.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class DistributionView extends GetView<DistributionController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistributionController>(
        id: "TransferPage",
        builder: (ctl) {
          return KeyboardMediaQuery(
              child: FutureBuilder(
                  future: ctl.init(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      return SafeArea(
                          child: Scaffold(
                        backgroundColor: Color(ColorConfig.color_ffffff),
                        appBar: pAppBar(ctl.appBarTitle, back: true, type: 0),
                        body: Column(
                          children: [deptTitle(), GoodsListWidget()],
                        ),
                        bottomSheet: distributionConfirmWidget(),
                      ));
                    }
                  }));
        });
  }
}
