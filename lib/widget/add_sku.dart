import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_manager.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';

import 'num_change.dart';
import 'p_common.dart';

class AddSku extends StatefulWidget {
  final controller;
  final List<dynamic> skus;
  final String imgUrl;
  final String title;
  final String thirdTag; //第三块名称
  final String thirdTagName; //第三块对应取值内容
  final Function callback;

  AddSku(
      {Key? key,
      required this.controller,
      required this.skus,
      required this.thirdTag,
      required this.callback,
      this.thirdTagName = "已选数量",
      this.title = "货品名",
      this.imgUrl = ''})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _addSkuState();
  }
}

class _addSkuState extends State<AddSku> {
  Map<int, int> map = new Map();

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
        title: "",
        child: MixSku(
          skus: widget.skus,
          title: widget.title,
          imgUrl: widget.imgUrl,
          shrinkWrap: false,
          controller: widget.controller,
          negative: true,
          thirdTag: widget.thirdTag,
          handleTagName: "数量",
          callBack: (numMap) {
            map = numMap;
          },
        ),
        onClose: () {},
        onCertain: () {
          //确定叠加，这个时候要将sku更新；
          if (map != null) {
            setState(() {
              for (int i = 0; i < widget.skus.length; i++) {
                for (int j = 0; j < widget.skus[i]['sizes'].length; j++) {
                  var item = widget.skus[i]['sizes'][j];
                  if (map[item['data']['skuId']] != null) {
                    if (item['data'][widget.thirdTag] == null) {
                      item['data'][widget.thirdTag] = 0;
                    }
                    item['data'][widget.thirdTag] += map[item['data']['skuId']];
                  }
                }
              }
            });
            widget.callback(widget.skus, map);
          }
        });
  }
}

class MixSku extends StatefulWidget {
  final controller;
  final List skus;
  final String imgUrl;
  final String title;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  final String thirdTag; //第三块名称
  final String thirdTagName; //第三块对应取值内容
  final int thirdTagColor;
  final String handleTagName; //第四块对应取值内容
  final int handleTagColor;

  //如果允许负数颜色
  final bool negative;
  final int negativeColor;

  final Function callBack;

  MixSku(
      {Key? key,
      required this.controller,
      required this.skus,
      required this.callBack,
      this.shrinkWrap = false,
      this.physics = const AlwaysScrollableScrollPhysics(),
      this.thirdTagName = "已选数量",
      required this.thirdTag,
      this.thirdTagColor = ColorConfig.color_666666,
      this.handleTagName = "数量",
      this.negative = false,
      this.negativeColor = ColorConfig.color_ff3715,
      this.handleTagColor = ColorConfig.color_1678ff,
      this.title = "货品名",
      this.imgUrl = ''})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MixSkuState();
  }
}

class _MixSkuState extends State<MixSku> {
  FocusScopeNode node = FocusScopeNode();
  List data = [];

  int addNum = 0;
  int minusNum = 0;
  Map<int, int> numMap = new Map(); //值变化后 更新

  ValueNotifier<double> keyboardHeightNotifier = CoolKeyboard.getKeyboardHeightNotifier();

  @override
  void initState() {
    //初始化map
    data = transferSku();
    super.initState();
    CoolKeyboard.getKeyboardHeightNotifier().addListener(keyboardHeight);
  }

  dynamic keyboardHeight() {
    if (CoolKeyboard.getKeyboardHeightNotifier().value == 0.0) {
      node.unfocus();
    }
  }

