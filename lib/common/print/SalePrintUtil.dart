import 'package:haidai_flutter_module/common/sale/enums/SaleSubstandardEnum.dart';

import 'dto/BasePrintDo.dart';
import 'dto/ConfigImage.dart';
import 'dto/RemarkPrintDo.dart';
import 'dto/RemitDetail.dart';
import 'dto/RemitRecordMethod.dart';
import 'dto/SaleDetail.dart';
import 'dto/SaleGoodsDetail.dart';
import 'enums/PrintAlignEnum.dart';
import 'enums/PageWidthEnum.dart';
import 'enums/PrintTypeEnum.dart';
import 'model/PrintEntity.dart';
import 'dto/SalePrintDo.dart';
import 'model/Table.dart';
import 'util/ConvertUtil.dart';

/// 订单模块 销售单打印
/// @author zhanyao
/// @since 2020-08-10
class SalePrintUtil {

	static List<PrintEntity> build(SalePrintDo obj, PageWidthEnum pageWidth) {
		List<PrintEntity> printEntityList = <PrintEntity>[];
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 1, false, PrintTypeEnum.TEXT, "销售单-"+obj.printTypeName!));
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 4, true, PrintTypeEnum.TEXT, obj.deptName!));
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, " "));
		if(obj.customerPhone == null || obj.customerPhone!.length == 0){
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 3, true, PrintTypeEnum.TEXT, obj.customerName!));
		}else{
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 3, true, PrintTypeEnum.TEXT, obj.customerName!+"("+obj.customerPhone!+")"));
		}
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, "开单时间:"+ConvertUtil.convertLocalDateTime(obj.customizeTime)));
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, "跟单人:"+obj.merchandiserName!+"  "+obj.merchandiserPhone!));
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, true, PrintTypeEnum.LINE, "DOTTED"));
		if(obj.normalSale != null){
			SaleDetail saleDetail = obj.normalSale!;
			formatTable(printEntityList, saleDetail, "data-normalSale", 1);
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "销售:"+saleDetail.goodsNum.toString()+"件/￥"+ConvertUtil.convertAmount(saleDetail.goodsAmount)));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, " "));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, true, PrintTypeEnum.LINE, "DOTTED"));
		}
		if(obj.changeBackOrder != null){
			SaleDetail saleDetail = obj.changeBackOrder!;
			formatTable(printEntityList, saleDetail, "data-changeBackOrder", 1);
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "退欠货:"+saleDetail.goodsNum.toString()+"件/￥"+ConvertUtil.convertAmount(saleDetail.goodsAmount)));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, " "));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, true, PrintTypeEnum.LINE, "DOTTED"));
		}
		if(obj.returnGoods != null){
			SaleDetail saleDetail = obj.returnGoods!;
			formatTable(printEntityList, saleDetail, "data-returnGoods", 1);
			if(saleDetail.substandard == SaleSubstandardEnum.NO){
				printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "退正品:"+saleDetail.goodsNum.toString()+"件/￥"+ConvertUtil.convertAmount(saleDetail.goodsAmount)));
			}else{
				printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "退次品:"+saleDetail.goodsNum.toString()+"件/￥"+ConvertUtil.convertAmount(saleDetail.goodsAmount)));
			}
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, " "));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, true, PrintTypeEnum.LINE, "DOTTED"));
		}
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, " "));
		if(obj.remarkPrintDoList != null && obj.remarkPrintDoList!.length > 0){
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, "单据备注:"));
			for (RemarkPrintDo remarkPrintDo in obj.remarkPrintDoList!) {
				printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, remarkPrintDo.createdByName + ":" + remarkPrintDo.remark));
			}
		}
		if(obj.wipeOffAmount != 0){
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "[合计]金额:￥"+ConvertUtil.convertAmount(obj.taxReceivableAmount)));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 1, false, PrintTypeEnum.TEXT, "抹零金额:￥"+ConvertUtil.convertAmount(obj.wipeOffAmount)));
		}
		int result = obj.taxReceivableAmount! - obj.wipeOffAmount!;
		if(result >= 0){
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "本单应收:￥"+ConvertUtil.convertAmount(result)));
		}else {
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "本单应退:￥"+ConvertUtil.convertAmount(result * -1)));
		}
		//printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 1, false, PrintTypeEnum.TEXT, "本单已核销:￥"+ConvertUtil.convertAmount(obj.checkAmount)));
		//printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "本单结欠:￥"+ConvertUtil.convertAmount(obj.balanceAmount)));
		//printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 1, false, PrintTypeEnum.TEXT, "上次累计欠款:￥"+ConvertUtil.convertAmount(obj.customerOweAmount! - obj.balanceAmount!)));
		//printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "累计欠款:￥"+ConvertUtil.convertAmount(obj.customerOweAmount)));
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, " "));
		if(obj.remitDetail != null){
			RemitDetail remitDetail = obj.remitDetail!;
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.LINE, "DASHED"));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, " "));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "本次收款:￥"+ConvertUtil.convertAmount(remitDetail.remitAmount)));
			if(remitDetail.remitRecordMethodList != null && remitDetail.remitRecordMethodList!.length > 0) {
				for (RemitRecordMethod remitRecordMethod in remitDetail.remitRecordMethodList!) {
					printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 1, false, PrintTypeEnum.TEXT,remitRecordMethod.remitMethodName + ":收款￥" + ConvertUtil.convertAmount(remitRecordMethod.amount)));
				}
			}
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, " "));
		}
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, true, PrintTypeEnum.LINE, "DOTTED"));
		if(obj.basePrintDo != null){
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, " "));
			BasePrintDo basePrintDo = obj.basePrintDo!;
			if(basePrintDo.printFooterList != null && basePrintDo.printFooterList!.length > 0) {
				for (String printFooter in basePrintDo.printFooterList!) {
					printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, printFooter));
				}
			}
			if(basePrintDo.printImageList != null && basePrintDo.printImageList!.length > 0) {
				convertQrs(pageWidth, printEntityList, basePrintDo);
			}
			if(basePrintDo.printFooterList != null
					&& basePrintDo.printFooterList!.length > 0
					&& basePrintDo.printImageList != null
					&& basePrintDo.printImageList!.length > 0) {
				printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, " "));
				printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, true, PrintTypeEnum.LINE, "DOTTED"));
			}
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, " "));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, "打印人:"+basePrintDo.printByName));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, "打印时间:"+ConvertUtil.convertLocalDateTime(basePrintDo.printTime)));
		}
		return printEntityList;
	}

	/// 处理 QRS
	/// @param pageWidth 纸宽度
	/// @param printEntityList 数据
	static void convertQrs(PageWidthEnum pageWidth, List<PrintEntity> printEntityList, BasePrintDo basePrintDo) {
		if(pageWidth == PageWidthEnum.EIGHTY && basePrintDo.printImageList!.length > 2){
			List<String> qrs = <String>[];
			List<String> qrsTextList = <String>[];
			for (int i = 0 ; i < 2 ; i++){
				ConfigImage configImage = basePrintDo.printImageList![i];

				qrs.add(configImage.value);
				qrsTextList.add(configImage.text);
			}
			printEntityList.add(PrintEntity.createPrintEntity3(PrintAlignEnum.CENTER, 1, false, qrs));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, ConvertUtil.convertQrsText(qrsTextList)));

			List<String> qrs2 = <String>[];
			List<String> qrsTextList2 = <String>[];
			for (int i = 2; i < basePrintDo.printImageList!.length ; i++){
				ConfigImage configImage = basePrintDo.printImageList![i];

				qrs2.add(configImage.value);
				qrsTextList2.add(configImage.text);
			}
			printEntityList.add(PrintEntity.createPrintEntity3(PrintAlignEnum.CENTER, 1, false, qrs2));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, ConvertUtil.convertQrsText(qrsTextList2)));
		}else{
			List<String> qrs = <String>[];
			List<String> qrsTextList = <String>[];
			for (ConfigImage configImage in basePrintDo.printImageList!) {
				qrs.add(configImage.value);
				qrsTextList.add(configImage.text);
			}
			printEntityList.add(PrintEntity.createPrintEntity3(PrintAlignEnum.CENTER, 1, false, qrs));
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 1, false, PrintTypeEnum.TEXT, ConvertUtil.convertQrsText(qrsTextList)));
		}
	}

	static void formatTable(List<PrintEntity> printEntityList,SaleDetail saleDetail, String id, int modulus) {
		if(saleDetail.sizeNameList!.length < 7){
			List<Table> tables = <Table>[];
			tables.add(Table.createTable1(1, "货号"));
			tables.add(Table.createTable1(1, "颜色"));
			for (String sizeName in saleDetail.sizeNameList!) {
				tables.add(Table.createTable1(1, sizeName));
			}
			tables.add(Table.createTable2(true));
			tables.add(Table.createTable1(1, "数量"));
			tables.add(Table.createTable1(1, "单价"));
			tables.add(Table.createTable1(1, "金额"));

			printEntityList.add(PrintEntity.createPrintEntity2(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, tables, id));

			for (SaleGoodsDetail saleGoodsDetail in saleDetail.saleGoodsDetailList!) {
				if (saleGoodsDetail.goodsSerial != null) {
					printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.LINE, "DASHED"));
				}
				List<Table> tables2 = <Table>[];
				if (saleGoodsDetail.goodsSerial != null) {
					tables2.add(Table.createTable1(1, saleGoodsDetail.goodsSerial!));
				}else{
					tables2.add(Table.createTable1(1, ""));
				}
				tables2.add(Table.createTable1(1, saleGoodsDetail.colorName!));
				for (int sizeNum in saleGoodsDetail.sizeNumList!) {
					tables2.add(Table.createTable1(1, sizeNum != 0 ? (sizeNum * modulus).toString() : ""));
				}
				tables2.add(Table.createTable2(true));
				tables2.add(Table.createTable1(1, (saleGoodsDetail.goodsNum! * modulus).toString()));
				tables2.add(Table.createTable1(1, ConvertUtil.convertAmount(saleGoodsDetail.goodsPrice)));
				tables2.add(Table.createTable1(1, ConvertUtil.convertAmount(saleGoodsDetail.goodsAmount! * modulus)));

				printEntityList.add(PrintEntity.createPrintEntity2(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, tables2, id));
			}
		}else{
			for (SaleGoodsDetail saleGoodsDetail in saleDetail.saleGoodsDetailList!) {
				if (saleGoodsDetail.goodsSerial != null) {
					List<Table> tables = <Table>[];
					tables.add(Table.createTable1(1, "货号"));
					tables.add(Table.createTable1(1, "颜色"));
					for (String sizeName in saleGoodsDetail.goodsSizeNameList!) {
						tables.add(Table.createTable1(1, sizeName));
					}
					tables.add(Table.createTable2(true));
					tables.add(Table.createTable1(1, "数量"));
					tables.add(Table.createTable1(1, "单价"));
					tables.add(Table.createTable1(1, "金额"));

					printEntityList.add(PrintEntity.createPrintEntity2(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, tables, id + "_" + saleGoodsDetail.goodsId.toString()));

					printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.LINE, "DASHED"));
				}
				List<Table> tables2 = <Table>[];
				if (saleGoodsDetail.goodsSerial != null) {
					tables2.add(Table.createTable1(1, saleGoodsDetail.goodsSerial!));
				}else{
					tables2.add(Table.createTable1(1, ""));
				}
				tables2.add(Table.createTable1(1, saleGoodsDetail.colorName!));
				for (int sizeNum in saleGoodsDetail.goodsSizeNumList!) {
					tables2.add(Table.createTable1(1, sizeNum != 0 ? (sizeNum * modulus).toString() : ""));
				}
				tables2.add(Table.createTable2(true));
				tables2.add(Table.createTable1(1, (saleGoodsDetail.goodsNum! * modulus).toString()));
				tables2.add(Table.createTable1(1, ConvertUtil.convertAmount(saleGoodsDetail.goodsPrice)));
				tables2.add(Table.createTable1(1, ConvertUtil.convertAmount(saleGoodsDetail.goodsAmount! * modulus)));

				printEntityList.add(PrintEntity.createPrintEntity2(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, tables2, id+"_"+saleGoodsDetail.goodsId.toString()));
			}
		}
	}
}
