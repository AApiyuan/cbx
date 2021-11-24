import 'dart:convert';

import 'dto/CreateSaleBeforeReq.dart';
import 'dto/SaleGoodsBeforeReq.dart';
import 'dto/SaleGoodsSkuBeforeReq.dart';
import 'dto/StoreDiscountTemplateBaseDo.dart';
import 'enums/SaleConfigDistributionEnum.dart';
import 'enums/SaleGoodsDiscountTypeEnum.dart';
import 'package:crypto/crypto.dart';

/**
 * 订单模块 销售单生产前金额计算类
 * @author zhanyao
 * @since 2020-08-10
 */
class CalculateSaleBeforeAmountUtil {

	/**
	 * 销售单金额计算
	 * @param param 入参
	 * @param checkAmount 核本单
	 * @return 结果
	 */
	static CreateSaleBeforeReq calculateSaleAmount(CreateSaleBeforeReq param, int checkAmount) {
		print("flutter_tag_calculate==============================start");
		if(param.configDistribution == null){
			throw new Exception("默认发货模式不能为空");
		}
		if(param.configDistribution == SaleConfigDistributionEnum.CONFIG_DISTRIBUTION_1_1 && (param.warehouseId == null || param.warehouseId == 0)){
			throw new Exception("仓库配货模式下，仓库ID不能为空");
		}
		print("flutter_tag_calculate==============================0");
		for (SaleGoodsBeforeReq g in param.goodsBeforeList) {
			print("flutter_tag_calculate==============================0.1");
			int tax = 100;
				tax += param.tax!;
				print("flutter_tag_calculate==============================0.2");
			print("flutter_tag_calculate==============================0.3");
			//校验数据
			checkData(g);
			print("flutter_tag_calculate==============================0.4");
			g.originalAmount = g.salePrice! * g.goodsNum!;
			g.taxSalePrice = (g.salePrice! * tax / 100).round();
			g.taxOriginalAmount = (g.taxSalePrice ?? 0) * g.goodsNum!;

			param.originalAmount = param.originalAmount! + g.originalAmount!;
			param.taxOriginalAmount = param.taxOriginalAmount! + g.taxOriginalAmount!;
		}
		print("flutter_tag_calculate==============================1");
		param.originalAmount = 0;
		param.taxOriginalAmount = 0;
		param.receivableAmount = 0;
		param.taxReceivableAmount = 0;
		param.discountAmount = 0;
		param.taxAmount = 0;
		//初始化 其他计算
		initCreateSaleGoodsByNotTemplate(param);
		print("flutter_tag_calculate==============================2");

		List<SaleGoodsBeforeReq> list = [];
		for (SaleGoodsBeforeReq goodsBefore in param.goodsBeforeList) {
			if(goodsBefore.discountType == SaleGoodsDiscountTypeEnum.TEMPLATE){
				list.add(goodsBefore);
			}
		}
		print("flutter_tag_calculate==============================3");
		if(list.length > 0){
			for (SaleGoodsBeforeReq saleGoodsBefore in list) {
				StoreDiscountTemplateBaseDo? discountTemplateDo = saleGoodsBefore.storeDiscountTemplate;
				if(saleGoodsBefore.discountTemplateId == null || discountTemplateDo == null){
					throw new Exception("优惠模板不能为空!");
				}
				if(discountTemplateDo.id == null){
					saleGoodsBefore.storeDiscountTemplate?.id = saleGoodsBefore.discountTemplateId!;
				}
				if(discountTemplateDo.style == null){
					throw new Exception("优惠模板类型不能为空!");
				}
				if(discountTemplateDo.enableNum == null || discountTemplateDo.enableNum! < 1){
					throw new Exception("满数不能为空,满数不能小于1!");
				}
				if(discountTemplateDo.totalPrice == null || discountTemplateDo.totalPrice! < 1){
					throw new Exception("满额不能为空,满额不能小于0.01!");
				}
				if(discountTemplateDo.discountPrice == null || discountTemplateDo.discountPrice! < 1){
					throw new Exception("未满额单价不能为空,未满额单价不能小于0.01!");
				}
			}
			print("flutter_tag_calculate==============================4");
			//初始化 模板计算
			initCreateSaleGoodsByTemplate(param);
			print("flutter_tag_calculate==============================5");
		}
		print("flutter_tag_calculate==============================6");

		int normalSaleStyleNum = 0;
		int normalSaleNum = 0;
		int normalSaleAmount = 0;
		int normalSaleTaxAmount = 0;

		//汇总商品金额到订单
		for (SaleGoodsBeforeReq g in param.goodsBeforeList) {
			param.discountAmount = param.discountAmount! + g.discountAmount!;
			param.receivableAmount = param.receivableAmount! + g.receivableAmount!;
			param.taxAmount = param.taxAmount! + g.taxAmount!;
			param.taxReceivableAmount = param.taxReceivableAmount! + g.taxReceivableAmount!;

			normalSaleStyleNum += 1;
			normalSaleNum += g.goodsNum!;
			normalSaleAmount += g.receivableAmount!;
			normalSaleTaxAmount += g.taxReceivableAmount!;
		}
		print("flutter_tag_calculate==============================7");

		param.normalSaleStyleNum = normalSaleStyleNum;
		param.normalSaleNum = normalSaleNum;
		param.normalSaleAmount = normalSaleAmount;
		param.normalSaleTaxAmount = normalSaleTaxAmount;

		//分摊商品金额
		shareGoodsAmount(param);
		print("flutter_tag_calculate==============================8");
		param.balanceAmount = param.taxReceivableAmount! - checkAmount - param.wipeOffAmount!;
		//生成防篡改码
		initAmountTamper(param);
		print("flutter_tag_calculate==============================9");
		return param;
	}