  //页面销毁
  @override
  void dispose() {
    //释放
    super.dispose();
    CoolKeyboard.getKeyboardHeightNotifier().removeListener(keyboardHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 180.w,
            margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 20.w),
            child: Row(children: [
              NetImageWidget(
                widget.imgUrl,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                  height: 140.w,
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    pText(widget.title, ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w600,width: 500.w,
                        alignment: Alignment.centerLeft),
                    GetBuilder<GetxController>(
                        init: widget.controller,
                        id: "innerSkuDialogAddNum",
                        builder: (ctl) {
                          return Row(
                            children: [
                              Visibility(
                                  visible: addNum > 0,
                                  child: pText("叠加" + addNum.toString(), ColorConfig.color_1678FF, 32.w, fontWeight: FontWeight.w600)),
                              Visibility(
                                  visible: minusNum < 0,
                                  child: pText("减" + minusNum.toString(), ColorConfig.color_ff3715, 32.w, fontWeight: FontWeight.w600)),
                            ],
                          );
                        })
                  ]))
            ])),
        Expanded(
            child: FocusScope(
                node: node,
                child: ListView.builder(
                    shrinkWrap: widget.shrinkWrap,
                    //解决无限高度问题
                    physics: widget.physics,
                    cacheExtent: 20,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      if (data[index]['itemType'] == 'title') {
                        return title(widget.thirdTagName, widget.handleTagName);
                      }
                      if (data[index]['itemType'] == 'sku') {
                        return mixSku(node, data[index], index);
                      }
                      return mixSku(node, data[index], index);
                    })))
      ],
    );
  }

  List<dynamic> transferSku() {
    List<dynamic> result = [];
    Map map = new Map();
    map['itemType'] = 'title';
    map['thirdTagName'] = widget.thirdTagName;
    map['handleTagName'] = widget.handleTagName;
    result.add(map);
    for (int i = 0; i < widget.skus.length; i++) {
      if (widget.skus[i]['sizes'].length > 1) {
        //添加一手
        Map map = new Map();
        map['itemType'] = 'sku';
        map['color'] = widget.skus[i]['goodsColor']['name'];
        map['size'] = '一手';
        // map['handleTag'] = null;
        map['thirdTag'] = 0;
        map['childSize'] = widget.skus[i]['sizes'].length;
        map['showLine'] = false;
        map['showText'] = true;
        result.add(map);
      }
      for (int j = 0; j < widget.skus[i]['sizes'].length; j++) {
        var item = widget.skus[i]['sizes'][j];
        Map map = new Map();
        map['itemType'] = 'sku';
        map['group'] = widget.skus[i]['goodsColor']['name'];
        map['skuId'] = item['data']['skuId'];
        map['color'] = widget.skus[i]['goodsColor']['name'];
        map['size'] = item['goodsSize']['name'];
        if (widget.skus[i]['sizes'].length > 1) {
          map['childIndex'] = j + 1;
        } else {
          map['childIndex'] = -1;
        }
        map['skuIndex'] = [i, j];

        map['thirdTag'] = item['data'][widget.thirdTag] ?? 0;
        // map['handleTag'] = item['data'][widget.handleTag];
        if (j == widget.skus[i]['sizes'].length - 1) {
          map['showLine'] = true;
          map['showText'] = true;
          if (widget.skus[i]['sizes'].length > 1) {
            map['showText'] = false;
          }
        } else {
          map['showLine'] = false;
          map['showText'] = false;
        }
        result.add(map);
      }
    }
    return result;
  }

  void updateNum() {
    int add = 0;
    int minus = 0;
    numMap.values.forEach((v) {
      if (v > 0) {
        add += v;
      } else {
        minus += v;
      }
    });
    addNum = add;
    minusNum = minus;
    widget.controller.update(['innerSkuDialogAddNum']);
  }

  Widget title(String thirdTagName, String handleTagName, {bool show = false}) {
    return RepaintBoundary(
        child: Container(
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
                  child: (item['showText'] || item['size'] == "一手") ? pText(item['color'], ColorConfig.color_666666, 28.w) : null,
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
                  child: pText(item['size'] == "一手" ? "" : item['thirdTag'].toString(), ColorConfig.color_666666, 32.w),
                ),
                Expanded(
                  child: Container(
                    height: 74.w,
                    decoration: new BoxDecoration(
                        border: const Border(
                            right: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5),
                            bottom: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 0.5))),
                    alignment: Alignment.center,
                    child: GetBuilder<GetxController>(
                        init: widget.controller,
                        id: "innerSkuDialogAdd" + index.toString(),
                        builder: (ctl) {
                          return NumChangeWidget(
                            buttonColor: item['size'] == "一手" ? ColorConfig.color_ffffff : ColorConfig.color_dcdcdc,
                            buttonBack: item['size'] == "一手" ? ColorConfig.color_dcdcdc : ColorConfig.color_ffffff,
                            num: item['handleTag'] != null ? item['handleTag'].toString() : '',
                            negative: widget.negative,
                            negativeColor: widget.negativeColor,
                            onValueChanged: (value) {
                              if (item['size'] == "一手") {
                                //更新一手其他信息信息
                                // widget.skus[index]['handleTag'] = int.parse(value);
                                List<Object> updateTags = [];
                                for (int i = 0; i < item['childSize']; i++) {
                                  updateTags.add("innerSkuDialogAdd" + (index + i + 1).toString());
                                  data[index + i + 1]['handleTag'] = value;
                                  numMap[data[index + i + 1]['skuId']] = int.parse(value);
                                }
                                //刷新局部ui
                                ctl.update(updateTags);
                              } else {
                                //看下有没有 一手，如有有，一手要清零
                                if (item['childIndex'] != -1) {
                                  ctl.update(["innerSkuDialogAdd" + (index - item['childIndex'] as int).toString()]);
                                }
                                numMap[item['skuId']] = int.parse(value);
                              }
                              //计算
                              updateNum();
                              //callback;
                              widget.callBack(numMap);
                            },
                            onEditingComplete: () {
                              node.nextFocus();
                            },
                          );
                        }),
                  ),
                ),
              ],
            )));
  }
}
