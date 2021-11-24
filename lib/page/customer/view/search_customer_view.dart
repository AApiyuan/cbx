import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/page/customer/controller/search_customer_controller.dart';
import 'package:haidai_flutter_module/page/customer/model/merchandiser_user_do_entity.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/customer/widget/customer_widget.dart';
import 'package:haidai_flutter_module/page/customer/widget/person_dialog.dart';
import 'package:haidai_flutter_module/page/customer/widget/search_customer_bar.dart';
import 'package:haidai_flutter_module/page/customer/widget/search_widget.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_media_query.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:haidai_flutter_module/widget/search_bar.dart';

// ignore: must_be_immutable
class SearchCustomerView extends GetView<SearchCustomerController> {
  OverlayEntry? entry;
  GlobalKey _key = GlobalKey();
  late BuildContext context;
  final _easyRefreshController = EasyRefreshController();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return KeyboardMediaQuery(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: searchBar(), //SearchCustomerBar(cancel: () => Get.back()),
        body: Column(
          children: [
            GetBuilder<SearchCustomerController>(
              builder: (ctl) {
                return Visibility(
                  child: filterCustomerWidget(() => getPersonList(ctl)),
                  visible: ctl.online,
                );
              },
              key: _key,
            ),
            customerList(),
            Divider(
              height: 1.w,
              indent: 1.w,
              color: Color(ColorConfig.color_efefef),
            ),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                height: 96.w,
                child: pText("快捷新增客户", ColorConfig.color_1678FF, 28.w,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => Get.toNamed(
                ArgUtils.map2String(path: Routes.ADD_CUSTOMER, arguments: {
                  Constant.NAME_OR_PHONE: controller.getSearchText(),
                  Constant.DEPT_ID: controller.deptId,
                  Constant.ONLINE: controller.online,
                }),
              )?.then((value) => Get.back(result: value)),
            ),
          ],
        ),
      ),
    );
  }

  searchBar() {
    return SearchBar(
      hintText: "搜索客户姓名，手机号",
      cancel: () => Get.back(),
      onClear: () => controller.search(""),
      onChanged: (text) => controller.updateSearchText(text),
      onRealTime: (text) => controller.search(text),
      // onSubmit: (text) => controller.search(text),
    );
  }

  Widget customerList() {
    return Expanded(
      child: EasyRefresh.custom(
        slivers: [
          GetBuilder<SearchCustomerController>(
            builder: (ctl) {
              if (ctl.getCustomerList().length == 0) {
                return SliverToBoxAdapter(
                  child: emptyWidget(),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) => listItem(_, ctl.getCustomerItem(index)),
                  childCount: ctl.getCustomerList().length,
                ),
              );
            },
            id: SearchCustomerController.idCustomerList,
          ),
        ],
        header: RefreshUtils.defaultHeader(),
        footer: RefreshUtils.defaultFooter(),
        enableControlFinishLoad: true,
        enableControlFinishRefresh: true,
        taskIndependence: true,
        onLoad: () async {
          controller.getCustomerData(true).whenComplete(() =>
              _easyRefreshController.finishLoad(
                  noMore: controller.noMore, success: true));
        },
        onRefresh: () async {
          Future.wait([controller.getCustomerData(false)]).then((value) {
            _easyRefreshController.resetLoadState();
            _easyRefreshController.finishRefresh(success: true);
          });
        },
        controller: _easyRefreshController,
      ),
    );
  }

  Widget listItem(
      BuildContext buildContext, StoreCustomerListItemDoEntity customer) {
    return customerWidget(customer, () => Get.back(result: customer));
  }

  void getPersonList(SearchCustomerController controller) {
    if (entry != null) return;
    controller
        .getPersonListData()
        .then((value) => showDialog(value, controller));
  }

  double _getDialogTop() {
    var box = _key.currentContext?.findRenderObject() as RenderBox?;
    var translation = box?.getTransformTo(null).getTranslation();
    return (translation?.y ?? 0) + (box?.paintBounds.height ?? 0);
  }

  void hideDialog() {
    entry?.remove();
    entry = null;
  }

  void showDialog(List<MerchandiserUserDoEntity> value,
      SearchCustomerController controller) {
    entry = OverlayEntry(builder: (context) {
      return PersonDialog(
        value,
        controller.selectPersonId(),
        (id) {
          if (id != null) {
            controller.updateSelectPersonId(id);
          }
          hideDialog();
        },
        () => hideDialog(),
        _getDialogTop(),
      );
    });
    Overlay.of(context)?.insert(entry!);
  }
}
