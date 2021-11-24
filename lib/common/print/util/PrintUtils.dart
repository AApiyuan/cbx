import 'dart:collection';
import 'dart:convert';

import "package:collection/collection.dart";
import 'package:haidai_flutter_module/common/print/dto/BasePrintDo.dart';
import 'package:haidai_flutter_module/common/print/dto/ConfigImage.dart';
import 'package:haidai_flutter_module/common/print/dto/RemarkPrintDo.dart';
import 'package:haidai_flutter_module/common/print/dto/RemitDetail.dart';
import 'package:haidai_flutter_module/common/print/dto/RemitPrintDo.dart';
import 'package:haidai_flutter_module/common/print/dto/RemitRecordMethod.dart';
import 'package:haidai_flutter_module/common/print/dto/SaleDetail.dart';
import 'package:haidai_flutter_module/common/print/dto/SaleGoodsDetail.dart';
import 'package:haidai_flutter_module/common/print/dto/SalePrintDo.dart';
import 'package:haidai_flutter_module/common/sale/dto/SaleGoodsReq.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/DateUtils.dart';
import 'package:haidai_flutter_module/model/enum/remit_type.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_config_do.dart';
import 'package:haidai_flutter_module/page/sale/model/hang_order_model.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';

import '../RemitPrintUtil.dart';
import '../SalePrintUtil.dart';
import '../enums/PageWidthEnum.dart';
import '../model/PrintEntity.dart';
import '../model/Table.dart';

/// 模板引擎操作类
/// @author zhanyao
class PrintUtils {

