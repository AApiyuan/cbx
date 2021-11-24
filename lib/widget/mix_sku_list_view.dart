import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'p_common.dart';

class MixSkuListView extends StatefulWidget {
  final String? tag; //唯一标识，如果只有一个列表，可为空，主要是做控制
  final controller;
  final List data;
  final Map<int, List> skuMap;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final uniKey;

  var thirdTag; //第三块名称
  var thirdTagName; //第三块对应取值内容
  var thirdTagColor;
  var navigateThird; //是否取反
  var fourTag; //第四块名称
  var fourTagName; //第四块对应取值内容
  var fourTagColor;
  var navigateFour; //是否取反
  var fiveTag; //第五块名称
  var fiveTagName; //第五块对应取值内容
  var fiveTagColor;
  var navigateFive; //是否取反

  var compareTag; //比较的列 值为 thirdTag,fourTag,fiveTag
  var comparedTag; //被比较的列 thirdTag,fourTag,fiveTag
  final int equalColor; //超过列的颜色
  final int differentColor; //不超过列的颜色

  var showNavigateTag; //突出显示负数的列

  //主item
  final dynamic mainItem;

  //头部item
  final List<dynamic>? topItem;
  final String mainItemType;

  MixSkuListView(
      {Key? key,
      required this.controller,
      this.tag,
      this.uniKey = "goodsId",
      required this.data,
      required this.skuMap,
      required this.mainItem,
      required this.mainItemType,
      this.topItem,
      this.shrinkWrap = false,
      this.physics = const AlwaysScrollableScrollPhysics(),
      required this.thirdTagName,
      required this.thirdTag,
      this.thirdTagColor = ColorConfig.color_666666,
      this.navigateThird = false,
      this.fourTagName,
      this.fourTag,
      this.fourTagColor = ColorConfig.color_666666,
      this.navigateFour = false,
      this.fiveTagName,
      this.fiveTag,
      this.fiveTagColor = ColorConfig.color_666666,
      this.navigateFive = false,
      this.compareTag,
      this.comparedTag,
      this.equalColor = ColorConfig.color_1678ff,
      this.differentColor = ColorConfig.color_FA6400,
      this.showNavigateTag})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MixSkuListViewState();
  }
}

class _MixSkuListViewState extends State<MixSkuListView> {
  Map<int, int> childNumMap = new Map();

  StreamSubscription<AddGoodsEvent>? _subscription;

  ItemScrollController? _itemScrollController;

  @override
  void initState() {
    widget.thirdTagColor = widget.thirdTagColor ?? ColorConfig.color_666666;
    widget.fourTagColor = widget.fourTagColor ?? ColorConfig.color_666666;
    widget.fiveTagColor = widget.fiveTagColor ?? ColorConfig.color_666666;
    //初始化map
    super.initState();
    _itemScrollController = new ItemScrollController();
    if (widget.topItem != null) {
      for (int i = widget.topItem!.length; i != 0; i--) {
        widget.data.insert(0, widget.topItem![i - 1]);
      }
    }

    _subscription = eventBus.on<AddGoodsEvent>().listen((event) async {
      if (event.tag != null && event.tag != widget.tag) {
        return;
      }

      if (event.goodsId == -1) {
        //全部 收起指令
        closeAll();
      }
      if (event.goodsId == -2) {
        //全部 展开指令
        openAll();
      }
    });
  }

