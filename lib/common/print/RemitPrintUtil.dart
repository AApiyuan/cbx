import 'package:haidai_flutter_module/model/enum/remit_type.dart';

import 'dto/BasePrintDo.dart';
import 'dto/ConfigImage.dart';
import 'dto/RemarkPrintDo.dart';
import 'dto/RemitPrintDo.dart';
import 'dto/RemitRecordMethod.dart';
import 'enums/PrintAlignEnum.dart';
import 'enums/PageWidthEnum.dart';
import 'enums/PrintTypeEnum.dart';
import 'model/PrintEntity.dart';
import 'util/ConvertUtil.dart';

/// 默认收退款单打印
/// @author zhanyao
/// @since 2020-08-10
class RemitPrintUtil {

	static List<PrintEntity> build(RemitPrintDo obj, PageWidthEnum pageWidth) {
		List<PrintEntity> printEntityList = <PrintEntity>[];
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 1, false, PrintTypeEnum.TEXT, RemitTypeEnum.getDesc(obj.type!)+"单-"+obj.printTypeName!));
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.CENTER, 3, true, PrintTypeEnum.TEXT, obj.deptName!));
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 3, true, PrintTypeEnum.TEXT, obj.customerName!));
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, "开单时间:"+ConvertUtil.convertLocalDateTime(obj.customizeTime)));
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, "跟单人:"+obj.merchandiserName!));
		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, true, PrintTypeEnum.LINE, "DOTTED"));
//		if(obj.type.toString() == RemitTypeEnum.PAYMENT){
//			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 1, false, PrintTypeEnum.TEXT, "上次累计欠款:￥"+ConvertUtil.convertAmount((obj.customerOweAmount ?? 0) + obj.remitAmount!)));
//		}
		if(obj.type.toString() == RemitTypeEnum.PAYMENT){
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "本次收款"+"：￥"+ConvertUtil.convertAmount(obj.remitAmount)));
		}else if(obj.type.toString() == RemitTypeEnum.REFUND){
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "本次实退"+"：￥"+ConvertUtil.convertAmount(obj.remitAmount)));
		}else{
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "本次"+RemitTypeEnum.getDesc(obj.type!)+"：￥"+ConvertUtil.convertAmount(obj.remitAmount)));
		}
		for (RemitRecordMethod remitRecordMethod in obj.remitRecordMethodList!) {
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 1, false, PrintTypeEnum.TEXT, remitRecordMethod.remitMethodName+":"+RemitTypeEnum.getDesc(obj.type!)+"￥"+ConvertUtil.convertAmount(remitRecordMethod.amount)));
		}
//		if(obj.type.toString() == RemitTypeEnum.PAYMENT){
//			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.RIGHT, 3, true, PrintTypeEnum.TEXT, "当前累计欠款:￥"+ConvertUtil.convertAmount(obj.customerOweAmount)));
//		}
		if(obj.remarkPrintDoList != null && obj.remarkPrintDoList!.length > 0){
			printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, "单据备注:"));
			for (RemarkPrintDo remarkPrintDo in obj.remarkPrintDoList!) {
				printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, false, PrintTypeEnum.TEXT, remarkPrintDo.createdByName +":"+remarkPrintDo.remark));
			}
		}

		printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, true, PrintTypeEnum.LINE, "DOTTED"));
		if(obj.basePrintDo != null){
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
				printEntityList.add(PrintEntity.createPrintEntity1(PrintAlignEnum.LEFT, 1, true, PrintTypeEnum.LINE, "DOTTED"));
			}
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
}