	/// 查询打印数据
	/// @param pageWidth 纸张宽度
	/// @param param 查询入参
	/// @param list 店铺配置
	/// @param printName 打印人名称
	/// @param printPhone 打印人手机号码
	/// @param printTypeName 打印联类型
	/// @return 结果
	static List<PrintEntity> process(PageWidthEnum pageWidth, HangOrderModel param,List<CustomerDeptConfigDo> customerDeptConfigDoList, String printName,String printPhone,String printTypeName, String deptName) {
		//销售单和离线开单
		if(param.type == 0 || param.type == 2){
			SalePrintDo salePrintDo = new SalePrintDo();
			salePrintDo.printTypeName = printTypeName;
			salePrintDo.deptId = param.deptId;
			salePrintDo.deptName = deptName;
			salePrintDo.orderSerialNo = "--";
			salePrintDo.customerName = param.customer!.customerName;
			salePrintDo.customerPhone = param.customer!.customerPhone;
			salePrintDo.customizeTime = DateUtils.string2Date(param.updateTime);
			salePrintDo.merchandiserName = printName;
			salePrintDo.merchandiserPhone = printPhone;

			if(param.saleGoodsList != null && param.saleGoodsList!.isNotEmpty){
				SaleDetail normalSale = new SaleDetail();
				Map<int, List<SkuInfoEntity>> goodsSkuMap = new Map();

				for(SaleDetailDoSaleGoodsList goodsDetail in param.saleGoodsList!) {
					List<SkuInfoEntity> skuInfoEntityList = <SkuInfoEntity>[];
					for(var sku in param.saleGoodsSku![goodsDetail.goodsId!]!) {
						SkuInfoEntity skuInfoEntity = SkuInfoEntity().fromJson(sku);
						skuInfoEntityList.add(skuInfoEntity);
					}
					goodsSkuMap.putIfAbsent(goodsDetail.goodsId!, () => skuInfoEntityList);
				}

				//设置数据
				var saleGoods = <SaleGoodsReq>[];
				param.saleReq?.goodsList.forEach((element) {
					if (element.type == SaleTypeEnum.NORMAL_SALE) {
						saleGoods.add(element);
					}
				});
				formatGoods(saleGoods, param.saleGoodsList!, goodsSkuMap, normalSale);
				salePrintDo.normalSale = normalSale;
			}

			if(param.oweGoodsList != null && param.oweGoodsList!.isNotEmpty){
				SaleDetail changeBackOrder = new SaleDetail();
				Map<int, List<SkuInfoEntity>> goodsSkuMap = new Map();

				for(SaleDetailDoSaleGoodsList goodsDetail in param.oweGoodsList!) {
					List<SkuInfoEntity> skuInfoEntityList = <SkuInfoEntity>[];
					for(var sku in param.oweGoodsSku![goodsDetail.id!]!) {
						SkuInfoEntity skuInfoEntity = SkuInfoEntity().fromJson(sku);
						skuInfoEntityList.add(skuInfoEntity);
					}
					goodsSkuMap.putIfAbsent(goodsDetail.id!, () => skuInfoEntityList);
				}

				//设置数据
				var oweGoods = <SaleGoodsReq>[];
				param.saleReq?.goodsList.forEach((element) {
					if (element.type == SaleTypeEnum.CHANGE_BACK_ORDER) {
						oweGoods.add(element);
					}
				});
				formatGoods(oweGoods, param.oweGoodsList!, goodsSkuMap, changeBackOrder);
				salePrintDo.changeBackOrder = changeBackOrder;
			}

			if(param.returnGoodsList != null && param.returnGoodsList!.isNotEmpty){
				SaleDetail returnGoods = new SaleDetail();
				returnGoods.substandard = param.saleReq!.substandard;
				Map<int, List<SkuInfoEntity>> goodsSkuMap = new Map();

				for(SaleDetailDoSaleGoodsList goodsDetail in param.returnGoodsList!) {
					List<SkuInfoEntity> skuInfoEntityList = <SkuInfoEntity>[];
					for(var sku in param.returnGoodsSku![goodsDetail.goodsId!]!) {
						SkuInfoEntity skuInfoEntity = SkuInfoEntity().fromJson(sku);
						skuInfoEntityList.add(skuInfoEntity);
					}
					goodsSkuMap.putIfAbsent(goodsDetail.goodsId!, () => skuInfoEntityList);
				}

				//设置数据
				var goods = <SaleGoodsReq>[];
				param.saleReq?.goodsList.forEach((element) {
					if (element.type == SaleTypeEnum.RETURN_GOODS) {
						goods.add(element);
					}
				});
				formatGoods(goods, param.returnGoodsList!, goodsSkuMap, returnGoods);
				salePrintDo.returnGoods = returnGoods;
			}

			salePrintDo.taxReceivableAmount = param.saleReq!.taxReceivableAmount!;
			salePrintDo.balanceAmount = param.saleReq!.balanceAmount!;
			salePrintDo.checkAmount = 0;
			salePrintDo.wipeOffAmount = param.saleReq!.wipeOffAmount!;
			salePrintDo.customerOweAmount = param.customer!.oweAmount;

			if(param.saleReq!.remark != null){
				List<RemarkPrintDo>? remarkPrintDoList = <RemarkPrintDo>[];
				RemarkPrintDo remarkPrintDo = new RemarkPrintDo();
				remarkPrintDo.remark = param.saleReq!.remark!;
				remarkPrintDo.createdTime = DateTime.now();
				remarkPrintDo.createdByName = printName;
				remarkPrintDoList.add(remarkPrintDo);

				salePrintDo.remarkPrintDoList = remarkPrintDoList;
			}

			RemitDetail remitDetail = new RemitDetail();
			remitDetail.orderSerialNo = "--";
			remitDetail.remitAmount = 0;

			List<RemitRecordMethod> remitRecordMethodList = <RemitRecordMethod>[];
			List<int> keys = param.remitAmountMap!.keys.toList();
			for(int i=0;i<keys.length;i++){
				int key = keys[i];
				double value = param.remitAmountMap![key]!;

				RemitRecordMethod remitRecordMethod = new RemitRecordMethod();
				remitRecordMethod.remitMethodName = param.remitMethodMap![key]!.remitMethodName!;
				remitRecordMethod.amount = (value * 100).toInt();
				remitRecordMethodList.add(remitRecordMethod);

				remitDetail.remitAmount = remitDetail.remitAmount! + remitRecordMethod.amount!;
			}
			remitDetail.remitRecordMethodList = remitRecordMethodList;
			if(remitDetail.remitAmount != 0){
				salePrintDo.remitDetail = remitDetail;
			}

			BasePrintDo basePrintDo = new BasePrintDo();
			if(customerDeptConfigDoList.isNotEmpty){
				formatBasePrint(customerDeptConfigDoList, basePrintDo);
			}
			basePrintDo.printByName = printName;
			basePrintDo.printTime = DateTime.now();

			salePrintDo.basePrintDo = basePrintDo;

			List<PrintEntity> printEntityList = SalePrintUtil.build(salePrintDo,pageWidth);
			return merge(pageWidth, printEntityList);
		}
		//离线收款
		if(param.type == 4){
			RemitPrintDo remitPrintDo = new RemitPrintDo();
			remitPrintDo.type = RemitTypeEnum.PAYMENT;
			remitPrintDo.printTypeName = printTypeName;
			remitPrintDo.deptId = param.deptId;
			remitPrintDo.deptName = deptName;
			remitPrintDo.orderSerialNo = "--";
			remitPrintDo.customerName = param.customer!.customerName;
			remitPrintDo.customizeTime = DateUtils.string2Date(param.updateTime);
			remitPrintDo.merchandiserName = printName;
			remitPrintDo.remitAmount = 0;
			remitPrintDo.customerOweAmount = param.customer!.oweAmount;

			List<RemitRecordMethod> remitRecordMethodList = <RemitRecordMethod>[];
			List<int> keys = param.remitAmountMap!.keys.toList();
			for(int i=0;i<keys.length;i++){
				int key = keys[i];
				double value = param.remitAmountMap![key]!;

				RemitRecordMethod remitRecordMethod = new RemitRecordMethod();
				remitRecordMethod.remitMethodName = param.remitMethodMap![key]!.remitMethodName!;
				remitRecordMethod.amount = (value * 100).toInt();
				remitRecordMethodList.add(remitRecordMethod);

				remitPrintDo.remitAmount = remitPrintDo.remitAmount! + remitRecordMethod.amount!;
			}
			remitPrintDo.remitRecordMethodList = remitRecordMethodList;

			BasePrintDo basePrintDo = new BasePrintDo();
			if(customerDeptConfigDoList.isNotEmpty){
				formatBasePrint(customerDeptConfigDoList, basePrintDo);
			}
			basePrintDo.printByName = printName;
			basePrintDo.printTime = DateTime.now();

			remitPrintDo.basePrintDo = basePrintDo;

			List<PrintEntity> printEntityList =  RemitPrintUtil.build(remitPrintDo,pageWidth);
			return merge(pageWidth, printEntityList);
		}
		return <PrintEntity>[];
	}

