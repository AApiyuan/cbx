import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/device_utils.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class SearchWidget extends StatefulWidget implements PreferredSizeWidget {
  final Function? cancel;

  SearchWidget({Key? key, required this.cancel});

  @override
  State<StatefulWidget> createState() {
    return _SearchWidgetState();
  }

  @override
  Size get preferredSize => new Size.fromHeight(64.w);
}

class _SearchWidgetState extends State<SearchWidget> {

  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return pAppBar("",
        back: false,
        type: 0,
        backFunc: widget.cancel,
        actions: [searchWidget(controller, widget.cancel)]);
  }
}

Widget searchWidget(TextEditingController controller, [Function? cancel,]) {
  return Container(
    margin: EdgeInsets.only(right: 24.w),
    child: Row(
      children: [
        Container(
          width: DeviceUtil.isPad() ? 1410.w : 634.w,
          height: 64.w,
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
          decoration: ShapeDecoration(
              color: Color(ColorConfig.color_efefef),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.w))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/icon_search.png",
                width: 25.w,
                height: 25.w,
              ),
              Expanded(
                child: GetBuilder<GoodsListController>(
                  builder: (ctl) {
                    return TextField(
                      textInputAction: TextInputAction.search,
                      controller: controller,
                      autofocus: true,
                      style: textStyle(color: ColorConfig.color_333333),
                      textAlign: TextAlign.start,
                      onChanged: (text) => ctl.updateSearchText(text),
                      onSubmitted: (text) => ctl.search(text),
                      decoration: InputDecoration(
                        hintText: "搜索品名货号",
                        contentPadding: EdgeInsetsDirectional.only(start: 12.w),
                        hintStyle: textStyle(color: ColorConfig.color_999999),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    );
                  },
                ),
              ),
              GetBuilder<GoodsListController>(
                builder: (ctl) {
                  return Visibility(
                    child: InkWell(
                      child: Image.asset(
                        "images/icon_search_clear.png",
                        width: 30.w,
                        height: 30.w,
                      ),
                      onTap: () {
                        controller.clear();
                        ctl.updateSearchText("");
                        if (ctl.goodsType == GoodsListController.TYPE_SALE) {
                          ctl.updateFilter(GoodsListController.idFilterHot);
                        } else {
                          ctl.search("");
                        }
                      },
                    ),
                    visible: controller.text.length > 0,
                  );
                },
                id: GoodsListController.idSearchClear,
              )
            ],
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        InkWell(
          child: Container(
            child: Text(
              "取消",
              style: textStyle(color: ColorConfig.color_666666),
            ),
          ),
          onTap: () => cancel?.call(),
        )
      ],
    ),
  );
}

Widget filterWidget(BuildContext context) {
  return Row(
    children: [
      filterItemWidget(context, GoodsListController.idFilterHot, "近期上架热销", 20,
          "images/icon_hot_sale.png"),
      filterItemWidget(context, GoodsListController.idFilterLately, "最近上架", 32),
      filterItemWidget(context, GoodsListController.idFilterBuy, "购买过", 44),
    ],
  );
}

Widget filterItemWidget(
    BuildContext context, String id, String title, int padding,
    [String? startIcon]) {
  return GetBuilder<GoodsListController>(
    id: id,
    builder: (ctl) {
      var select = ctl.filterType == id;
      return Visibility(
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            decoration: ShapeDecoration(
                color: Color(select
                    ? ColorConfig.color_ffceae
                    : ColorConfig.color_f5f5f5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.w))),
            padding: EdgeInsets.only(left: padding.w, right: padding.w),
            margin: EdgeInsets.only(top: 24.w, left: 24.w, bottom: 12.w),
            child: Row(
              children: [
                startIcon == null
                    ? SizedBox()
                    : Image.asset(
                        startIcon,
                        width: 22.w,
                        height: 26.w,
                      ),
                SizedBox(
                  width: startIcon == null ? 0 : 2.w,
                ),
                Text(
                  title,
                  style: textStyle(
                      color: select
                          ? ColorConfig.color_FA6400
                          : ColorConfig.color_666666,
                      size: 24),
                )
              ],
            ),
            height: 54.w,
          ),
          onTap: () {
            ctl.updateFilter(id);
            closeKey(context);
          },
        ),
        visible: ctl.isShowFilter(),
      );
    },
  );
}

closeKey(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
