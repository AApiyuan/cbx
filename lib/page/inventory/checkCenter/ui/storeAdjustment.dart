import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/permission_utils.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/controller/differenceController.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkTitle01.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/hint_dialog.dart';

class StoreAdjustMent extends StatelessWidget{ // StatefulWidget {
  // StoreAdjustmentState createState() => StoreAdjustmentState();

  final DifferenceController _differenceController =
      Get.put(DifferenceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new CheckTitle01().appBar(context, "库存调整"),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Container(
                alignment: Alignment.topLeft,
                color: Color(ColorConfig.color_FFFCD9),
                child: Column(
                  children: [
                    GetBuilder<DifferenceController>(
                      builder: (ctl) {
                        return Container(
                          child: Text("账面库存快照时间：${ctl.data().createdTime ?? ""}",
                              style: TextStyle(
                                  color: Color(ColorConfig.color_FF5D1E),
                                  fontSize: 24.w)),
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 0),
                        );
                      },
                    ),
                    Container(
                        child: Text(
                          "未盘货品默认按盘点数为0计算差异",
                          style: TextStyle(
                              color: Color(ColorConfig.color_FF5D1E),
                              fontSize: 24.w),
                        ),
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(24.w, 16.w, 24.w, 20.w)),
                  ],
                ),
              ),
              Container(
                color: Color(ColorConfig.color_f5f5f5),
                height: 20.w,
              ),
              GetBuilder<DifferenceController>(
                builder: (ctl) => Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding:
                                EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "正品已盘",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 24.w),
                                ),
                                SizedBox(height: 30.w),
                                Text(
                                  "${_differenceController.data().inventoryStyleNum ?? 0}款/${_differenceController.data().inventoryNum ?? 0}件",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_333333),
                                      fontSize: 32.w,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_more.png")),
                                    ),
                                    Text(
                                      "${_differenceController.data().profitNormalStyleNum ?? 0}款盘盈${_differenceController.data().profitNormalNum ?? 0}",
                                      style: TextStyle(
                                          color:
                                              Color(ColorConfig.color_666666),
                                          fontSize: 24.w),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15.w,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_less.png")),
                                    ),
                                    Text(
                                        "${_differenceController.data().lossNormalStyleNum ?? 0}款盘亏${_differenceController.data().lossNormalNum?.abs() ?? 0}",
                                        style: TextStyle(
                                            color:
                                                Color(ColorConfig.color_666666),
                                            fontSize: 24.w))
                                  ],
                                )
                              ],
                            ),
                          )),
                      Container(
                          color: Color(ColorConfig.color_f5f5f5), width: 1),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding:
                                EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "正品未盘",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 24.w),
                                ),
                                SizedBox(height: 30.w),
                                Text(
                                  "${_differenceController.data().noInventoryStyleNum ?? 0}款",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_333333),
                                      fontSize: 32.w,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_more.png")),
                                    ),
                                    Text(
                                      "${_differenceController.data().noProfitNormalStyleNum ?? 0}款盘盈${_differenceController.data().noProfitNormalNum ?? 0}",
                                      style: TextStyle(
                                          color:
                                              Color(ColorConfig.color_666666),
                                          fontSize: 24.w),
                                    )
                                  ],
                                ),
                                SizedBox(height: 15.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_less.png")),
                                    ),
                                    Text(
                                        "${_differenceController.data().noLossNormalStyleNum ?? 0}款盘亏${_differenceController.data().noLossNormalNum?.abs() ?? 0}",
                                        style: TextStyle(
                                            color:
                                                Color(ColorConfig.color_666666),
                                            fontSize: 24.w))
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Container(color: Color(ColorConfig.color_f5f5f5), height: 1),
              Container(
                height: 250.w,
                padding: EdgeInsets.fromLTRB(4.w, 30.w, 24.w, 30.w),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _createRadioGroupQuality(0),
                        RichText(
                          text: TextSpan(
                            text: "调整已盘",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                            children: [
                              TextSpan(
                                  text: "(只调整已盘的款)",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 28.w))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        _createRadioGroupQuality(1),
                        RichText(
                          text: TextSpan(
                            text: "全部调整",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                            children: [
                              TextSpan(
                                  text: "(未盘货品库存会被置为0)",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 28.w))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        _createRadioGroupQuality(2),
                        RichText(
                          text: TextSpan(
                            text: "暂不调整",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                color: Color(ColorConfig.color_f5f5f5),
                height: 20.w,
              ),
              GetBuilder<DifferenceController>(
                builder: (ctl) => Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding:
                                EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "次品已盘",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 24.w),
                                ),
                                SizedBox(height: 30.w),
                                Text(
                                  "${_differenceController.data().substandardInventoryStyleNum ?? 0}款/${_differenceController.data().substandardInventoryNum ?? 0}件",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_333333),
                                      fontSize: 32.w,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_more.png")),
                                    ),
                                    Text(
                                      "${_differenceController.data().profitSubstandardStyleNum ?? 0}款盘盈${_differenceController.data().profitSubstandardNum ?? 0}",
                                      style: TextStyle(
                                          color:
                                              Color(ColorConfig.color_666666),
                                          fontSize: 24.w),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15.w,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_less.png")),
                                    ),
                                    Text(
                                        "${_differenceController.data().lossSubstandardStyleNum ?? 0}款盘亏${_differenceController.data().lossSubstandardNum?.abs() ?? 0}",
                                        style: TextStyle(
                                            color:
                                                Color(ColorConfig.color_666666),
                                            fontSize: 24.w))
                                  ],
                                )
                              ],
                            ),
                          )),
                      Container(
                          color: Color(ColorConfig.color_f5f5f5), width: 1),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding:
                                EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "次品未盘",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 24.w),
                                ),
                                SizedBox(height: 30.w),
                                Text(
                                  "${_differenceController.data().substandardNoInventoryStyleNum ?? 0}款",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_333333),
                                      fontSize: 32.w,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_more.png")),
                                    ),
                                    Text(
                                      "${_differenceController.data().noProfitSubstandardStyleNum ?? 0}款盘盈${_differenceController.data().noProfitSubstandardNum ?? 0}",
                                      style: TextStyle(
                                          color:
                                              Color(ColorConfig.color_666666),
                                          fontSize: 24.w),
                                    )
                                  ],
                                ),
                                SizedBox(height: 15.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_less.png")),
                                    ),
                                    Text(
                                        "${_differenceController.data().noLossSubstandardStyleNum ?? 0}款盘亏${_differenceController.data().noLossSubstandardNum?.abs() ?? 0}",
                                        style: TextStyle(
                                            color:
                                                Color(ColorConfig.color_666666),
                                            fontSize: 24.w))
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Container(color: Color(ColorConfig.color_f5f5f5), height: 1),
              Container(
                height: 250.w,
                padding: EdgeInsets.fromLTRB(4.w, 30.w, 24.w, 30.w),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _createRadioGroupInferior(0),
                        RichText(
                          text: TextSpan(
                            text: "调整已盘",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                            children: [
                              TextSpan(
                                  text: "(只调整已盘的款)",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 28.w))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        _createRadioGroupInferior(1),
                        RichText(
                          text: TextSpan(
                            text: "全部调整",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                            children: [
                              TextSpan(
                                  text: "(未盘货品库存会被置为0)",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 28.w))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        _createRadioGroupInferior(2),
                        RichText(
                          text: TextSpan(
                            text: "暂不调整",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
          Container(
            height: 100.w,
            width: double.infinity,
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(24.w, 11.w, 24.w, 11.w),
            child: FlatButton(
              shape: StadiumBorder(
                  side: BorderSide(
                      color: Color(ColorConfig.color_1678FF), width: 1)),
              color: Color(ColorConfig.color_1678FF),
              onPressed: () => PermissionUtils.checkPermission(
                      PermissionUtils.WAREHOUSE_FINISHED_INVENTORY)
                  .then((value) => _showEndInventoryDialog(value)),
              child: Text(
                "结束盘点",
                style: TextStyle(color: Colors.white, fontSize: 32.w),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 显示结束盘点弹窗
  void _showEndInventoryDialog(bool hasPermission) {
    if (!hasPermission) return;
    HintDialogUtil.show(
        hideTitle: true,
        height: 220,
        content: "确定结束本次盘点吗？",
        contentTextStyle: textStyle(size: 32, bold: true),
        positiveText: "结束",
        positiveTextColor: Color(ColorConfig.color_ff3715),
        positiveCallBack: (_) => callBack());
  }

  Widget _createRadioGroupQuality(int value) {
    return SizedBox(
      width: 78.w,
      height: 38.w,
      child: GestureDetector(
        child: GetBuilder<DifferenceController>(
          id: "quality $value",
          builder: (ctl) {
            return Image.asset(
              ctl.radioGroupQuality == value
                  ? "images/icon_select_on.png"
                  : "images/icon_select_off.png",
              width: 38.w,
              height: 38.w,
            );
          },
        ),
        onTap: () => _differenceController.handleRadioValueChangedQuality(value),
      ),
    );
  }

  Widget _createRadioGroupInferior(int value) {
    return SizedBox(
      width: 78.w,
      height: 38.w,
      child: GestureDetector(
        child: GetBuilder<DifferenceController>(
          id: "inferior $value",
          builder: (ctl) {
            return Image.asset(
              ctl.radioGroupInferior == value
                  ? "images/icon_select_on.png"
                  : "images/icon_select_off.png",
              width: 38.w,
              height: 38.w,
            );
          },
        ),
        onTap: () => _differenceController.handleRadioValueChangedInferior(value),
      ),
    );
  }

  callBack() {
    print("成功结束");
    String normalFinish = "";
    String substandardFinish = "";

    if (_differenceController.radioGroupQuality == 0) {
      normalFinish = "ADJUST_FINISHED";
    }

    if (_differenceController.radioGroupQuality == 1) {
      normalFinish = "ADJUST_ALL";
    }

    if (_differenceController.radioGroupQuality == 2) {
      normalFinish = "ADJUST_NULL";
    }

    if (_differenceController.radioGroupInferior == 0) {
      substandardFinish = "ADJUST_FINISHED";
    }

    if (_differenceController.radioGroupInferior == 1) {
      substandardFinish = "ADJUST_ALL";
    }

    if (_differenceController.radioGroupInferior == 2) {
      substandardFinish = "ADJUST_NULL";
    }

    Map<String, dynamic> map = new Map<String, dynamic>();
    map["orderInventoryId"] = _differenceController.id;
    map["normalFinish"] = normalFinish;
    map["substandardFinish"] = substandardFinish;
    _differenceController.checkFinish(map).then(
      (value) {
        if (value) {
          Get.offAllNamed(
            ArgUtils.map2String(
              path: Routes.CHECKEMPTY,
              arguments: {"depId": _differenceController.depId},
            ),
          );
        }
      },
    ).then(
      (value) => Get.toNamed(
        ArgUtils.map2String(
          path: Routes.CHECKHIS,
          arguments: {"depId": _differenceController.depId},
        ),
      ),
    );
  }
}

/*class StoreAdjustmentState extends State<StoreAdjustMent>
    with SingleTickerProviderStateMixin {
  DifferenceController _differenceController = Get.put(DifferenceController());
  final id = ArgUtils.getArgument2num('id');
  final depId = ArgUtils.getArgument2num('depId');
  TabController tabController;

  int _radioGroupQuality = 0;
  int _radioGroupInferior = 0;

  void _handleRadioValueChangedQuality(int value) {
    setState(() {
      _radioGroupQuality = value;
    });
  }

  void _handleRadioValueChangedInferior(int value) {
    setState(() {
      _radioGroupInferior = value;
    });
  }

  @override
  void initState() {
    _differenceController.getInventoryReport(id);
    this.tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new CheckTitle01().appBar(context, "库存调整"),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Container(
                alignment: Alignment.topLeft,
                color: Color(ColorConfig.color_FFFCD9),
                child: Column(
                  children: [
                    GetBuilder<DifferenceController>(
                      builder: (ctl) {
                        return Container(
                          child: Text("账面库存快照时间：${ctl.data().createdTime}",
                              style: TextStyle(
                                  color: Color(ColorConfig.color_FF5D1E),
                                  fontSize: 24.w)),
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 0),
                        );
                      },
                    ),
                    Container(
                        child: Text(
                          "未盘货品默认按盘点数为0计算差异",
                          style: TextStyle(
                              color: Color(ColorConfig.color_FF5D1E),
                              fontSize: 24.w),
                        ),
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(24.w, 16.w, 24.w, 20.w)),
                  ],
                ),
              ),
              Container(
                color: Color(ColorConfig.color_f5f5f5),
                height: 20.w,
              ),
              GetBuilder<DifferenceController>(
                builder: (ctl) => Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding:
                                EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "正品已盘",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 24.w),
                                ),
                                SizedBox(height: 30.w),
                                Text(
                                  "${_differenceController.data().inventoryStyleNum ?? 0}款/${_differenceController.data().inventoryNum ?? 0}件",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_333333),
                                      fontSize: 32.w,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_more.png")),
                                    ),
                                    Text(
                                      "${_differenceController.data().profitNormalStyleNum ?? 0}款盘盈${_differenceController.data().profitNormalNum ?? 0}",
                                      style: TextStyle(
                                          color:
                                              Color(ColorConfig.color_666666),
                                          fontSize: 24.w),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15.w,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_less.png")),
                                    ),
                                    Text(
                                        "${_differenceController.data().lossNormalStyleNum ?? 0}款盘亏${_differenceController.data().lossNormalNum?.abs()}",
                                        style: TextStyle(
                                            color:
                                                Color(ColorConfig.color_666666),
                                            fontSize: 24.w))
                                  ],
                                )
                              ],
                            ),
                          )),
                      Container(
                          color: Color(ColorConfig.color_f5f5f5), width: 1),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding:
                                EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "正品未盘",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 24.w),
                                ),
                                SizedBox(height: 30.w),
                                Text(
                                  "${_differenceController.data().noInventoryStyleNum}款",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_333333),
                                      fontSize: 32.w,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_more.png")),
                                    ),
                                    Text(
                                      "${_differenceController.data().noProfitNormalStyleNum}款盘盈${_differenceController.data().noProfitNormalNum}",
                                      style: TextStyle(
                                          color:
                                              Color(ColorConfig.color_666666),
                                          fontSize: 24.w),
                                    )
                                  ],
                                ),
                                SizedBox(height: 15.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_less.png")),
                                    ),
                                    Text(
                                        "${_differenceController.data().noLossNormalStyleNum}款盘亏${_differenceController.data().noLossNormalNum?.abs()}",
                                        style: TextStyle(
                                            color:
                                                Color(ColorConfig.color_666666),
                                            fontSize: 24.w))
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Container(color: Color(ColorConfig.color_f5f5f5), height: 1),
              Container(
                height: 250.w,
                padding: EdgeInsets.fromLTRB(4.w, 30.w, 24.w, 30.w),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _createRadioGroupQuality(0),
                        RichText(
                          text: TextSpan(
                            text: "调整已盘",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                            children: [
                              TextSpan(
                                  text: "(只调整已盘的款)",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 28.w))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        _createRadioGroupQuality(1),
                        RichText(
                          text: TextSpan(
                            text: "全部调整",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                            children: [
                              TextSpan(
                                  text: "(未盘货品库存会被置为0)",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 28.w))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        _createRadioGroupQuality(2),
                        RichText(
                          text: TextSpan(
                            text: "暂不调整",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                color: Color(ColorConfig.color_f5f5f5),
                height: 20.w,
              ),
              GetBuilder<DifferenceController>(
                builder: (ctl) => Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding:
                                EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "次品已盘",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 24.w),
                                ),
                                SizedBox(height: 30.w),
                                Text(
                                  "${_differenceController.data().substandardInventoryStyleNum}款/${_differenceController.data().substandardInventoryNum}件",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_333333),
                                      fontSize: 32.w,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_more.png")),
                                    ),
                                    Text(
                                      "${_differenceController.data().profitSubstandardStyleNum}款盘盈${_differenceController.data().profitSubstandardNum}",
                                      style: TextStyle(
                                          color:
                                              Color(ColorConfig.color_666666),
                                          fontSize: 24.w),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15.w,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_less.png")),
                                    ),
                                    Text(
                                        "${_differenceController.data().lossSubstandardStyleNum}款盘亏${_differenceController.data().lossSubstandardNum?.abs()}",
                                        style: TextStyle(
                                            color:
                                                Color(ColorConfig.color_666666),
                                            fontSize: 24.w))
                                  ],
                                )
                              ],
                            ),
                          )),
                      Container(
                          color: Color(ColorConfig.color_f5f5f5), width: 1),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding:
                                EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "次品未盘",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 24.w),
                                ),
                                SizedBox(height: 30.w),
                                Text(
                                  "${_differenceController.data().substandardNoInventoryStyleNum}款",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_333333),
                                      fontSize: 32.w,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_more.png")),
                                    ),
                                    Text(
                                      "${_differenceController.data().noProfitSubstandardStyleNum}款盘盈${_differenceController.data().noProfitSubstandardNum}",
                                      style: TextStyle(
                                          color:
                                              Color(ColorConfig.color_666666),
                                          fontSize: 24.w),
                                    )
                                  ],
                                ),
                                SizedBox(height: 15.w),
                                Row(
                                  children: [
                                    Container(
                                      width: 18.w,
                                      height: 18.w,
                                      child: Image(
                                          image: AssetImage(
                                              "images/home_check_less.png")),
                                    ),
                                    Text(
                                        "${_differenceController.data().noLossSubstandardStyleNum}款盘亏${_differenceController.data().noLossSubstandardNum?.abs()}",
                                        style: TextStyle(
                                            color:
                                                Color(ColorConfig.color_666666),
                                            fontSize: 24.w))
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Container(color: Color(ColorConfig.color_f5f5f5), height: 1),
              Container(
                height: 250.w,
                padding: EdgeInsets.fromLTRB(4.w, 30.w, 24.w, 30.w),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _createRadioGroupInferior(0),
                        RichText(
                          text: TextSpan(
                            text: "调整已盘",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                            children: [
                              TextSpan(
                                  text: "(只调整已盘的款)",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 28.w))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        _createRadioGroupInferior(1),
                        RichText(
                          text: TextSpan(
                            text: "全部调整",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                            children: [
                              TextSpan(
                                  text: "(未盘货品库存会被置为0)",
                                  style: TextStyle(
                                      color: Color(ColorConfig.color_999999),
                                      fontSize: 28.w))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        _createRadioGroupInferior(2),
                        RichText(
                          text: TextSpan(
                            text: "暂不调整",
                            style: TextStyle(
                                color: Color(ColorConfig.color_333333),
                                fontSize: 28.w),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
          Container(
            height: 100.w,
            width: double.infinity,
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(24.w, 11.w, 24.w, 11.w),
            child: FlatButton(
              shape: StadiumBorder(
                  side: BorderSide(
                      color: Color(ColorConfig.color_1678FF), width: 1)),
              color: Color(ColorConfig.color_1678FF),
              onPressed: () => PermissionUtils.checkPermission(
                      PermissionUtils.WAREHOUSE_FINISHED_INVENTORY)
                  .then((value) => _showEndInventoryDialog(value)),
              child: Text(
                "结束盘点",
                style: TextStyle(color: Colors.white, fontSize: 32.w),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 显示结束盘点弹窗
  void _showEndInventoryDialog(bool hasPermission) {
    if (!hasPermission) return;
    HintDialogUtil.instance.show(
        hideTitle: true,
        height: 220,
        content: "确定结束本次盘点吗？",
        contentTextStyle: textStyle(size: 32, bold: true),
        positiveText: "结束",
        positiveTextColor: Color(ColorConfig.color_ff3715),
        positiveCallBack: (_) => callBack());
  }

  Widget _createRadioGroupQuality(int value) {
    return SizedBox(
      width: 78.w,
      height: 38.w,
      child: GestureDetector(
        child: Image.asset(
          _radioGroupQuality == value
              ? "images/icon_select_on.png"
              : "images/icon_select_off.png",
          width: 38.w,
          height: 38.w,
        ),
        onTap: () => _handleRadioValueChangedQuality(value),
      ),
    );
  }

  Widget _createRadioGroupInferior(int value) {
    return SizedBox(
      width: 78.w,
      height: 38.w,
      child: GestureDetector(
        child: Image.asset(
          _radioGroupInferior == value
              ? "images/icon_select_on.png"
              : "images/icon_select_off.png",
          width: 38.w,
          height: 38.w,
        ),
        onTap: () => _handleRadioValueChangedInferior(value),
      ),
    );
  }

  callBack() {
    print("成功结束");
    String normalFinish = "";
    String substandardFinish = "";

    if (_radioGroupQuality == 0) {
      normalFinish = "ADJUST_FINISHED";
    }

    if (_radioGroupQuality == 1) {
      normalFinish = "ADJUST_ALL";
    }

    if (_radioGroupQuality == 2) {
      normalFinish = "ADJUST_NULL";
    }

    if (_radioGroupInferior == 0) {
      substandardFinish = "ADJUST_FINISHED";
    }

    if (_radioGroupInferior == 1) {
      substandardFinish = "ADJUST_ALL";
    }

    if (_radioGroupInferior == 2) {
      substandardFinish = "ADJUST_NULL";
    }

    Map<String, dynamic> map = new Map<String, dynamic>();
    map["orderInventoryId"] = id;
    map["normalFinish"] = normalFinish;
    map["substandardFinish"] = substandardFinish;
    _differenceController.checkFinish(map).then(
      (value) {
        if (value) {
          Get.offAllNamed(
            ArgUtils.map2String(
              path: Routes.CHECKEMPTY,
              arguments: {"depId": depId},
            ),
          );
        }
      },
    ).then(
      (value) => Get.toNamed(
        ArgUtils.map2String(
          path: Routes.CHECKHIS,
          arguments: {"depId": depId},
        ),
      ),
    );

    // Navigator.pop(context);
  }
}*/

abstract class CancelCallBack {
  callBack();
}
