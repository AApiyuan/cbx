import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';

class TransferCenterSelectGoodController extends SuperController {
  ///成员变量
  var searchText = ""; // 搜索文案
  List goodsList = []; // 货品列表
  int deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getGoodsList(false);
  }
  ///获取货品列表
  Future getGoodsList(bool next) async {
    BasePage basePage = new BasePage();
    basePage.pageSize = 999;
    basePage.pageNo = 1;
    var param = {
      "selectType" : "BASIC",
      "goodsNameSerial" : "",
      "deptId" : deptId,
      "goodsNameSerial": searchText
    };
    basePage.param = param;
    return await TransferApi.getTransferGoodList(basePage).then((entity) {
      goodsList = entity;
      update(['TransferCenterSelectgoodListView']);
    });
  }



  /// 更新搜索文案
  updateSearchText(var searchText) {
    this.searchText = searchText;

  }

  /// 搜索
  search(var searchText) {
    this.searchText = searchText;
    getGoodsList(false);
  }


  /// 选择货品
  // Future selectGoods(Goods goods) {
    // return Goods();
    // if (getSelectNum(goods.id!) == 0) {
    //   return getGoodsSku(goods);
    // } else {
    //   GoodsSkuEntity goodsSkuEntity =
    //   new GoodsSkuEntity(goods, [], SaleDetailDoSaleGoodsList());
    //   return Future.value(goodsSkuEntity);
    // }
  // }


  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
