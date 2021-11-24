import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/page/bi/bi_sku/widget/sku.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_manager.dart';
import 'package:haidai_flutter_module/widget/num_change.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'p_common.dart';

/// 用法指南
///
/// 一。controller 层
/// 1.在 controller中 定义变量
///
///     List<dynamic> data = []; //这个用来 承载列表数据，必须是dynamic的
///     Map<int, List> skuMap = new Map(); //承载sku数据，sku获取后更新 到此处 ，键值为  goods的id
///
/// 2. 异步 获取数据
///     deptList = await UserApi.selectDept(deptAndRelationReq, showLoading: false);
///     data.clear();
///     data.addAll(deptList);
///
/// 二。UI层
///            MixSkuEditListView(
///                data: ctl.getData(),
///                 skuMap: ctl.skuMap,
///                 mainItem: storeItem,
///                 controller:ctl,
///                 thirdTagName: "可买",
///                 thirdTag: 'stockNum', //第三列变量
///                 handleTagName: "数量",
///                 handleTag: 'num',
///                 callBack: (int key,skuMap) {
///                   // print(key);
///                   // print(skuMap);
///                   // print(ctl.skuMap);
///                 },
///
///
/// 2.主item
///  GetBuilder<StoreManageController>(
//       id: "goods" + index.toString(),
//       builder: (ctl) {
//         var item = ctl.getData()[index];
//         /**
//          * 这一段非常必要
//          */
//         if (item.runtimeType.toString() != "CustomerDeptDetailAndRoleDo") {
//           CustomerDeptDetailAndRoleDo tmp = new CustomerDeptDetailAndRoleDo();
//           customerDeptDetailAndRoleDoFromJson(tmp, new Map<String, dynamic>.from(item));
//           item = tmp;
//         }
//         /**
//          * 这一段
//          */
///
///
///
///
///
///
///
///
///
class MixSkuEditListView extends StatefulWidget {
  final String? tag; //唯一标识，如果只有一个列表，可为空，主要是做控制
  final controller;
  final List data;
  final Map<int, List> skuMap;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final uniKey;

  final String thirdTag; //第三块名称
  final String thirdTagName; //第三块对应取值内容
  final String thirdTagExtra; //第三块辅助信息
  final String thirdTagNameExtra; //第三块对应取值内容
  final int thirdTagColor;
  final String handleTag; //操作模块名称
  final String handleTagName; //第四块对应取值内容
  final int handleTagColor;
  bool handleOverThird; //操作数是否可以大于第三列
  bool showOneHand;

  //页面渲染完时间
  final Function? postFrameCallback;

  //如果允许负数颜色
  final bool negative;
  final int negativeColor;

  final Function callBack;

  final Function? onKeyBordChange;

  //主item
  final dynamic mainItem;

  //头部item
  final List<dynamic>? topItem;
  final String? mainItemType;

  MixSkuEditListView(
      {Key? key,
      required this.controller,
      this.tag,
      this.uniKey = "goodsId",
      required this.data,
      required this.skuMap,
      required this.mainItem,
      this.mainItemType,
      this.topItem,
      required this.callBack,
      this.shrinkWrap = false,
      this.physics = const ClampingScrollPhysics(),
      required this.thirdTagName,
      required this.thirdTag,
      this.thirdTagNameExtra = '',
      this.thirdTagExtra = '',
      this.thirdTagColor = ColorConfig.color_666666,
      required this.handleTagName,
      required this.handleTag,
      this.handleOverThird = true,
      this.showOneHand = true,
      this.negative = false,
      this.postFrameCallback,
      this.onKeyBordChange,
      this.negativeColor = ColorConfig.color_ff3715,
      this.handleTagColor = ColorConfig.color_1678ff})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MixSkuEditListViewState();
  }
}

class ThemeColorEvent {
  String colorStr;

  ThemeColorEvent(this.colorStr);
}

class _MixSkuEditListViewState extends State<MixSkuEditListView> {
  FocusScopeNode node = FocusScopeNode();
  Map<int, int> childNumMap = new Map();
  ValueNotifier<double> keyboardHeightNotifier = CoolKeyboard.getKeyboardHeightNotifier();

  StreamSubscription<AddGoodsEvent>? _subscription;

  ItemScrollController? _itemScrollController;

