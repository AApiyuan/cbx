import 'package:haidai_flutter_module/common/sale/dto/CreateSaleBeforeReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/SaleGoodsBeforeReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/SaleGoodsReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/SaleGoodsSkuBeforeReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/SaleGoodsSkuReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/StoreDiscountTemplateBaseDo.dart';
import 'package:haidai_flutter_module/common/sale/enums/CustomerDeptConfigDataEnum.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleConfigDistributionEnum.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleGoodsDiscountTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleSubstandardEnum.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';

class SaleUtils {
  /// 创建订单参数
  static CreateSaleReq createSaleReq(
    var deptId,
    var customerId,
    var isSubstandard,
    List<SaleGoodsReq> goodsList, {
    int? wipeOffAmount,
    int? id,
    DateTime? dateTime,
    int? warehouseId,
    bool? delivery,
    String? remark,
    int? tax,
    bool configNormalSalePrice = false,
    bool configReturnGoodsPrice = false,
  }) {
    var saleReq = CreateSaleReq();
    saleReq.id = id;
    saleReq.deptId = deptId;
    saleReq.customizeTime = dateTime ?? DateTime.now();
    saleReq.customerId = customerId;
    saleReq.customerAddress = null;
    saleReq.tax = tax ?? 0;
    saleReq.originalAmount = 0;
    saleReq.taxOriginalAmount = 0;
    saleReq.receivableAmount = 0;
    saleReq.taxAmount = 0;
    saleReq.discountAmount = 0;
    saleReq.taxReceivableAmount = 0;
    saleReq.balanceAmount = 0;
    saleReq.wipeOffAmount = wipeOffAmount ?? 0;
    saleReq.normalSaleStyleNum = 0;
    saleReq.normalSaleNum = 0;
    saleReq.normalSaleAmount = 0;
    saleReq.normalSaleTaxAmount = 0;
    saleReq.returnGoodsStyleNum = 0;
    saleReq.returnGoodsNum = 0;
    saleReq.returnGoodsAmount = 0;
    saleReq.returnGoodsTaxAmount = 0;
    saleReq.changeBackOrderGoodsStyleNum = 0;
    saleReq.changeBackOrderGoodsNum = 0;
    saleReq.changeBackOrderGoodsAmount = 0;
    saleReq.changeBackOrderGoodsTaxAmount = 0;
    saleReq.remark = remark;
    saleReq.goodsList = goodsList;
    saleReq.delivery = delivery ?? false;
    saleReq.substandard =
        isSubstandard ? SaleSubstandardEnum.YES : SaleSubstandardEnum.NO;
    saleReq.configNormalSalePrice = configNormalSalePrice
        ? CustomerDeptConfigDataEnum.CONFIG_PRICE_1_0
        : CustomerDeptConfigDataEnum.CONFIG_PRICE_1_1;
    saleReq.configReturnGoodsPrice = configReturnGoodsPrice
        ? CustomerDeptConfigDataEnum.CONFIG_PRICE_2_0
        : CustomerDeptConfigDataEnum.CONFIG_PRICE_2_1;
    saleReq.configDistribution = warehouseId == null
        ? SaleConfigDistributionEnum.CONFIG_DISTRIBUTION_1_0
        : SaleConfigDistributionEnum.CONFIG_DISTRIBUTION_1_1;
    saleReq.warehouseId = warehouseId;
    return saleReq;
  }

  /// 创建货品参数
  static SaleGoodsReq createGoodsReq(
    SaleTypeEnum type,
    int goodsId,
    List<SaleGoodsSkuReq> skuReq,
    int salePrice, {
    int? id,
    int? relationOrderSaleId,
    int? relationOrderSaleGoodsId,
    int? price = 0,
    int? discount = 0,
    SaleGoodsDiscountTypeEnum? discountType = SaleGoodsDiscountTypeEnum.NONE,
    StoreDiscountTemplateBaseDo? storeDiscountTemplate,
    String? remark,
    int? oweGoodsId,
  }) {
    var goodsReq = SaleGoodsReq();
    goodsReq.id = id;
    goodsReq.oweGoodsId = oweGoodsId;
    goodsReq.type = type;
    goodsReq.relationOrderSaleId = relationOrderSaleId;
    goodsReq.relationOrderSaleGoodsId = relationOrderSaleGoodsId;
    goodsReq.goodsId = goodsId;
    goodsReq.salePrice = salePrice;
    goodsReq.taxSalePrice = 0;
    goodsReq.price = price;
    goodsReq.taxPrice = 0;
    goodsReq.originalAmount = 0;
    goodsReq.taxOriginalAmount = 0;
    goodsReq.receivableAmount = 0;
    goodsReq.taxAmount = 0;
    goodsReq.discountAmount = 0;
    goodsReq.discountType = discountType ?? SaleGoodsDiscountTypeEnum.NONE;
    goodsReq.discount = discount;
    goodsReq.discountTemplateId = storeDiscountTemplate?.id;
    goodsReq.storeDiscountTemplate = storeDiscountTemplate;
    goodsReq.remark = remark;
    var goodsNum = 0;
    skuReq.forEach((element) => goodsNum += (element.goodsNum ?? 0));
    goodsReq.goodsNum = goodsNum;
    goodsReq.goodsSkuList = skuReq;
    return goodsReq;
  }

