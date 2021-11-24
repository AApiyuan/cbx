import 'package:haidai_flutter_module/common/sale/enums/SaleConfigDistributionEnum.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';

import '../enums/CustomerDeptConfigDataEnum.dart';
import '../enums/SaleSubstandardEnum.dart';
import '../util/DateUtils.dart';
import '../util/EnumCoverUtils.dart';
import 'SaleGoodsReq.dart';

/**
 * 创建销售单入参
 * @author zhanyao
 */
class CreateSaleReq {
  /**
   * 主键
   */
  int? id;

  /**
   * 店铺id
   */
  int? deptId;

  /**
   * 自定义日期
   */
  DateTime? customizeTime;

  /**
   * 客户id 关联客户
   */
  int? customerId;

  /**
   * 客户收货地址
   */
  String? customerAddress;

  /**
   * 税率
   */
  int? tax;

  /**
   * 原始销售额（不含税）
   */
  int? originalAmount;

  /**
   * 原始销售额（含税）
   */
  int? taxOriginalAmount;

  /**
   * 销售额（不含税）
   */
  int? receivableAmount;

  /**
   * 税费
   */
  int? taxAmount;

  /**
   * 优惠
   */
  int? discountAmount;

  /**
   *  销售额 (含税)
   */
  int? taxReceivableAmount;

  /**
   * 结欠
   */
  int? balanceAmount;

  /**
   * 抹零
   */
  int? wipeOffAmount;

  /**
   * 销售商品款数目
   */
  int? normalSaleStyleNum;

  /**
   * 销售商品数目
   */
  int? normalSaleNum;

  /**
   * 销售商品金额 (不含税)
   */
  int? normalSaleAmount;

  /**
   * 销售商品金额 (含税)
   */
  int? normalSaleTaxAmount;

  /**
   * 退实物商品款数目
   */
  int? returnGoodsStyleNum;

  /**
   * 退实物商品数目
   */
  int? returnGoodsNum;

  /**
   * 退实物商品金额 (不含税)
   */
  int? returnGoodsAmount;

  /**
   * 退实物商品金额 (含税)
   */
  int? returnGoodsTaxAmount;

  /**
   * 退欠货商品款数目
   */
  int? changeBackOrderGoodsStyleNum;

  /**
   * 退欠货商品数目
   */
  int? changeBackOrderGoodsNum;

  /**
   * 退欠货商品金额 (不含税)
   */
  int? changeBackOrderGoodsAmount;

  /**
   * 退欠货商品金额 (含税)
   */
  int? changeBackOrderGoodsTaxAmount;

  /**
   * 备注
   */
  String? remark;

  /**
   * 订单商品
   */
  late List<SaleGoodsReq> goodsList;

  /**
   * 是否现场交货
   */
  bool? delivery;

  /**
   * 次品标志 0:否，1：是 {@link SaleSubstandardEnum}
   */
  late SaleSubstandardEnum substandard;

  /**
   * 价格防篡改标志
   */
  String? amountTamper;

  /**
   * 货品销售时，价格默认取“客户上次购买价”  配置 {@link CustomerDeptConfigDataEnum}
   */
  late CustomerDeptConfigDataEnum configNormalSalePrice;

  /**
   * 货品退货时，价格默认取“客户上次购买价”  配置 {@link CustomerDeptConfigDataEnum}
   */
  late CustomerDeptConfigDataEnum configReturnGoodsPrice;

  /**
   * 默认发货模式，默认取“档口发货”  配置 {@link CustomerDeptConfigDataEnum}
   */
  SaleConfigDistributionEnum? configDistribution;

