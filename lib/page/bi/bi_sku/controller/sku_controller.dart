import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_goods_do.dart';
import 'package:haidai_flutter_module/repository/bi/bi_goods_api.dart';

class SkuController extends SuperController {
  BiGoodsDo? goodsDo;
  var deptId;
  var topDeptId;
  var goodsId;
  List<int>? customerDeptIds;

  List<Map> skuMap = [];

  init() {
    BiGoodsApi.selectGoodsSkuByParam(topDeptId, goodsId, customerDeptIds: customerDeptIds).then((value) {
      goodsDo = value;
      List<SkuInfoEntity>  skus = value.orderGoodsVoList!;

      for (int i = 0; i < skus.length; i++) {
        for (int j = 0; j < skus[i].sizes!.length; j++) {
          var item = skus[i].sizes![j];
          Map map = new Map();
          map['itemType'] = 'sku';
          map['color'] = skus[i].goodsColor!.name;
          map['size'] = item.goodsSize!.name;
          map['skuIndex'] = [i, j];
          map['data'] = item.data;


          map['showLine'] = false;
          map['showText'] = false;
          if (j == 0) {
            map['showText'] = true;
          }
          if (j == skus[i].sizes!.length - 1) {
            map['showLine'] = true;
            map['showText'] = true;
            if (skus[i].sizes!.length > 1) {
              map['showText'] = false;
            }
          }
          skuMap.add(map);
        }
      }

      update(['sku']);
    });
  }

  @override
  void onInit() {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    topDeptId = ArgUtils.getArgument2num(Constant.TOP_DEPT_ID, def: 8512)?.toInt();
    goodsId = ArgUtils.getArgument2num(Constant.GOODS_ID, def: 8512)?.toInt();
    if (deptId != null) {
      customerDeptIds = [deptId];
    }
    init();
  }

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