	/// 格式化打印配置数据
	/// @param customerDeptConfigDoList 店铺配置
	/// @param basePrintDo 打印数据
	static void formatBasePrint(List<CustomerDeptConfigDo> customerDeptConfigDoList, BasePrintDo basePrintDo) {
	  List<String> imageConfigTypeList = <String>["CONFIG_PRINT_IMG_1","CONFIG_PRINT_IMG_2","CONFIG_PRINT_IMG_3","CONFIG_PRINT_IMG_4"];

	  List<String> printFooterList = <String>[];
	  List<ConfigImage> printImageList = <ConfigImage>[];

	  for(int i = 0 ; i < customerDeptConfigDoList.length ; i++){
	  	CustomerDeptConfigDo customerDeptConfig = customerDeptConfigDoList[i];
	  	if (customerDeptConfig.configDate != null && customerDeptConfig.configDate != "null") {
	  		if (imageConfigTypeList.contains(customerDeptConfig.type)) {
	  			Map<String, dynamic> objectNode = jsonDecode(customerDeptConfig.configDate!);
	  			if(objectNode["TEXT"] != null && objectNode["VALUE"] != null){
	  				ConfigImage configImage = new ConfigImage();
	  				configImage.text = objectNode["TEXT"]!.toString();
	  				configImage.value = objectNode["VALUE"]!.toString();
	  				printImageList.add(configImage);
	  			}
	  		} else {
	  			if(customerDeptConfig.configDate != null && customerDeptConfig.configDate != "null"){
						List<dynamic> arrayNode = jsonDecode(customerDeptConfig.configDate!);
						for (dynamic jsonNode in arrayNode) {
							printFooterList.add(jsonNode.toString());
						}
					}

	  		}
	  	}
	  }

	  basePrintDo.printImageList = printImageList;
	  basePrintDo.printFooterList = printFooterList;
	}

