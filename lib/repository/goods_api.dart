import 'dart:convert';

import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/db/sql_db.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/goods/store_goods_do.dart';
import 'package:haidai_flutter_module/model/rep/store_goods_sku_req_entity.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';
import 'package:haidai_flutter_module/model/store_goods_sku_resp_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/req/batch_customer_buy_price_req_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/store_goods_with_price_vo_entity.dart';

class GoodsApi {
  static final String goodsPage = "goods/goods/page";
  static final String _getGoodsDetail = "/goods/goods/detail";
  static final String skuList = "goods/goods/v2/sku";
  static final String goodsSku = "/goods/goods/selectStoreGoodsSkuByParam";
  static final String goodsImages = "/goods/goods/imgs";
  static final String skuWithCustomerPrice = "/goods/goods/skuWithCustomerPrice";
  static final String getGoodsSkuAndPrice = "/goods/goods/skuWithCustomerPrice";

  /// 获取商品筛选条件
  static final String selectByCustomerDeptId = "/base/storeDict/selectByCustomerDeptId";

  static Future<List<Goods>> page(dynamic param, {bool online = true, showLoading = false}) async {
    // 单独goods 用 Goods goods = goodsFromJson(new Goods(), jsonData);
    // return res.map<Goods>((e) => goodsFromJson(new Goods(), e)).toList();
    // List<Goods> goods;
    // res.map((e) {
    //   Goods g = goodsFromJson(new Goods(), e) as Goods;
    //   goods.add(g);
    // });
    // return goods;
    print("flutter_tag=======${jsonEncode(param)}");
    if (online) {
      var res = await HttpUtils.post(
        goodsPage,
        data: param,
        baseUrl: Config.GOODS_API_URL,
        showLoading: showLoading,
      );
      return res.map<Goods>((e) => new Goods().fromJson(e)).toList();
    } else {
      return GoodsQuery.select(basePage: param);
    }
    // return res.map<Goods>((e) => new Goods().fromJson(e)).toList();
  }

  static Future<StoreGoodsDo> getGoodsDetail(int goodsId, {int? deptId, bool? isBasic}) async {
    Map<String, Object> param = new Map();
    param['goodsId'] = goodsId;
    if (deptId != null) {
      param['deptId'] = deptId;
    }
    if (isBasic != null) {
      param['isBasic'] = isBasic;
    }
    var res = await HttpUtils.post(
      _getGoodsDetail,
      data: param,
      baseUrl: Config.GOODS_API_URL,
    );
    return new StoreGoodsDo().fromJson(res);
  }

  static Future<List<StoreGoodsWithPriceVoEntity>> getGoodsLastPrice(BatchCustomerBuyPriceReqEntity param) async {
    var res = await HttpUtils.post(
      skuWithCustomerPrice,
      data: param,
      baseUrl: Config.GOODS_API_URL,
    );
    return res.map<StoreGoodsWithPriceVoEntity>((e) => new StoreGoodsWithPriceVoEntity().fromJson(e)).toList();
  }

  static Future<StoreGoodsWithPriceVoEntity> getGoodsPrice(int goodsId, int deptId, int? customerId) async {
    var res = await HttpUtils.get(
      getGoodsSkuAndPrice,
      params: {
        "goodsId": goodsId,
        "deptId": deptId,
        "customerId": customerId,
        "returnCustomerDeliveryNum": false,
      },
      baseUrl: Config.GOODS_API_URL,
    );
    return new StoreGoodsWithPriceVoEntity().fromJson(res);
  }

  static Future<List<SkuInfoEntity>> getSkuList(StoreGoodsSkuReqEntity params, {bool online = true, bool showLoading = false}) async {
    if (online) {
      var res = await HttpUtils.post(goodsSku, data: params, baseUrl: Config.GOODS_API_URL, showLoading: showLoading);
      var goodsInfo = StoreGoodsSkuRespEntity().fromJson(res);
      return goodsInfo.orderGoodsVoList ?? [];
      // return res
      //     .map<SkuInfoEntity>((e) => new SkuInfoEntity().fromJson(e))
      //     .toList();
    } else {
      return GoodsQuery.sku(params.deptId!, params.goodsId!);
    }
  }

  static Future<StoreDictDo> getGoodsFilterConditions(num customerDeptId, {bool returnDisable = false}) async {
    var res = await HttpUtils.get(selectByCustomerDeptId,
        baseUrl: Config.BASE_API_URL, params: {"customerDeptId": customerDeptId, "returnDisable": returnDisable});
    return new StoreDictDo().fromJson(res);
  }

  static Future<List<String>> getGoodsImages(int goodsId) async {
    var res = await HttpUtils.get(
      goodsImages,
      params: {"id": goodsId},
      baseUrl: Config.GOODS_API_URL,
    );
    List<String> images = <String>[];
    for (String s in res) {
      images.add(s);
    }
    return images;
  }
}