  @override
  void initState() {
    //初始化map
    super.initState();
    _itemScrollController = new ItemScrollController();

    if (widget.topItem != null) {
      for (int i = widget.topItem!.length; i != 0; i--) {
        widget.data.insert(0, widget.topItem![i - 1]);
      }
    }

    CoolKeyboard.getKeyboardHeightNotifier().addListener(keyboardHeight);

    _subscription = eventBus.on<AddGoodsEvent>().listen((event) async {
      if (event.tag != null && event.tag != widget.tag) {
        return;
      }
      if (event.fixGoodsId != null && widget.skuMap[event.fixGoodsId] != null) {
        //跳到指定位置,并展开
        int index = 0;
        for (int i = 0; i < widget.data.length; i++) {
          if (widget.topItem != null && i < widget.topItem!.length) {
            continue;
          }
          if (widget.data[i].runtimeType.toString() != "_InternalLinkedHashMap<dynamic, dynamic>") {
            if (widget.data[i].toJson()[widget.uniKey] == event.fixGoodsId) {
              index = i;
            }
          }
        }
        if (childNumMap[event.fixGoodsId] == null) {
          expandSku(index, event.fixGoodsId as int);
        }
        _itemScrollController!.scrollTo(index: index, duration: Duration(milliseconds: 150), curve: Curves.easeIn);
        // });
      } else {
        if (event.goodsId == -1) {
          //全部 收起指令
          closeAll();
        } else {
          //先收起全部
          closeAll();
          int index = widget.data.length - 1;
          operator(widget.data.length - 1, event.goodsId as int);
          //延时500毫秒执行
          Future.delayed(const Duration(milliseconds: 100), () {
            _itemScrollController!.scrollTo(index: index, duration: Duration(milliseconds: 150), curve: Curves.easeIn);
          });
        }
      }
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.postFrameCallback != null) {
        widget.postFrameCallback!.call();
      }
      print("Frame has been rendered");
    });
  }

  dynamic keyboardHeight() {
    if (CoolKeyboard.getKeyboardHeightNotifier().value == 0.0) {
      node.unfocus();
      if (widget.onKeyBordChange != null) {
        widget.onKeyBordChange!.call(false);
      }
    } else {
      if (widget.onKeyBordChange != null) {
        widget.onKeyBordChange!.call(true);
      }
    }
  }

  //页面销毁
  @override
  void dispose() {
    //释放
    super.dispose();
    CoolKeyboard.getKeyboardHeightNotifier().removeListener(keyboardHeight);
    _subscription!.cancel();
    // _scrollController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
        node: node,
        child: ScrollablePositionedList.builder(
            //解决无限高度问题
            physics: widget.physics,
            itemCount: widget.data.length,
            itemScrollController: _itemScrollController,
            addRepaintBoundaries: false,
            itemBuilder: (context, index) {
              // print('this is index = $index');
              // print(widget.data[index].runtimeType.toString());
              if (widget.data[index].runtimeType.toString() == "_InternalLinkedHashMap<dynamic, dynamic>" &&
                  widget.data[index]['itemType'] == 'title') {
                return title(widget.thirdTagName, widget.handleTagName, thirdTagNameExtra: widget.thirdTagNameExtra);
              }
              if (widget.data[index].runtimeType.toString() == "_InternalLinkedHashMap<dynamic, dynamic>" &&
                  widget.data[index]['itemType'] == 'sku') {
                return mixSku(node, widget.data[index], index);
              }
              if (widget.topItem != null) {
                if (widget.data[index].runtimeType.toString() == widget.mainItemType) {
                  return widget.mainItem(index, this);
                } else {
                  return widget.data[index] as Widget;
                }
              } else {
                return widget.mainItem(index, this);
              }
            }));
  }

  //操作一个组件打开或者关闭
  operator(int index, int key) {
    if (childNumMap[key] == null) {
      expandSku(index, key);
      Future.delayed(const Duration(milliseconds: 100), () {
        _itemScrollController!.scrollTo(index: index, duration: Duration(milliseconds: 150), curve: Curves.easeIn);
      });
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

  //删除主元素，同时删除 sku
  delete(int index, int key) {
    setState(() {
      if (childNumMap[key] != null) {
        widget.data.removeRange(index, index + 1 + childNumMap[key]!);
        childNumMap.remove(key);
      } else {
        widget.data.removeAt(index);
      }
    });
  }

  expandSku(int index, int key) {
    List<dynamic> skuData = transferSku(key);
    insertSkuData(key, index, skuData,
        thirdTagName: widget.thirdTagName,
        thirdTagNameExtra: widget.thirdTagNameExtra,
        handleTagName: widget.handleTag);
  }

  closeSku(int index, int key) {
    setState(() {
      widget.data.removeRange(index + 1, index + 1 + childNumMap[key]!);
      childNumMap.remove(key);
    });
  }

  fill(int goodsId) {
    var skus = widget.skuMap[goodsId];
    for (int i = 0; i < skus!.length; i++) {
      for (int j = 0; j < skus[i]['sizes'].length; j++) {
        var item = skus[i]['sizes'][j];
        item['data'][widget.handleTag] = item['data'][widget.thirdTag];
      }
    }
    widget.skuMap[goodsId] = skus;
    List<String> tags = [];
    for (var item in widget.data) {
      if (item.runtimeType.toString() == "_InternalLinkedHashMap<dynamic, dynamic>" &&
          item['itemType'] == 'sku' &&
          item['key'] == goodsId) {
        item['handleTag'] = item['thirdTag'];
        tags.add('innerSkuRow' + item['skuId'].toString());
      }
    }
    widget.controller.update(tags);
  }

  fillClear(int goodsId) {
    var skus = widget.skuMap[goodsId];
    for (int i = 0; i < skus!.length; i++) {
      for (int j = 0; j < skus[i]['sizes'].length; j++) {
        var item = skus[i]['sizes'][j];
        item['data'][widget.handleTag] = 0;
      }
    }
    widget.skuMap[goodsId] = skus;
    List<String> tags = [];
    for (var item in widget.data) {
      if (item.runtimeType.toString() == "_InternalLinkedHashMap<dynamic, dynamic>" &&
          item['itemType'] == 'sku' &&
          item['key'] == goodsId) {
        item['handleTag'] = 0;
        tags.add('innerSkuRow' + item['skuId'].toString());
      }
    }
    widget.controller.update(tags);
  }

  //叠加更新
  updateAdd(skus, map, int goodsId, index) {
    if (widget.negative == false) {
      for (int i = 0; i < skus.length; i++) {
        for (int j = 0; j < skus[i]['sizes'].length; j++) {
          var item = skus[i]['sizes'][j];
          if (map[item['data']['skuId']] != null) {
            if (item['data'][widget.handleTag] != null && item['data'][widget.handleTag] < 0) {
              item['data'][widget.handleTag] = null;
            }
          }
        }
      }
    }

    if (widget.handleOverThird == false) {
      for (int i = 0; i < skus.length; i++) {
        for (int j = 0; j < skus[i]['sizes'].length; j++) {
          var item = skus[i]['sizes'][j];
          if (map[item['data']['skuId']] != null) {
            if (item['data'][widget.handleTag] != null &&
                item['data'][widget.handleTag] > item['data'][widget.thirdTag]) {
              item['data'][widget.handleTag] = item['data'][widget.thirdTag];
            }
          }
        }
      }
    }
    widget.skuMap[goodsId] = skus;
    List<String> tags = [];
    for (var item in widget.data) {
      if (item.runtimeType.toString() == "_InternalLinkedHashMap<dynamic, dynamic>" && item['itemType'] == 'sku') {
        if (map[item['skuId']] != null) {
          if (item['handleTag'] == null) {
            item['handleTag'] = 0;
          }
          item['handleTag'] = item['handleTag'] + map[item['skuId']];
          if (widget.negative == false && item['handleTag'] != null && item['handleTag'] < 0) {
            item['handleTag'] = null;
          }
          if (widget.handleOverThird == false && item['handleTag'] != null && item['handleTag'] > item['thirdTag']) {
            item['handleTag'] = item['thirdTag'];
          }
        }

        if (item['key'] == goodsId && item['size'] == "一手") {
          item['handleTag'] = null;
          tags.add('innerSkuRow' + item['skuId'].toString());
        }
      }
    }

    map.keys.forEach((key) {
      tags.add('innerSkuRow' + key.toString());
    });
    widget.controller.update(tags);
    // //回调
    int itemAdd = 0;
    int itemMinus = 0;
    for (int i = 0; i < skus.length; i++) {
      for (int j = 0; j < skus[i]['sizes'].length; j++) {
        if (skus[i]['sizes'][j]['data'][widget.handleTag] != null) {
          var num = skus[i]['sizes'][j]['data'][widget.handleTag] as int;
          if (num > 0) {
            itemAdd += num;
          } else {
            itemMinus += num;
          }
        }
      }
    }
    widget.callBack(goodsId, index, itemAdd, itemMinus);
  }

  insertSkuData(int key, int index, List<dynamic> skuData,
      {String? thirdTagName, String thirdTagNameExtra = '', String? handleTagName}) {
    Map map = new Map();
    map['itemType'] = 'title';
    map['thirdTagName'] = thirdTagName;
    if (thirdTagNameExtra != '') {
      map['thirdTagNameExtra'] = thirdTagNameExtra;
    }
    map['handleTagName'] = handleTagName;
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
      if (skus[i]['sizes'].length > 1 && widget.showOneHand) {
        //添加一手
        Map map = new Map();
        map['itemType'] = 'sku';
        map['group'] = key;
        map['key'] = key;
        map['color'] = skus[i]['goodsColor']['name'];
        map['size'] = '一手';
        // map['handleTag'] = null;
        map['thirdTag'] = widget.thirdTag == "" ? "" : 0;
        map['skuId'] = -1;
        map['childSize'] = skus[i]['sizes'].length;
        map['showLine'] = false;
        map['showText'] = true;
        result.add(map);
      }
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
        map['thirdTag'] = widget.thirdTag == "" ? "" : (item['data'][widget.thirdTag] ?? 0);
        if (widget.thirdTagNameExtra != '') {
          map['thirdTagExtra'] = item['data'][widget.thirdTagExtra].toString();
        }
        map['handleTag'] = item['data'][widget.handleTag];
        if (j == skus[i]['sizes'].length - 1) {
          map['showLine'] = true;
          map['showText'] = true;
          if (skus[i]['sizes'].length > 1) {
            map['showText'] = false;
          }
        } else {
          map['showLine'] = false;
          map['showText'] = false;
          if (j == 0 && !widget.showOneHand) {
            map['showText'] = true;
          }
        }
        result.add(map);
      }
    }
    return result;
  }

  Widget title(String thirdTagName, String handleTagName, {bool show = false, String thirdTagNameExtra = ''}) {
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
            child: pText(thirdTagNameExtra == '' ? thirdTagName : (thirdTagNameExtra + '/' + thirdTagName),
                ColorConfig.color_666666, 24.w),
          ),
          Expanded(
              child: Container(
            height: 74.w,
            alignment: Alignment.center,
            child: pText(handleTagName, ColorConfig.color_666666, 24.w),
          ))
        ],
      ),
    ));
  }

  Widget mixSku(FocusScopeNode node, var item, int index) {
    return RepaintBoundary(
        child: Container(
            margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
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
                        bottom: BorderSide(
                            color: Color(item['showLine'] ? ColorConfig.color_dcdcdc : ColorConfig.color_ffffff),
                            width: 0.5)),
                  ),
                  child: (item['showText'] || item['size'] == "一手")
                      ? pText(item['color'], ColorConfig.color_666666, 28.w)
                      : null,
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
                    child: item['size'] == "一手"
                        ? Container()
                        : (item['thirdTagExtra'] == null
                            ? pText(item['thirdTag'].toString(), widget.thirdTagColor, 28.w)
                            : (item['thirdTagExtra'] == null
                                ? pText(item['thirdTag'].toString(), widget.thirdTagColor, 32.w)
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    reverse: true,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      pText(item['thirdTagExtra'].toString() + "/", ColorConfig.color_666666, 28.w),
                                      pText(item['thirdTag'].toString(), widget.thirdTagColor, 32.w)
                                    ]))))),
                Expanded(
                  child: GetBuilder<GetxController>(
                      init: widget.controller,
                      id: "innerSkuRow" + item['skuId'].toString(),
                      builder: (ctl) {
                        return Container(
                          height: 74.w,
                          decoration: new BoxDecoration(
                              border: const Border(
                                  right: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5),
                                  bottom: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5))),
                          alignment: Alignment.center,
                          child: GetBuilder<GetxController>(
                              init: widget.controller,
                              id: "innerSku" + index.toString(),
                              builder: (ctl) {
                                return NumChangeWidget(
                                  buttonColor:
                                      item['size'] == "一手" ? ColorConfig.color_ffffff : ColorConfig.color_dcdcdc,
                                  buttonBack:
                                      item['size'] == "一手" ? ColorConfig.color_dcdcdc : ColorConfig.color_ffffff,
                                  num: item['handleTag'] != null ? item['handleTag'].toString() : '',
                                  negative: widget.negative,
                                  negativeColor: widget.negativeColor,
                                  color: widget.handleTagColor,
                                  onValueChanged: (value) {
                                    if (item['size'] == "一手") {
                                      int v = int.parse(value);
                                      int min = 999999999;
                                      bool needUpdate = false;
                                      //拿到子集中的最大值
                                      if (!widget.handleOverThird) {
                                        for (int i = 0; i < item['childSize']; i++) {
                                          if (widget.data[index + i + 1]['thirdTag'] < min) {
                                            min = widget.data[index + i + 1]['thirdTag'];
                                          }
                                        }
                                        if (v > min) {
                                          v = min;
                                          needUpdate = true;
                                        }
                                      }
                                      //更新一手其他信息信息
                                      widget.data[index]['handleTag'] = v;
                                      if (needUpdate) {
                                        ctl.update(["innerSku" + index.toString()]);
                                      }
                                      List<Object> updateTags = [];
                                      for (int i = 0; i < item['childSize']; i++) {
                                        updateTags.add("innerSku" + (index + i + 1).toString());
                                        widget.data[index + i + 1]['handleTag'] = v;
                                        List skuIndex = widget.data[index + i + 1]['skuIndex'];
                                        // widget.skuMap[1]![skuIndex[0]]['sizes'][skuIndex[1]]['data'][widget.handleTag] = v;
                                        widget.skuMap[item['key']]![skuIndex[0]]['sizes'][skuIndex[1]]['data']
                                            [widget.handleTag] = v;
                                      }
                                      //刷新局部ui
                                      ctl.update(updateTags);
                                    } else {
                                      int v = int.parse(value);
                                      bool needUpdate = false;
                                      if (!widget.handleOverThird && v > widget.data[index]['thirdTag']) {
                                        v = widget.data[index]['thirdTag'];
                                        needUpdate = true;
                                      }
                                      widget.data[index]['handleTag'] = v;
                                      if (needUpdate) {
                                        ctl.update(["innerSku" + index.toString()]);
                                      }
                                      widget.skuMap[item['key']]![item['skuIndex'][0]]['sizes'][item['skuIndex'][1]]
                                          ['data'][widget.handleTag] = v;
                                      // widget.skuMap[1]![item['skuIndex'][0]]['sizes'][item['skuIndex'][1]]['data'][widget.handleTag] = v;

                                      //看下有没有 一手，如有有，一手要清零
                                      if (item['childIndex'] != -1) {
                                        widget.data[index - item['childIndex'] as int]['handleTag'] = null;
                                        ctl.update(["innerSku" + (index - item['childIndex'] as int).toString()]);
                                      }
                                    }

                                    //计算当前货品 数 ，和列表总数
                                    List skus = widget.skuMap[item['key']] as List;
                                    int itemAdd = 0;
                                    int itemMinus = 0;
                                    for (int i = 0; i < skus.length; i++) {
                                      for (int j = 0; j < skus[i]['sizes'].length; j++) {
                                        if (skus[i]['sizes'][j]['data'][widget.handleTag] != null) {
                                          var num = skus[i]['sizes'][j]['data'][widget.handleTag] as int;
                                          if (num > 0) {
                                            itemAdd += num;
                                          } else {
                                            itemMinus += num;
                                          }
                                        }
                                      }
                                    }
                                    widget.callBack(widget.data[index]['key'], index, itemAdd, itemMinus);
                                  },
                                  onEditingComplete: () {
                                    node.nextFocus();
                                  },
                                );
                              }),
                        );
                      }),
                ),
              ],
            )));
  }
}