  //页面销毁
  @override
  void dispose() {
    //释放
    super.dispose();
    _subscription!.cancel();
    // _scrollController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
        //解决无限高度问题
        physics: widget.physics,
        itemCount: widget.data.length,
        itemScrollController: _itemScrollController,
        itemBuilder: (context, index) {
          // print('this is index = $index');
          // print(widget.data[index].runtimeType.toString());
          if (widget.data[index].runtimeType.toString() == "_InternalLinkedHashMap<dynamic, dynamic>" && widget.data[index]['itemType'] == 'title') {
            return title(widget.thirdTagName, widget.fourTagName, widget.fiveTagName);
          }
          if (widget.data[index].runtimeType.toString() == "_InternalLinkedHashMap<dynamic, dynamic>" && widget.data[index]['itemType'] == 'sku') {
            return mixSku(widget.data[index], index);
          }
          // ignore: unrelated_type_equality_checks
          if (widget.data[index].runtimeType.toString() == widget.mainItemType) {
            return widget.mainItem(index, this);
          } else {
            return widget.data[index] as Widget;
          }
        });
  }

  //操作一个组件打开或者关闭
  operator(int index, int key) {
    if (childNumMap[key] == null) {
      expandSku(index, key);
    } else {
      closeSku(index, key);
    }
  }

  //关闭所有
  closeAll() {
    List newData = [];
    for (var item in widget.data) {
      if (item.runtimeType.toString() != "_InternalLinkedHashMap<dynamic, dynamic>") {
        newData.add(item);
      }
    }
    widget.data.clear();
    childNumMap.clear();
    setState(() {
      widget.data.addAll(newData);
    });
  }

  //展开所有
  openAll() {
    List newData = [];

    for (var item in widget.data) {
      if (item.runtimeType.toString() == widget.mainItemType) {
        newData.add(item);
        List<dynamic> skuData = transferSku(item.toJson()[widget.uniKey]);
        Map map = new Map();
        map['itemType'] = 'title';
        map['thirdTagName'] = widget.thirdTagName;
        map['fourTagName'] = widget.fourTagName;
        map['fiveTagName'] = widget.fiveTagName;
        skuData.insert(0, map);
        childNumMap[item.toJson()[widget.uniKey]] = skuData.length;
        newData.addAll(skuData);
      }
    }
    setState(() {
      widget.data.clear();
      if (widget.topItem != null) {
        widget.topItem!.forEach((element) {
          widget.data.add(element);
        });
      }
      newData.forEach((element) {
        widget.data.add(element);
      });
    });
  }

  expandSku(int index, int key) {
    List<dynamic> skuData = transferSku(key);
    insertSkuData(key, index, skuData);
  }

  closeSku(int index, int key) {
    setState(() {
      widget.data.removeRange(index + 1, index + 1 + childNumMap[key]!);
      childNumMap.remove(key);
    });
  }

  insertSkuData(int key, int index, List<dynamic> skuData) {
    Map map = new Map();
    map['itemType'] = 'title';
    map['thirdTagName'] = widget.thirdTagName;
    map['fourTagName'] = widget.fourTagName;
    map['fiveTagName'] = widget.fiveTagName;
    skuData.insert(0, map);
    childNumMap[key] = skuData.length; //记录插入数量，方便删除
    setState(() {
      widget.data.insertAll((index + 1), skuData);
    });
  }

  List<dynamic> transferSku(int key) {
    List skus = widget.skuMap[key] as List;
    List<dynamic> result = [];
    for (int i = 0; i < skus.length; i++) {
      for (int j = 0; j < skus[i]['sizes'].length; j++) {
        var item = skus[i]['sizes'][j];
        Map map = new Map();
        map['itemType'] = 'sku';
        map['key'] = key;
        map['group'] = key.toString() + skus[i]['goodsColor']['name'];
        map['skuId'] = item['data']['skuId'];
        map['color'] = skus[i]['goodsColor']['name'];
        map['size'] = item['goodsSize']['name'];
        if (skus[i]['sizes'].length > 1) {
          map['childIndex'] = j + 1;
        } else {
          map['childIndex'] = -1;
        }
        map['skuIndex'] = [i, j];
        map['thirdTag'] = item['data'][widget.thirdTag] ?? 0;
        if (widget.navigateThird) {
          map['thirdTag'] = -map['thirdTag'];
        }
        if (widget.fourTag != null) {
          map['fourTag'] = item['data'][widget.fourTag] ?? 0;
          if (widget.navigateFour) {
            map['fourTag'] = -map['fourTag'];
          }
        }
        if (widget.fiveTag != null) {
          map['fiveTag'] = item['data'][widget.fiveTag] ?? 0;
          if (widget.navigateFive) {
            map['fiveTag'] = -map['fiveTag'];
          }
        }

        map['showLine'] = false;
        map['showText'] = false;
        if (j == 0) {
          map['showText'] = true;
        }
        if (j == skus[i]['sizes'].length - 1) {
          map['showLine'] = true;
          map['showText'] = true;
          if (skus[i]['sizes'].length > 1) {
            map['showText'] = false;
          }
        }
        result.add(map);
      }
    }
    return result;
  }

  Widget title(String thirdTagName, var fourTagName, var fiveTagName) {
    return RepaintBoundary(
        child: Container(
      margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
      height: 74.w,
      decoration: const BoxDecoration(
        color: const Color(ColorConfig.color_f5f5f5),
        border: Border(bottom: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 147.w,
            height: 74.w,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 0.5)),
            ),
            child: pText("颜色", ColorConfig.color_666666, 24.w),
          ),
          Container(
            width: 147.w,
            height: 74.w,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5)),
            ),
            child: pText("尺码", ColorConfig.color_666666, 24.w),
          ),
          Container(
            width: 147.w,
            height: 74.w,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5)),
            ),
            child: pText(thirdTagName, ColorConfig.color_666666, 24.w),
          ),
          Visibility(
              visible: fourTagName != null,
              child: Container(
                width: 147.w,
                height: 74.w,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5)),
                ),
                child: pText(fourTagName.toString(), ColorConfig.color_666666, 24.w),
              )),
          Expanded(
            child: Visibility(
                visible: fiveTagName != null,
                child: Container(
                  height: 74.w,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5)),
                  ),
                  child: pText(fiveTagName.toString(), ColorConfig.color_666666, 24.w),
                )),
          )
        ],
      ),
    ));
  }

  Widget mixSku(var item, int index) {
    return RepaintBoundary(
        child: Container(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
            height: 74.w,
            decoration: new BoxDecoration(
              color: const Color(ColorConfig.color_ffffff),
            ),
            child: Row(
              children: [
                Container(
                  height: 74.w,
                  width: 147.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5),
                        left: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5),
                        bottom: BorderSide(color: Color(item['showLine'] ? ColorConfig.color_dcdcdc : ColorConfig.color_ffffff), width: 0.5)),
                  ),
                  child: item['showText'] ? pText(item['color'], ColorConfig.color_666666, 28.w) : null,
                ),
                Container(
                  width: 147.w,
                  height: 74.w,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5),
                        bottom: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5)),
                  ),
                  child: pText(item['size'], ColorConfig.color_666666, 28.w),
                ),
                Container(
                  width: 147.w,
                  height: 74.w,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5),
                        bottom: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5)),
                  ),
                  child: pText(
                      item['thirdTag'].toString(),
                      widget.compareTag == 'thirdTag'
                          ? (item[widget.compareTag] != item[widget.comparedTag] ? widget.differentColor : widget.equalColor)
                          : ((widget.showNavigateTag == 'thirdTag' && item['thirdTag'] < 0) ? ColorConfig.color_FA6400 : widget.thirdTagColor),
                      32.w),
                ),
                Container(
                  width: 147.w,
                  height: 74.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5),
                        right: BorderSide(
                            color: widget.fourTag != null ? const Color(ColorConfig.color_dcdcdc) : const Color(ColorConfig.color_ffffff),
                            width: 0.5)),
                  ),
                  child: pText(
                      widget.fourTag != null ? item['fourTag'].toString() : "",
                      widget.compareTag == 'fourTag'
                          ? (item[widget.compareTag] != item[widget.comparedTag] ? widget.differentColor : widget.equalColor)
                          : ((widget.showNavigateTag == 'fourTag' && item['fourTag'] < 0) ? ColorConfig.color_FA6400 : widget.fourTagColor),
                      32.w),
                ),
                Expanded(
                  child: Container(
                    height: 74.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5),
                          bottom: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5)),
                    ),
                    child: pText(
                        widget.fiveTag != null ? item['fiveTag'].toString() : "",
                        widget.compareTag == 'fiveTag'
                            ? (item[widget.compareTag] != item[widget.comparedTag] ? widget.differentColor : widget.equalColor)
                            : ((widget.showNavigateTag == 'fiveTag' && item['fiveTag'] < 0) ? ColorConfig.color_FA6400 : widget.fiveTagColor),
                        32.w),
                  ),
                )
              ],
            )));
  }
}