  /// 创建sku参数
  static SaleGoodsSkuReq createGoodsSkuReq(
    int goodsId,
    int skuId,
    int goodsNum, {
    int? id,
    int? relationOrderSaleId,
    int? relationOrderSaleGoodsId,
    int? relationOrderSaleGoodsSkuId,
  }) {
    var skuReq = SaleGoodsSkuReq();
    skuReq.id = id;
    skuReq.relationOrderSaleId = relationOrderSaleId;
    skuReq.relationOrderSaleGoodsId = relationOrderSaleGoodsId;
    skuReq.relationOrderSaleGoodsSkuId = relationOrderSaleGoodsSkuId;
    skuReq.goodsId = goodsId;
    skuReq.skuId = skuId;
    skuReq.goodsNum = goodsNum;
    skuReq.salePrice = 0;
    skuReq.taxSalePrice = 0;
    skuReq.price = 0;
    skuReq.taxPrice = 0;
    skuReq.originalAmount = 0;
    skuReq.taxOriginalAmount = 0;
    skuReq.receivableAmount = 0;
    skuReq.taxAmount = 0;
    skuReq.discountAmount = 0;
    skuReq.taxReceivableAmount = 0;
    return skuReq;
  }

  /// 销售sku req
  static SaleGoodsSkuReq createSaleGoodsSku(int goodsId, SkuInfoSizesData sku) {
    return createGoodsSkuReq(goodsId, sku.skuId!, sku.num!, id: sku.id);
  }

  /// 销售goods req
  static SaleGoodsReq createSaleGoods(
      SaleDetailDoSaleGoodsList saleGoods, List<SaleGoodsSkuReq> skuReq) {
    var discountTempJson = saleGoods.discountTemplateDetail?.toJson();
    var discountTemp;
    if (discountTempJson != null) {
      discountTemp = StoreDiscountTemplateBaseDo.fromMap(discountTempJson);
    }
    return createGoodsReq(
      SaleTypeEnum.NORMAL_SALE,
      saleGoods.goodsId!,
      skuReq,
      saleGoods.salePrice!,
      price: saleGoods.price,
      id: saleGoods.id,
      remark: saleGoods.remark,
      discount: saleGoods.discount,
      storeDiscountTemplate: discountTemp,
      discountType: EnumCoverUtils.stringToEnums(
          saleGoods.discountType, SaleGoodsDiscountTypeEnum.values),
    );
  }

  /// 退实物sku req
  static SaleGoodsSkuReq createReturnGoodsSku(
      int goodsId, SkuInfoSizesData sku) {
    return createGoodsSkuReq(goodsId, sku.skuId!, -sku.num!.abs(), id: sku.id);
  }

  /// 退实物goods req
  static SaleGoodsReq createReturnGoods(
      SaleDetailDoSaleGoodsList returnGoods, List<SaleGoodsSkuReq> skuReq) {
    return createGoodsReq(
      SaleTypeEnum.RETURN_GOODS,
      returnGoods.goodsId!,
      skuReq,
      returnGoods.salePrice!,
      id: returnGoods.id,
      remark: returnGoods.remark,
      price: returnGoods.price,
      discountType: EnumCoverUtils.stringToEnums(
          returnGoods.discountType, SaleGoodsDiscountTypeEnum.values),
    );
  }

  /// 退欠货sku req
  static SaleGoodsSkuReq createOweGoodsSku(
      int goodsId, SkuInfoSizesData sku, bool isEdit) {
    return createGoodsSkuReq(goodsId, sku.skuId!, -sku.num!.abs(),
        id: sku.relationOrderSaleId != null ? sku.id : null,
        relationOrderSaleId: sku.relationOrderSaleId ?? sku.orderSaleId,
        relationOrderSaleGoodsId:
            sku.relationOrderSaleGoodsId ?? sku.orderSaleGoodsId,
        relationOrderSaleGoodsSkuId: sku.relationOrderSaleGoodsSkuId ?? sku.id);
  }

  /// 退欠货goods req
  static SaleGoodsReq createOweGoods(SaleDetailDoSaleGoodsList oweGoods,
      List<SaleGoodsSkuReq> skuReq, bool isEdit) {
    return createGoodsReq(
      SaleTypeEnum.CHANGE_BACK_ORDER,
      oweGoods.goodsId!,
      skuReq,
      oweGoods.taxPrice!,
      id: oweGoods.relationOrderSaleGoodsId == null ? null : oweGoods.id,
      price: oweGoods.taxPrice,
      oweGoodsId: oweGoods.id,
      remark: oweGoods.remark,
      relationOrderSaleGoodsId:
          oweGoods.relationOrderSaleGoodsId ?? oweGoods.id,
      relationOrderSaleId: oweGoods.relationOrderSaleId ?? oweGoods.orderSaleId,
    );
  }