	/**
	 * 生成防篡改码
	 */
	static void initAmountTamper(CreateSaleBeforeReq param){
		print("flutter_tag_calculate==============================8.1");
		if(param.amountTamper == null || param.amountTamper == ""){
			print("flutter_tag_calculate==============================$param");
			print("flutter_tag_calculate==============================${jsonEncode(param.toJson())}");
			param.amountTamper = md5.convert(utf8.encode(jsonEncode(param.toJson()))).toString();
			print("flutter_tag_calculate==============================8.2");
		}
		print("flutter_tag_calculate==============================8.3");
	}

	/**
	 * 初始化 其他计算
	 * @param createSaleReq 入参
	 */
	static void initCreateSaleGoodsByNotTemplate(CreateSaleBeforeReq createSaleBeforeReq) {
		List<SaleGoodsBeforeReq> list = <SaleGoodsBeforeReq>[];
		for (SaleGoodsBeforeReq goodsBefore in createSaleBeforeReq.goodsBeforeList) {
			if(goodsBefore.discountType != SaleGoodsDiscountTypeEnum.TEMPLATE){
				list.add(goodsBefore);
			}
		}
		if(list.length > 0){
			for (SaleGoodsBeforeReq g in list) {
				int tax = 100;
				tax += createSaleBeforeReq.tax!;
				//计算优惠和平均售价
				if(g.discountType == SaleGoodsDiscountTypeEnum.REBATE){
					double discount = (g.discount ?? 0) / 100;
					g.price = (g.salePrice! * discount).round();
					g.receivableAmount = (g.price ?? 0) * g.goodsNum!;

					g.taxPrice = ((g.price ?? 0) * tax / 100).round();
					g.taxReceivableAmount = (g.taxPrice ?? 0) * g.goodsNum!;
				}else if(g.discountType == SaleGoodsDiscountTypeEnum.CHANGE_PRICE){
					if(g.price == null){
						throw new Exception("商品价格不能为空");
					}
					if((g.price ?? 0) < 0){
						throw new Exception("商品价格不能小于0");
					}
					g.receivableAmount = (g.price ?? 0) * g.goodsNum!;

					g.taxPrice = ((g.price ?? 0) * tax / 100).round();
					g.taxReceivableAmount = (g.taxPrice ?? 0) * g.goodsNum!;
				}else{
					g.price = g.salePrice;
					g.receivableAmount = g.originalAmount;

					g.taxPrice = g.taxSalePrice;
					g.taxReceivableAmount = (g.taxPrice ?? 0) * g.goodsNum!;
				}

				g.discountAmount = g.originalAmount! - g.receivableAmount!;
				g.taxAmount = g.taxReceivableAmount! - g.receivableAmount!;
			}
		}

	}