	/// 格式化打印数据
	/// @param goodsList goods数据
	/// @param goodsSkuMap sku数据
	/// @param saleDetail 返回数据
	static void formatGoods(List<SaleGoodsReq> goodsList,List<SaleDetailDoSaleGoodsList> goodsBase,Map<int, List<SkuInfoEntity>> goodsSkuMap,SaleDetail saleDetail) {
		Set<int> goodsIds = Set<int>();

		saleDetail.goodsNum = 0;
		saleDetail.goodsAmount = 0;
		for (SaleGoodsReq saleGoods in goodsList) {
			saleDetail.goodsNum = saleDetail.goodsNum! + saleGoods.goodsNum!;
			saleDetail.goodsAmount = saleDetail.goodsAmount! + saleGoods.taxReceivableAmount!;
			goodsIds.add(saleGoods.goodsId!);
		}
		saleDetail.goodsStyleNum= goodsIds.length;

		Set<SkuInfoSizesGoodsSize> goodsSizeSet = Set<SkuInfoSizesGoodsSize>();
		List<int> goodsSkuMapKeys = goodsSkuMap.keys.toList();
		for(int i=0;i<goodsSkuMapKeys.length;i++){
			int key = goodsSkuMapKeys[i];
			List<SkuInfoEntity> skuInfoEntityList = goodsSkuMap[key]!;

			for(SkuInfoEntity skuInfoEntity in skuInfoEntityList) {
				for(int i = 0 ; i < skuInfoEntity.sizes!.length ; i++){
					SkuInfoSize skuInfoSize = skuInfoEntity.sizes![i];
					if((skuInfoSize.data!.num ?? 0) > 0 && goodsSizeSet.singleWhereOrNull((element) => element.id == skuInfoSize.goodsSize?.id) == null){
						goodsSizeSet.add(skuInfoSize.goodsSize!);
					}
				}
				// skuInfoEntityList.add(skuInfoEntity);
			}
		}

		List<String>? sizeNameList = <String>[];

		Map<int, List<SkuInfoSizesGoodsSize>> goodsSizeMap = groupBy(goodsSizeSet, (goodsSize) => goodsSize.styleGroupId!);
		List<int> goodsSizeMapKeys = goodsSizeMap.keys.toList();
		goodsSizeMapKeys.sort((d1, d2) => d2.compareTo(d1));
		for(int i=0;i<goodsSizeMapKeys.length;i++) {
			int key = goodsSizeMapKeys[i];
			List<SkuInfoSizesGoodsSize> goodsSizeList = goodsSizeMap[key]!;
			goodsSizeList.sort((d1, d2) => d2.sort!.compareTo(d1.sort!));
			for(int j=0;j<goodsSizeList.length;j++) {
				SkuInfoSizesGoodsSize size = goodsSizeList[j];
				sizeNameList.add(size.name!);
			}
		}
		//尺码名称处理
		saleDetail.sizeNameList =sizeNameList;

		//商品尺码名称处理
		List<SaleGoodsDetail> saleGoodsDetailList = <SaleGoodsDetail>[];

		for (SaleGoodsReq saleGoods in goodsList) {
			List<SkuInfoEntity> saleGoodsSkuList;
			if(saleGoods.type == SaleTypeEnum.CHANGE_BACK_ORDER){
				saleGoodsSkuList = goodsSkuMap[saleGoods.relationOrderSaleGoodsId!]!;
			}else{
				saleGoodsSkuList = goodsSkuMap[saleGoods.goodsId!]!;
			}

			Map<int, SkuInfoSizesData> goodsSkuMap2 = new Map();
			Map<String, int> skuIdMap = new Map();
			Set<SkuInfoGoodsColor> goodsColorSet = Set<SkuInfoGoodsColor>();
			Set<SkuInfoSizesGoodsSize> goodsSizeSet = Set<SkuInfoSizesGoodsSize>();

			for(SkuInfoEntity skuInfoEntity in saleGoodsSkuList) {
				int num = 0;
				for(SkuInfoSize skuInfoSize in skuInfoEntity.sizes!){
					goodsSkuMap2.putIfAbsent(skuInfoSize.data!.skuId!, () => skuInfoSize.data!);

					goodsSizeSet.add(skuInfoSize.goodsSize!);
					num += skuInfoSize.data?.num ?? 0;

					skuIdMap.putIfAbsent(skuInfoEntity.goodsColor!.id!.toString() + "_" + skuInfoSize.goodsSize!.name!,() => skuInfoSize.data!.skuId!);
				}
				if (num > 0)
					goodsColorSet.add(skuInfoEntity.goodsColor!);
			}

			List<SkuInfoGoodsColor> goodsColorList = <SkuInfoGoodsColor>[];
			for(SkuInfoGoodsColor goodsColor in goodsColorSet) {
				goodsColorList.add(goodsColor);
			}
			// 按sort排序
			goodsColorList.sort((d1, d2) => d2.sort!.compareTo(d1.sort!));

			List<SkuInfoSizesGoodsSize> goodsSizeList = <SkuInfoSizesGoodsSize>[];
			for(SkuInfoSizesGoodsSize goodsSize in goodsSizeSet) {
				goodsSizeList.add(goodsSize);
			}
			goodsSizeList.sort((d1, d2) => d2.sort!.compareTo(d1.sort!));
			List<String> goodsSizeNameList = <String>[];
			for(SkuInfoSizesGoodsSize goodsSize in goodsSizeList) {
				goodsSizeNameList.add(goodsSize.name!);
			}

			for (int i = 0; i < goodsColorList.length; i++) {
				SkuInfoGoodsColor goodsColor = goodsColorList[i];
				SaleGoodsDetail goodsDetail = new SaleGoodsDetail();
				goodsDetail.goodsId = saleGoods.goodsId!;
				if (i == 0) {
					var base = goodsBase.firstWhere((element) => element.goodsId == goodsDetail.goodsId);
					goodsDetail.goodsSerial = base.storeGoods?.goodsSerial!;
					//尺码名称处理
					goodsDetail.goodsSizeNameList = goodsSizeNameList;
				}
				goodsDetail.colorName = goodsColor.name;

				List<int> sizeNumList = <int>[];
				goodsDetail.goodsNum = 0;

				for (String sizeName in saleDetail.sizeNameList!) {
					int? skuId = skuIdMap[goodsColor.id.toString() + "_" + sizeName];
					if (skuId == null) {
						sizeNumList.add(0);
					} else {
						SkuInfoSizesData? saleGoodsSku = goodsSkuMap2[skuId];
						if(saleGoodsSku != null){
							sizeNumList.add(saleGoodsSku.num!);
							goodsDetail.goodsNum = goodsDetail.goodsNum! + saleGoodsSku.num!;
						}else{
							sizeNumList.add(0);
						}
					}
				}
				goodsDetail.goodsPrice = saleGoods.taxPrice;
				goodsDetail.goodsAmount = goodsDetail.goodsNum! * goodsDetail.goodsPrice!;
				goodsDetail.sizeNumList = sizeNumList;

				List<int> goodsSizeNumList = <int>[];
				for (String sizeName in goodsSizeNameList) {
					int? skuId = skuIdMap[goodsColor.id!.toString() + "_" + sizeName];
					if (skuId == null) {
						goodsSizeNumList.add(0);
					} else {
						SkuInfoSizesData? saleGoodsSku = goodsSkuMap2[skuId];
						if(saleGoodsSku != null){
							goodsSizeNumList.add(saleGoodsSku.num!);
							// goodsDetail.goodsNum = goodsDetail.goodsNum! + saleGoodsSku.num!;
						}else{
							goodsSizeNumList.add(0);
						}
					}
				}
				goodsDetail.goodsSizeNumList = goodsSizeNumList;
				saleGoodsDetailList.add(goodsDetail);
			}
		}

		saleDetail.saleGoodsDetailList = saleGoodsDetailList;
	}

