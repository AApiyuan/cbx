import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/controller/bi_customer_controller.dart';
import 'package:haidai_flutter_module/page/bi/widget/select_dept_draw.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bi_customer_owe.dart';
import 'bi_customer_sale.dart';

class BiCustomer extends StatefulWidget {
  BiCustomer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BiCustomerState();
}

class _BiCustomerState extends State<BiCustomer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GetBuilder<BiCustomerController>(
        builder: (ctl) {
          _tabController.index = ctl.type;
          return Scaffold(
            backgroundColor: Color(ColorConfig.color_ffffff),
            endDrawer: ctl.singleDept
                ? null
                : SelectDeptDraw(
                    callBack: (List<int> ids) {
                      ctl.updateDeptIdList(ids);
                    },
                  ),
            appBar: pAppBar(
              '',
              type: 1,
              actions: ctl.singleDept
                  ? null
                  : [
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Row(
                            children: [
                              GetBuilder<BiCustomerController>(
                                builder: (ctl) => pText(
                                  "${ctl.customerDeptIds.length == 0 ? "全部" : "${ctl.customerDeptIds.length}个"}店铺",
                                  ColorConfig.color_ffffff,
                                  27.w,
                                ),
                                id: BiCustomerController.idDeptTotal,
                              ),
                              pImage("images/icon_down.png", 24.w, 24.w)
                            ],
                          ),
                        );
                      }),
                      pSizeBoxW(20.w),
                    ],
              backIconColor: ColorConfig.color_ffffff,
              backgroundColor: ColorConfig.color_282940,
              title: Container(
                height: 88.w,
                padding: EdgeInsets.only(bottom: 8.w),
                color: Color(ColorConfig.color_282940),
                child: TabBar(
                  onTap: (index) {
                    print(index);
                  },
                  labelColor: Color(ColorConfig.color_ffffff),
                  labelPadding: EdgeInsets.only(
                      bottom: 10.w, top: 0.w, right: 24.w, left: 24.w),
                  isScrollable: true,
                  labelStyle: TextStyle(
                      fontSize: 32.w,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  unselectedLabelColor: Color.fromRGBO(255, 255, 255, 0.7),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 32.w,
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      fontWeight: FontWeight.w400),
                  controller: _tabController,
                  indicatorWeight: 8.w,
                  indicatorPadding: EdgeInsets.only(left: 70.w, right: 70.w),
                  indicatorColor: Color(ColorConfig.color_ffffff),
                  tabs: ['销售分析', "欠款欠货"].map((e) => Tab(text: e)).toList(),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      BiCustomerSale(),
                      BiCustomerOwe(ctl),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      onWillPop: () {
        BackUtils.back();
        return new Future.value(false);
      },
    );
  }
}
