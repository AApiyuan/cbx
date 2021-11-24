import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';

import 'package:haidai_flutter_module/repository/check_api.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/inventory_history_pagereq_entity.dart';
import 'package:haidai_flutter_module/model/checkCenter/inventory_history_entity.dart';

class CheckHistortController extends GetxController{
  int _pageNo = 1; //页码
  int _pageSize = 15; //页数
  late InventoryHistoryPagereqEntity _entity;
  List<InventoryHistoryEntity> inventoryHistoryEntity = [];

  static String ids = "checkHistort";
  bool noMore = false;//是否需要加载更多
  num deptId = ArgUtils.getArgument2num('depId')!;

  //CheckHistortController();

  Future _getData() async {
    BasePage basePage = new BasePage();
    basePage.pageNo = _pageNo;
    basePage.pageSize = _pageSize;

    _entity = new InventoryHistoryPagereqEntity();
    _entity.deptIds = [deptId as int];
    // if(startTime.isNotEmpty)
    // _entity.startTime = startTime;
    // if(endTime.isNotEmpty)
    // _entity.endTime = endTime;
    _entity.status = "FINISH";
    // entity.status
    basePage.param = _entity;

    return await CheckApi.checkHistory(basePage).then((value) {
      List<InventoryHistoryEntity> list = value.toList();
      inventoryHistoryEntity.addAll(list);
      noMore = list.length < _pageSize;
      update([ids]);
      // return value;
      // print("future:   value:"+value[0].id.toString());
    }, onError: (e) {
      print("flutter:   error1:$e");
    });
    // return entity;

  }

  Future next() {
    if (noMore) Future.value();
    _pageNo++;
    return _getData();
  }

  List<InventoryHistoryEntity> getValue(){
    return inventoryHistoryEntity;
  }

  InventoryHistoryEntity? getItem(int index){
    return getValue().length > index ? inventoryHistoryEntity[index] : null;
  }

  Future reset() {
    _pageNo = 1;
    noMore = false;
    inventoryHistoryEntity.clear();
    return _getData();
  }

  @override
  void onInit() {
    super.onInit();
    print('GoodsPageController--onInit');

  }

  @override
  void onReady() {
    super.onReady();
    print('GoodsPageController--onReady');
  }

  @override
  void onClose() {
    super.onClose();
    print('GoodsPageController--onClose');
  }
}