	/**
	 * 初始化 模板计算
	 * @param createSaleReq 入参
	 */
	static void initCreateSaleGoodsByTemplate(CreateSaleBeforeReq createSaleBeforeReq) {
		int tax = 100 + createSaleBeforeReq.tax!;
		List<SaleGoodsBeforeReq> list = <SaleGoodsBeforeReq>[];
		for (SaleGoodsBeforeReq goodsBefore in createSaleBeforeReq.goodsBeforeList) {
			if(goodsBefore.discountType == SaleGoodsDiscountTypeEnum.TEMPLATE){
				list.add(goodsBefore);
			}
		}
		if(list.length > 0){
			Map<int,List<SaleGoodsBeforeReq>> map = new Map();
			Map<int, StoreDiscountTemplateBaseDo> storeDiscountTemplateDoMap = new Map();

			for (SaleGoodsBeforeReq saleGoodsBefore in list) {
				storeDiscountTemplateDoMap.putIfAbsent(saleGoodsBefore.storeDiscountTemplate!.id!,() => saleGoodsBefore.storeDiscountTemplate!);
				List<SaleGoodsBeforeReq>? tmp = map[saleGoodsBefore.storeDiscountTemplate!.id];
				if(tmp == null) {
					tmp = <SaleGoodsBeforeReq>[];
				}
				tmp.add(saleGoodsBefore);
				map.putIfAbsent(saleGoodsBefore.storeDiscountTemplate!.id!,() => tmp!);
			}
			map.forEach((k,v) {
				StoreDiscountTemplateBaseDo detail = storeDiscountTemplateDoMap[k]!;

				int goodsNum = 0;
				for (SaleGoodsBeforeReq saleGoodsBefore in v) {
					goodsNum += saleGoodsBefore.goodsNum!;
				}
				if(goodsNum >= detail.enableNum!){
					int price = (detail.totalPrice! / detail.enableNum!).round();
					int taxPrice = (detail.totalPrice! * tax / (detail.enableNum! * 100)).round();

					int s1 = (goodsNum / detail.enableNum!).floor();
					int s2 = goodsNum % detail.enableNum!;

					int totalAmount = 0;
					int totalTaxAmount = 0;
					if(s1 > 0){
						totalAmount += s1 * detail.totalPrice!;
						totalTaxAmount += (s1 * detail.totalPrice! * tax / 100).round();
					}
					if(s2 > 0){
						totalAmount += (s2 * detail.totalPrice!/detail.enableNum!).round();
						totalTaxAmount += (s2 * detail.totalPrice! * tax/(detail.enableNum! * 100)).round();
					}

					int totalTaxReceivableAmount = 0;
					int totalReceivableAmount = 0;
					for (int i = 0 ; i < v.length - 1 ; i++){
						SaleGoodsBeforeReq g = v[i];

						g.price = price;
						g.receivableAmount = price * g.goodsNum!;

						g.taxPrice = taxPrice;
						g.taxReceivableAmount = taxPrice * g.goodsNum!;

						g.discountAmount = g.taxOriginalAmount! - g.taxReceivableAmount!;
						g.taxAmount = g.taxReceivableAmount! - g.receivableAmount!;

						totalTaxReceivableAmount += g.taxReceivableAmount!;
						totalReceivableAmount += g.receivableAmount!;
					}

					SaleGoodsBeforeReq last = v[v.length - 1];
					last.price = price;
					last.receivableAmount = totalAmount - totalReceivableAmount;

					last.taxPrice = taxPrice;
					last.taxReceivableAmount = totalTaxAmount - totalTaxReceivableAmount;

					last.discountAmount = last.originalAmount! - last.receivableAmount!;
					last.taxAmount = last.taxReceivableAmount! - last.receivableAmount!;
				}else{
					for (SaleGoodsBeforeReq g in v) {

						g.price = detail.discountPrice;
						g.receivableAmount = (g.price ?? 0) * g.goodsNum!;

						g.taxPrice = ((g.price ?? 0) * tax / 100).round();
						g.taxReceivableAmount = (g.taxPrice ?? 0) * g.goodsNum!;

						g.discountAmount = g.originalAmount! - g.receivableAmount!;
						g.taxAmount = g.taxReceivableAmount! - g.receivableAmount!;
					}
				}
			});
		}
	}