  /// 报价单

  /// 创建报价单订单参数
  static CreateSaleBeforeReq createSaleBeforeReq(
    var deptId,
    var customerId,
    List<SaleGoodsBeforeReq> goodsList, {
    int? wipeOffAmount,
    int? id,
    DateTime? dateTime,
    int? warehouseId,
    String? remark,
    int? tax,
  }) {
    var saleReq = CreateSaleBeforeReq();
    saleReq.id = id;
    saleReq.deptId = deptId;
    saleReq.customizeTime = dateTime ?? DateTime.now();
    saleReq.customerId = customerId;
    saleReq.customerAddress = null;
    saleReq.tax = tax ?? 0;
    saleReq.originalAmount = 0;
    saleReq.taxOriginalAmount = 0;
    saleReq.receivableAmount = 0;
    saleReq.taxAmount = 0;
    saleReq.discountAmount = 0;
    saleReq.taxReceivableAmount = 0;
    saleReq.balanceAmount = 0;
    saleReq.wipeOffAmount = wipeOffAmount ?? 0;
    saleReq.normalSaleStyleNum = 0;
    saleReq.normalSaleNum = 0;
    saleReq.normalSaleAmount = 0;
    saleReq.normalSaleTaxAmount = 0;
    saleReq.remark = remark;
    saleReq.goodsBeforeList = goodsList;
    saleReq.configNormalSalePrice = CustomerDeptConfigDataEnum.CONFIG_PRICE_1_1;
    saleReq.configReturnGoodsPrice =
        CustomerDeptConfigDataEnum.CONFIG_PRICE_2_1;
    saleReq.configDistribution = warehouseId == null
        ? SaleConfigDistributionEnum.CONFIG_DISTRIBUTION_1_0
        : SaleConfigDistributionEnum.CONFIG_DISTRIBUTION_1_1;
    saleReq.warehouseId = warehouseId;
    return saleReq;
  }

  /// 创建报价单货品参数
  static SaleGoodsBeforeReq createGoodsBeforeReq(
    List<SaleGoodsSkuBeforeReq> skuReq,
    SaleDetailDoSaleGoodsList saleGoods, {
    int? id,
    String? remark,
  }) {
    var discountTempJson = saleGoods.discountTemplateDetail?.toJson();
    var storeDiscountTemplate;
    if (discountTempJson != null) {
      storeDiscountTemplate =
          StoreDiscountTemplateBaseDo.fromMap(discountTempJson);
    }
    var goodsReq = SaleGoodsBeforeReq();
    goodsReq.id = id;
    goodsReq.goodsId = saleGoods.goodsId!;
    goodsReq.salePrice = saleGoods.salePrice!;
    goodsReq.taxSalePrice = 0;
    goodsReq.price = saleGoods.price;
    goodsReq.taxPrice = 0;
    goodsReq.originalAmount = 0;
    goodsReq.taxOriginalAmount = 0;
    goodsReq.receivableAmount = 0;
    goodsReq.taxAmount = 0;
    goodsReq.discountAmount = 0;
    goodsReq.taxReceivableAmount = 0;
    goodsReq.discountType = EnumCoverUtils.stringToEnums(
            saleGoods.discountType, SaleGoodsDiscountTypeEnum.values) ??
        SaleGoodsDiscountTypeEnum.NONE;
    goodsReq.discount = saleGoods.discount;
    goodsReq.discountTemplateId = storeDiscountTemplate?.id;
    goodsReq.storeDiscountTemplate = storeDiscountTemplate;
    goodsReq.remark = remark;
    var goodsNum = 0;
    skuReq.forEach((element) => goodsNum += (element.goodsNum ?? 0));
    goodsReq.goodsNum = goodsNum;
    goodsReq.goodsSkuBeforeList = skuReq;
    return goodsReq;
  }

  /// 创建报价单sku参数
  static SaleGoodsSkuBeforeReq createGoodsSkuBeforeReq(
      int goodsId, SkuInfoSizesData sku,
      {int? id}) {
    var skuReq = SaleGoodsSkuBeforeReq();
    skuReq.id = id;
    skuReq.goodsId = goodsId;
    skuReq.skuId = sku.skuId!;
    skuReq.goodsNum = sku.num!;
    skuReq.salePrice = 0;
    skuReq.taxSalePrice = 0;
    skuReq.price = 0;
    skuReq.taxPrice = 0;
    skuReq.originalAmount = 0;
    skuReq.taxOriginalAmount = 0;
    skuReq.receivableAmount = 0;
    skuReq.taxAmount = 0;
    skuReq.discountAmount = 0;
    skuReq.taxReceivableAmount = 0;
    return skuReq;
  }
}