  /**
   * 发货仓库id，默认发货模式为仓库配货时不能为空
   */
  int? warehouseId;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id"] = this.id;
    map["warehouseId"] = this.warehouseId;
    map["deptId"] = this.deptId;
    map["customizeTime"] = TimeUtils.getTime(this.customizeTime, format: "yyyy-MM-dd HH:mm:ss");
    map["customerId"] = this.customerId;
    map["customerAddress"] = this.customerAddress;
    map["tax"] = this.tax;
    map["originalAmount"] = this.originalAmount;
    map["taxOriginalAmount"] = this.taxOriginalAmount;
    map["receivableAmount"] = this.receivableAmount;
    map["taxAmount"] = this.taxAmount;
    map['delivery'] = this.delivery;
    map["discountAmount"] = this.discountAmount;
    map["taxReceivableAmount"] = this.taxReceivableAmount;
    map["balanceAmount"] = this.balanceAmount;
    map["wipeOffAmount"] = this.wipeOffAmount;
    map["normalSaleStyleNum"] = this.normalSaleStyleNum;
    map["normalSaleNum"] = this.normalSaleNum;
    map["normalSaleAmount"] = this.normalSaleAmount;
    map["normalSaleTaxAmount"] = this.normalSaleTaxAmount;
    map["returnGoodsStyleNum"] = this.returnGoodsStyleNum;
    map["returnGoodsNum"] = this.returnGoodsNum;
    map["returnGoodsAmount"] = this.returnGoodsAmount;
    map["returnGoodsTaxAmount"] = this.returnGoodsTaxAmount;
    map["changeBackOrderGoodsStyleNum"] = this.changeBackOrderGoodsStyleNum;
    map["changeBackOrderGoodsNum"] = this.changeBackOrderGoodsNum;
    map["changeBackOrderGoodsAmount"] = this.changeBackOrderGoodsAmount;
    map["changeBackOrderGoodsTaxAmount"] = this.changeBackOrderGoodsTaxAmount;
    map["remark"] = this.remark;
    List<Map<String, dynamic>> goodsList = [];
    for (var goods in this.goodsList) {
      goodsList.add(goods.toJson());
    }
    map["goodsList"] = goodsList;
    map["substandard"] = EnumCoverUtils.enumsToString(this.substandard);
    // map["amountTamper"] = this.amountTamper;
    map["configNormalSalePrice"] =
        EnumCoverUtils.enumsToString(this.configNormalSalePrice);
    map["configReturnGoodsPrice"] =
        EnumCoverUtils.enumsToString(this.configReturnGoodsPrice);
    map["configDistribution"] =
        EnumCoverUtils.enumsToString(this.configDistribution);
    return map;
  }

  static CreateSaleReq fromMap(Map<String, dynamic> map) {
    CreateSaleReq createSaleReq = new CreateSaleReq();
    createSaleReq.id = map['id'];
    createSaleReq.warehouseId = map['warehouseId'];
    print(
        "flutter_tag_saleReq====================================================================2");
    createSaleReq.deptId = map['deptId'];
    print(
        "flutter_tag_saleReq====================================================================3");
    createSaleReq.customizeTime = DateUtils.string2Date(map['customizeTime']);
    print(
        "flutter_tag_saleReq====================================================================4");
    createSaleReq.customerId = map['customerId'];
    createSaleReq.delivery = map['delivery'];
    print(
        "flutter_tag_saleReq====================================================================5");
    createSaleReq.customerAddress = map['customerAddress'];
    print(
        "flutter_tag_saleReq====================================================================6");
    createSaleReq.tax = map['tax'];
    print(
        "flutter_tag_saleReq====================================================================7");
    createSaleReq.originalAmount = map['originalAmount'];
    print(
        "flutter_tag_saleReq====================================================================8");
    createSaleReq.taxOriginalAmount = map['taxOriginalAmount'];
    print(
        "flutter_tag_saleReq====================================================================9");
    createSaleReq.receivableAmount = map['receivableAmount'];
    print(
        "flutter_tag_saleReq====================================================================10");
    createSaleReq.taxAmount = map['taxAmount'];
    print(
        "flutter_tag_saleReq====================================================================11");
    createSaleReq.discountAmount = map['discountAmount'];
    print(
        "flutter_tag_saleReq====================================================================12");
    createSaleReq.taxReceivableAmount = map['taxReceivableAmount'];
    print(
        "flutter_tag_saleReq====================================================================13");
    createSaleReq.balanceAmount = map['balanceAmount'];
    print(
        "flutter_tag_saleReq====================================================================14");
    createSaleReq.wipeOffAmount = map['wipeOffAmount'];
    print(
        "flutter_tag_saleReq====================================================================15");
    createSaleReq.normalSaleStyleNum = map['normalSaleStyleNum'];
    print(
        "flutter_tag_saleReq====================================================================16");
    createSaleReq.normalSaleNum = map['normalSaleNum'];
    print(
        "flutter_tag_saleReq====================================================================17");
    createSaleReq.normalSaleAmount = map['normalSaleAmount'];
    print(
        "flutter_tag_saleReq====================================================================18");
    createSaleReq.normalSaleTaxAmount = map['normalSaleTaxAmount'];
    print(
        "flutter_tag_saleReq====================================================================19");
    createSaleReq.returnGoodsStyleNum = map['returnGoodsStyleNum'];
    print(
        "flutter_tag_saleReq====================================================================20");
    createSaleReq.returnGoodsNum = map['returnGoodsNum'];
    print(
        "flutter_tag_saleReq====================================================================21");
    createSaleReq.returnGoodsAmount = map['returnGoodsAmount'];
    print(
        "flutter_tag_saleReq====================================================================22");
    createSaleReq.returnGoodsTaxAmount = map['returnGoodsTaxAmount'];
    print(
        "flutter_tag_saleReq====================================================================23");
    createSaleReq.changeBackOrderGoodsStyleNum = map['changeBackOrderGoodsStyleNum'];
    print(
        "flutter_tag_saleReq====================================================================24");
    createSaleReq.changeBackOrderGoodsNum = map['changeBackOrderGoodsNum'];
    print(
        "flutter_tag_saleReq====================================================================25");
    createSaleReq.changeBackOrderGoodsAmount = map['changeBackOrderGoodsAmount'];
    print(
        "flutter_tag_saleReq====================================================================26");
    createSaleReq.changeBackOrderGoodsTaxAmount = map['changeBackOrderGoodsTaxAmount'];
    print(
        "flutter_tag_saleReq====================================================================27");
    createSaleReq.remark = map['remark'];
    print(
        "flutter_tag_saleReq====================================================================28");
    List<SaleGoodsReq> goodsList = [];
    for (Map<String, dynamic> goods in map['goodsList']) {
      goodsList.add(SaleGoodsReq.fromMap(goods));
    }
    print(
        "flutter_tag_saleReq====================================================================29");
    createSaleReq.goodsList = goodsList;
    print(
        "flutter_tag_saleReq====================================================================30");
    createSaleReq.substandard = EnumCoverUtils.stringToEnums(
        map['substandard'], SaleSubstandardEnum.values)!;
    print(
        "flutter_tag_saleReq====================================================================31");
    createSaleReq.amountTamper = map['amountTamper'];
    print(
        "flutter_tag_saleReq====================================================================32");
    createSaleReq.configNormalSalePrice = EnumCoverUtils.stringToEnums(
        map['configNormalSalePrice'], CustomerDeptConfigDataEnum.values)!;
    print(
        "flutter_tag_saleReq====================================================================33");
    createSaleReq.configReturnGoodsPrice = EnumCoverUtils.stringToEnums(
        map['configReturnGoodsPrice'], CustomerDeptConfigDataEnum.values)!;
    print(
        "flutter_tag_saleReq====================================================================34");
    createSaleReq.configDistribution = map.containsKey('configDistribution')
        ? EnumCoverUtils.stringToEnums(
            map['configDistribution'], SaleConfigDistributionEnum.values)
        : null;
    print(
        "flutter_tag_saleReq====================================================================ok");
    return createSaleReq;
  }
}
