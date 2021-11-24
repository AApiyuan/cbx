import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/customer/controller/search_customer_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

// ignore: must_be_immutable
class SearchCustomerBar extends StatefulWidget implements PreferredSizeWidget {

  Function? cancel;

  SearchCustomerBar({this.cancel});

  @override
  State<StatefulWidget> createState() {
    return _SearchCustomerBarState();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(64.w);

}

class _SearchCustomerBarState extends State<SearchCustomerBar> {
  @override
  Widget build(BuildContext context) {
    return pAppBar("",
        back: false,
        type: 0,
        backFunc: widget.cancel,
        actions: [searchWidget(widget.cancel)]);
  }

  Widget searchWidget([Function? cancel]) {
    var controller = TextEditingController();
    return Container(
      margin: EdgeInsets.only(right: 24.w),
      child: Row(
        children: [
          Container(
            width: 634.w,
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
                  child: GetBuilder<SearchCustomerController>(
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
                          hintText: "搜索客户姓名，手机号",
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
                GetBuilder<SearchCustomerController>(
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
                          ctl.search("");
                        },
                      ),
                      visible: controller.text.length > 0,
                    );
                  },
                  id: SearchCustomerController.idSearchClear,
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

}