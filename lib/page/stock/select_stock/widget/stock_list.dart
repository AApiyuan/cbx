import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/stock/model/req/stock_page_req.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/controller/select_stock_controller.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/widget/stock_filter.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/widget/table_header.dart';
import 'package:haidai_flutter_module/repository/order/stock_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class StockListView extends StatefulWidget {
  final List data;

  StockListView({Key? key, required this.data}) : super(key: key);

  @override
  StockListViewState createState() => StockListViewState();
}

class StockListViewState extends State<StockListView> {
  late EasyRefreshController _controller;
  int _pageNo = 1; //页码
  int _pageSize = 15; //页数
  final int deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();
  SelectStockController _selectStockController = Get.find<SelectStockController>();

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    loadListData();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void loadListData() {
    _selectStockController.getStockList(pageSize: _pageSize, pageNo: _pageNo).then((v) {
      setState(() {
        if (_pageNo == 1) {
          widget.data.clear();
          widget.data.addAll(v);
        } else {
          widget.data.addAll(v);
        }
      });
      _controller.resetLoadState();
      _controller.finishLoad(noMore: v.length < _pageSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectStockController>(
        id: "stockList",
        builder: (ctl) {
          return Column(
            children: [
              stockFilter(() {
                _pageNo = 1;
                loadListData();
              }),
              tableHeader(),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(bottom: 152.w),
                      child: EasyRefresh.custom(
                          enableControlFinishLoad: false,
                          controller: _controller,
                          header: RefreshUtils.defaultHeader(),
                          footer: RefreshUtils.defaultFooter(),
                          onRefresh: () async {
                            _pageNo = 1;
                            loadListData();
                          },
                          onLoad: () async {
                            await Future.delayed(Duration(seconds: 1), () {
                              _pageNo++;
                              loadListData();
                            });
                          },
                          slivers: <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        ctl.toStockDetail(widget.data[index].id);
                                      },
                                      child: Container(
                                        height: 76.w,
                                        decoration:
                                            BoxDecoration(border: Border(bottom: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 1.w))),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                if (ctl.selectedIds.length > 0) {
                                                  if (widget.data[index].orderGoodsType != ctl.selectType) {
                                                    toastMsg("不能混选正品和次品");
                                                    return;
                                                  }
                                                } else {
                                                  ctl.selectType = widget.data[index].orderGoodsType;
                                                }
                                                if (ctl.selectedIds[widget.data[index].id] == null) {
                                                  ctl.selectedIds[widget.data[index].id] = true;
                                                } else {
                                                  ctl.selectedIds.remove(widget.data[index].id);
                                                }

                                                ctl.update(["check" + widget.data[index].id.toString(), "confirm"]);
                                              },
                                              child: Container(
                                                width: 96.w,
                                                height: 76.w,
                                                decoration: BoxDecoration(
                                                    border: Border(right: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 1.w))),
                                                alignment: Alignment.center,
                                                child: GetBuilder<SelectStockController>(
                                                    id: "check" + widget.data[index].id.toString(),
                                                    builder: (ctl) {
                                                      return pImage(
                                                          ctl.selectedIds[widget.data[index].id] == null
                                                              ? "images/unChecked.png"
                                                              : "images/icon_select_on.png",
                                                          38.w,
                                                          38.w);
                                                    }),
                                              ),
                                            ),
                                            Container(
                                              width: 163.w,
                                              height: 76.w,
                                              decoration: BoxDecoration(
                                                  border: Border(right: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 1.w))),
                                              alignment: Alignment.center,
                                              child: pText(OrderStockTypeEnum.transfer(widget.data[index].orderType), ColorConfig.color_333333, 24.w),
                                            ),
                                            Container(
                                              width: 163.w,
                                              height: 76.w,
                                              decoration: BoxDecoration(
                                                  border: Border(right: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 1.w))),
                                              alignment: Alignment.center,
                                              child: pText(widget.data[index].addNum.toString(), ColorConfig.color_1678ff, 24.w),
                                            ),
                                            Container(
                                              width: 163.w,
                                              height: 76.w,
                                              decoration: BoxDecoration(
                                                  border: Border(right: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 1.w))),
                                              alignment: Alignment.center,
                                              child: pText(widget.data[index].createdByName.toString(), ColorConfig.color_999999, 24.w),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                height: 76.w,
                                                child: pText(
                                                    widget.data[index].customizeTime.toString().substring(0, 10), ColorConfig.color_999999, 24.w),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                                childCount: widget.data.length,
                              ),
                            )
                          ])))
            ],
          );
        });
  }
}
