import 'dart:collection';

import 'package:get/get.dart';

class SkuOperationController extends GetxController {
  Map<int, int> selectSkuMap = LinkedHashMap();//sku数据

  static String bIdSku(num skuId) => "id_sku=$skuId";//更新sku数据

  static String bIdGoods() => "id_goods";//更新货品数量

  get skuData => selectSkuMap;//获取sku数据

  ///设置当前货品的sku数据
  setSkuData(Map<int, int> skuMap) {
    this.selectSkuMap = skuMap;
  }

  ///减少sku
  minusNum(int skuId) {
    int count = selectSkuMap[skuId]!;
    if (count == 0) return;
    selectSkuMap[skuId] = count - 1;
    update([bIdSku(skuId), bIdGoods()]);
  }

  ///增加sku
  addNum(int skuId) {
    selectSkuMap[skuId] = selectSkuMap[skuId]! + 1;
    update([bIdSku(skuId), bIdGoods()]);
  }

  ///更新sku
  updateNum(int skuId, int count) {
    selectSkuMap[skuId] = count;
    update([bIdSku(skuId), bIdGoods()]);
  }

  ///获取sku的选择数
  int getSelectNum(num skuId) {
    return selectSkuMap[skuId]!;
  }

  ///获取货品所有sku的选择总数
  int selectCount() {
    int count = 0;
    selectSkuMap.forEach((key, value) => count += value);
    return count;
  }
}