	/// 处理合并表格数据
	/// @param pageWidth 纸张宽度
	/// @param printEntityList 打印数据
	static List<PrintEntity> merge(PageWidthEnum pageWidth, List<PrintEntity> printEntityList) {
		//处理表格数据
		Map<String,List<PrintEntity>> map = new HashMap();
		for(int i = 0 ; i < printEntityList.length ; i++){
			PrintEntity printEntity = printEntityList[i];
			if(printEntity.id == null){
				continue;
			}
			List<PrintEntity> tmp;
			if(map.containsKey(printEntity.id)){
				tmp = map[printEntity.id!]!;
			}else{
				tmp = <PrintEntity>[];
			}
			tmp.add(printEntity);
			map.putIfAbsent(printEntity.id!, () => tmp);
		}
		List<String> keys = map.keys.toList();
		for(int i=0;i<keys.length;i++){
			String k = keys[i];
			List<PrintEntity> v = map[k]!;

			int td  = v[0].tables!.length;
		  int maxWidthSum = 0;
		  List<int> maxWidth = <int>[td];
			for (int i = 0 ; i < td ; i++){
				maxWidth.add(getBodyWidth(v[0].tables![i].body));
				for (PrintEntity f in v) {
					if(maxWidth[i] < getBodyWidth(f.tables![i].body)){
						maxWidth[i] = getBodyWidth(f.tables![i].body);
					}
				}
				maxWidthSum += maxWidth[i];
			}
			for (PrintEntity f in v) {
				String builder = "";
				for (int j = 0 ; j < f.tables!.length ; j++){
					Table table = f.tables![j];
					if(table.placeholder!){
						if(pageWidth == PageWidthEnum.ONE_HUNDRED_AND_TEN){
							for(int i = 0; i < 65 - maxWidthSum - maxWidth.length; i++) {
								builder += " ";
							}
						}else if(pageWidth == PageWidthEnum.EIGHTY){
							for(int i = 0; i < 47  - maxWidthSum - maxWidth.length; i++) {
								builder += " ";
							}
						}
					}else{
						builder += table.body!;
						if(j != f.tables!.length - 1){
							for(int i = 0; i < maxWidth[j] - getBodyWidth(table.body); i++) {
								builder += " ";
							}
							if(pageWidth == PageWidthEnum.EIGHTY){
								builder += " ";
							}else if(pageWidth == PageWidthEnum.ONE_HUNDRED_AND_TEN){
								builder += " ";
							}else if(pageWidth == PageWidthEnum.TWO_HUNDRED_AND_TEN){
								builder += " ";
								builder += " ";
							}
						}
					}
				}
				f.body = builder;
			}
		}
		return printEntityList;
	}

	/// 获取内容长度
	/// @return 结果
	static int getBodyWidth(String? body) {
		int result = 0;
		if(body == null){
			body = "";
		}
		RegExp chinese = new RegExp("[^\x00-\xff]");
		for(int i = 0 ; i < body.length ; i++){
			String cha = body[i];
			// 是否中文
			if(chinese.hasMatch(cha)){
				result += 2;
			}else{
				result += 1;
			}
		}
		return result;
	}
}
