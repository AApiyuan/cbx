import 'package:haidai_flutter_module/common/sale/enums/SaleConfigDistributionEnum.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';

import '../enums/CustomerDeptConfigDataEnum.dart';
import '../util/DateUtils.dart';
import '../util/EnumCoverUtils.dart';
import 'SaleGoodsBeforeReq.dart';

/**
 * 创建销售单生成前入参
 * @author zhanyao
 */
class CreateSaleBeforeReq {
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
   * 备注
   */
  String? remark;

  /**
   * 订单商品
   */
  late List<SaleGoodsBeforeReq> goodsBeforeList;

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
    map["deptId"] = this.deptId;
    map["warehouseId"] = this.warehouseId;
    map["customizeTime"] = TimeUtils.getTime(this.customizeTime, format: "yyyy-MM-dd HH:mm:ss");
    map["customerId"] = this.customerId;
    map["customerAddress"] = this.customerAddress;
    map["tax"] = this.tax;
    map["originalAmount"] = this.originalAmount;
    map["taxOriginalAmount"] = this.taxOriginalAmount;
    map["receivableAmount"] = this.receivableAmount;
    map["taxAmount"] = this.taxAmount;;
    map["discountAmount"] = this.discountAmount;
    map["taxReceivableAmount"] = this.taxReceivableAmount;
    map["balanceAmount"] = this.balanceAmount;
    map["wipeOffAmount"] = this.wipeOffAmount;
    map["normalSaleStyleNum"] = this.normalSaleStyleNum;
    map["normalSaleNum"] = this.normalSaleNum;
    map["normalSaleAmount"] = this.normalSaleAmount;
    map["normalSaleTaxAmount"] = this.normalSaleTaxAmount;;
    map["remark"] = this.remark;
    List<Map<String, dynamic>> goodsBeforeList = [];
    for (var goodsBefore in this.goodsBeforeList) {
      goodsBeforeList.add(goodsBefore.toJson());
    }
    map["goodsBeforeList"] = goodsBeforeList;
    // map["amountTamper"] = this.amountTamper;
    map["configNormalSalePrice"] =
        EnumCoverUtils.enumsToString(this.configNormalSalePrice);
    map["configReturnGoodsPrice"] =
        EnumCoverUtils.enumsToString(this.configReturnGoodsPrice);
    map["configDistribution"] =
        EnumCoverUtils.enumsToString(this.configDistribution);
    return map;
  }

  static CreateSaleBeforeReq fromMap(Map<String, dynamic> map) {
    CreateSaleBeforeReq createSaleBeforeReq = new CreateSaleBeforeReq();
    createSaleBeforeReq.id = map['id'];
    createSaleBeforeReq.warehouseId = map['warehouseId'];
    print(
        "flutter_tag_saleReq====================================================================2");
    createSaleBeforeReq.deptId = map['deptId'];
    print(
        "flutter_tag_saleReq====================================================================3");
    createSaleBeforeReq.customizeTime = DateUtils.string2Date(map['customizeTime']);
    print(
        "flutter_tag_saleReq====================================================================4");
    createSaleBeforeReq.customerId = map['customerId'];
    print(
        "flutter_tag_saleReq====================================================================5");
    createSaleBeforeReq.customerAddress = map['customerAddress'];
    print(
        "flutter_tag_saleReq====================================================================6");
    createSaleBeforeReq.tax = map['tax'];
    print(
        "flutter_tag_saleReq====================================================================7");
    createSaleBeforeReq.originalAmount = map['originalAmount'];
    print(
        "flutter_tag_saleReq====================================================================8");
    createSaleBeforeReq.taxOriginalAmount = map['taxOriginalAmount'];
    print(
        "flutter_tag_saleReq====================================================================9");
    createSaleBeforeReq.receivableAmount = map['receivableAmount'];
    print(
        "flutter_tag_saleReq====================================================================10");
    createSaleBeforeReq.taxAmount = map['taxAmount'];
    print(
        "flutter_tag_saleReq====================================================================11");
    createSaleBeforeReq.discountAmount = map['discountAmount'];
    print(
        "flutter_tag_saleReq====================================================================12");
    createSaleBeforeReq.taxReceivableAmount = map['taxReceivableAmount'];
    print(
        "flutter_tag_saleReq====================================================================13");
    createSaleBeforeReq.balanceAmount = map['balanceAmount'];
    print(
        "flutter_tag_saleReq====================================================================14");
    createSaleBeforeReq.wipeOffAmount = map['wipeOffAmount'];
    print(
        "flutter_tag_saleReq====================================================================15");
    createSaleBeforeReq.normalSaleStyleNum = map['normalSaleStyleNum'];
    print(
        "flutter_tag_saleReq====================================================================16");
    createSaleBeforeReq.normalSaleNum = map['normalSaleNum'];
    print(
        "flutter_tag_saleReq====================================================================17");
    createSaleBeforeReq.normalSaleAmount = map['normalSaleAmount'];
    print(
        "flutter_tag_saleReq====================================================================18");
    createSaleBeforeReq.normalSaleTaxAmount = map['normalSaleTaxAmount'];
    print(
        "flutter_tag_saleReq====================================================================27");
    createSaleBeforeReq.remark = map['remark'];
    print(
        "flutter_tag_saleReq====================================================================28");
    List<SaleGoodsBeforeReq> goodsBeforeList = [];
    for (Map<String, dynamic> goodsBefore in map['goodsBeforeList']) {
      goodsBeforeList.add(SaleGoodsBeforeReq.fromMap(goodsBefore));
    }
    print(
        "flutter_tag_saleReq====================================================================29");
    createSaleBeforeReq.goodsBeforeList = goodsBeforeList;
    print(
        "flutter_tag_saleReq====================================================================31");
    createSaleBeforeReq.amountTamper = map['amountTamper'];
    print(
        "flutter_tag_saleReq====================================================================32");
    createSaleBeforeReq.configNormalSalePrice = EnumCoverUtils.stringToEnums(
        map['configNormalSalePrice'], CustomerDeptConfigDataEnum.values)!;
    print(
        "flutter_tag_saleReq====================================================================33");
    createSaleBeforeReq.configReturnGoodsPrice = EnumCoverUtils.stringToEnums(
        map['configReturnGoodsPrice'], CustomerDeptConfigDataEnum.values)!;
    print(
        "flutter_tag_saleReq====================================================================34");
    createSaleBeforeReq.configDistribution = map.containsKey('configDistribution')
        ? EnumCoverUtils.stringToEnums(
            map['configDistribution'], SaleConfigDistributionEnum.values)
        : null;
    print(
        "flutter_tag_saleReq====================================================================ok");
    return createSaleBeforeReq;
  }
}
