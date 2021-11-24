import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/controller/bi_dept_user_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/views/bi_dept_user_owe.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/views/bi_dept_user_sale_view.dart';
import 'package:haidai_flutter_module/page/bi/widget/select_dept_draw.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiDeptUserView extends StatefulWidget {
  BiDeptUserView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BiSaleViewState();
}

class _BiSaleViewState extends State<BiDeptUserView> with SingleTickerProviderStateMixin {
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
    return WillPopScope(child: GetBuilder<BiDeptUserController>(builder: (ctl) {
      return Scaffold(
          backgroundColor: Color(ColorConfig.color_ffffff),
          endDrawer: SelectDeptDraw(
            callBack: (List<int> ids) {
              //店铺选择
              ctl.customerDeptIds = ids;
              ctl.init();
              ctl.update(['deptNum']);
            },
          ),
          appBar: pAppBar(
            '',
            type: 1,
            actions: [
              GetBuilder<BiDeptUserController>(
                  id: "showAll",
                  builder: (ctl) {
                    return Visibility(
                        visible: ctl.deptId == null,
                        child: GetBuilder<BiDeptUserController>(
                            id: "deptNum",
                            builder: (ctl) {
                              return Builder(builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    Scaffold.of(context).openEndDrawer();
                                  },
                                  child: Row(
                                    children: [
                                      pText("${ctl.customerDeptIds.length == 0 ? '全部' : ctl.customerDeptIds.length.toString() + '个'}店铺",
                                          ColorConfig.color_ffffff, 27.w),
                                      pImage("images/icon_down.png", 24.w, 24.w)
                                    ],
                                  ),
                                );
                              });
                            }));
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
                  labelPadding: EdgeInsets.only(bottom: 10.w, top: 0.w, right: 24.w, left: 24.w),
                  isScrollable: true,
                  labelStyle: TextStyle(fontSize: 32.w, color: Colors.white, fontWeight: FontWeight.w500),
                  unselectedLabelColor: Color.fromRGBO(255, 255, 255, 0.7),
                  unselectedLabelStyle: TextStyle(fontSize: 32.w, color: Color.fromRGBO(255, 255, 255, 0.7), fontWeight: FontWeight.w400),
                  controller: _tabController,
                  indicatorWeight: 8.w,
                  indicatorPadding: EdgeInsets.only(left: 70.w, right: 70.w),
                  indicatorColor: Color(ColorConfig.color_ffffff),
                  tabs: ['销售分析', "欠款欠货"]
                      .map((e) => Tab(
                            text: e,
                          ))
                      .toList(),
                )),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  // physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: <Widget>[BiDeptUserSaleView(), BiDeptUserOweView()],
                ),
              ),
            ],
          ));
    }), onWillPop: () {
      BackUtils.back();
      return new Future.value(false);
    });
  }
}
