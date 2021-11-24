import '../enums/StoreDiscountTemplateEnum.dart';
import '../util/EnumCoverUtils.dart';

/**
 * <p>
 * 优惠模板 基础信息
 * </p>
 *
 * @author zhanyao
 * @since 2020-09-10
 */
class StoreDiscountTemplateBaseDo {

	/**
	 * 主键
	 */
	int? id;

	/**
	 * 类型 0：清仓，1：满减
	 */
	StoreDiscountTemplateEnum? style;

	/**
	 * 满数 满多少件
	 */
	int? enableNum;

	/**
	 * 满额
	 */
	int? totalPrice;

	/**
	 * 未满额单价 不满足时候促销单价
	 */
	int? discountPrice;

	Map<String, dynamic> toJson() {
		Map<String, dynamic> map = new Map<String, dynamic>();
		map["id"] = this.id;
		map["style"] = EnumCoverUtils.enumsToString(this.style);
		map["enableNum"] = this.enableNum;
		map["totalPrice"] = this.totalPrice;
		map["discountPrice"] = this.discountPrice;
		return map;
	}

	static StoreDiscountTemplateBaseDo fromMap(Map<String, dynamic> map) {
		print("flutter_tag===============discount===============00000");
		StoreDiscountTemplateBaseDo storeDiscountTemplateBaseDo = new StoreDiscountTemplateBaseDo();
		print("flutter_tag===============discount===============0");
		storeDiscountTemplateBaseDo.id = map['id'];
		print("flutter_tag===============discount===============1");
		storeDiscountTemplateBaseDo.style = EnumCoverUtils.stringToEnums(map['style'],StoreDiscountTemplateEnum.values);
		print("flutter_tag===============discount===============2");
		storeDiscountTemplateBaseDo.enableNum = map['enableNum'];
		print("flutter_tag===============discount===============3");
		storeDiscountTemplateBaseDo.totalPrice = map['totalPrice'];
		print("flutter_tag===============discount===============4");
		storeDiscountTemplateBaseDo.discountPrice = map['discountPrice'];
		print("flutter_tag===============discount===============ok");
		return storeDiscountTemplateBaseDo;
	}
}