	/**
	 * 分摊商品金额
	 * @param param 入参
	 */
	static void shareGoodsAmount(CreateSaleBeforeReq param) {
		for (SaleGoodsBeforeReq goodsBefore in param.goodsBeforeList) {
			int receiptsAmount = 0;
			int receivableAmount = 0;
			for(int i = 0; i < goodsBefore.goodsSkuBeforeList.length - 1 ; i++){
				SaleGoodsSkuBeforeReq s = goodsBefore.goodsSkuBeforeList[i];
				s.salePrice = goodsBefore.salePrice;
				s.taxSalePrice = goodsBefore.taxSalePrice;
				s.price = goodsBefore.price;
				s.taxPrice = goodsBefore.taxPrice;
				s.originalAmount = s.salePrice! * s.goodsNum!;
				s.taxOriginalAmount = (s.taxSalePrice ?? 0) * s.goodsNum!;

				s.taxReceivableAmount = (s.taxPrice ?? 0) * s.goodsNum!;
				s.receivableAmount = (s.price ?? 0) * s.goodsNum!;

				s.discountAmount = s.taxOriginalAmount! - s.taxReceivableAmount!;
				s.taxAmount = s.taxReceivableAmount! - s.receivableAmount!;

				receiptsAmount += s.taxReceivableAmount!;
				receivableAmount += s.receivableAmount!;
			}

			SaleGoodsSkuBeforeReq last = goodsBefore.goodsSkuBeforeList[goodsBefore.goodsSkuBeforeList.length - 1];
			last.salePrice = goodsBefore.salePrice;
			last.taxSalePrice = goodsBefore.taxSalePrice;
			last.price = goodsBefore.price;
			last.taxPrice = goodsBefore.taxPrice;
			last.originalAmount = last.salePrice! * last.goodsNum!;
			last.taxOriginalAmount = (last.taxSalePrice ?? 0) * last.goodsNum!;

			last.taxReceivableAmount = goodsBefore.taxReceivableAmount! - receiptsAmount;
			last.receivableAmount = goodsBefore.receivableAmount! - receivableAmount;

			last.discountAmount = last.originalAmount! - last.receivableAmount!;
			last.taxAmount = last.taxReceivableAmount! - last.receivableAmount!;
		}
	}

	/**
	 * 校验数据
	 * @param saleGoodsReq 数据
	 */
	static void checkData(SaleGoodsBeforeReq saleGoodsBeforeReq) {
		if(saleGoodsBeforeReq.goodsNum! < 1){
			throw new Exception("销售商品数量最少为1");
		}
		int goodsNum = 0;
		for (SaleGoodsSkuBeforeReq saleGoodsSkuBeforeReq in saleGoodsBeforeReq.goodsSkuBeforeList) {
			goodsNum += saleGoodsSkuBeforeReq.goodsNum!;
		}
		if(saleGoodsBeforeReq.goodsNum != goodsNum){
			throw new Exception("商品数量与商品SUK数据不相等");
		}

		for (SaleGoodsSkuBeforeReq s in saleGoodsBeforeReq.goodsSkuBeforeList) {
			if(s.goodsNum! < 1){
				throw new Exception("销售商品数量最少为1");
			}
		}
	}
}
