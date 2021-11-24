import 'package:haidai_flutter_module/model/enum/remit_type.dart';

import 'RemitPrintUtil.dart';
import 'SalePrintUtil.dart';
import 'dto/SalePrintDo.dart';
import 'dto/SaleDetail.dart';
import 'dto/SaleGoodsDetail.dart';
import 'dto/RemitRecordMethod.dart';
import 'dto/ConfigImage.dart';
import 'dto/BasePrintDo.dart';
import 'dto/RemitDetail.dart';
import 'dto/RemitPrintDo.dart';
import 'enums/PageWidthEnum.dart';
import 'model/PrintEntity.dart';
import 'util/PrintUtils.dart';

void main() {
  SalePrintDo salePrintDo = new SalePrintDo();
  salePrintDo.printTypeName = "客户联";
  salePrintDo.deptId = 6;
  salePrintDo.deptName = "这里是发哥";
  salePrintDo.orderSerialNo = "2";
  salePrintDo.customerName = "零售";
  salePrintDo.customerPhone = "";
  salePrintDo.customizeTime = DateTime.now();
  salePrintDo.merchandiserId = 1000;
  salePrintDo.merchandiserName = "兔兔的午后";

  SaleDetail normalSale = new SaleDetail();
  normalSale.goodsStyleNum= 1;
  normalSale.goodsNum = 2;
  normalSale.goodsAmount = 20000;
  normalSale.sizeNameList = <String>["M", "L"];

  List<SaleGoodsDetail> saleGoodsDetailList = <SaleGoodsDetail>[];
  SaleGoodsDetail saleGoodsDetail = new SaleGoodsDetail();
  saleGoodsDetail.goodsId = 5;
  saleGoodsDetail.goodsSerial = "001";
  saleGoodsDetail.colorName = "红色";
  saleGoodsDetail.sizeNumList = <int>[1, 1];
  saleGoodsDetailList.add(saleGoodsDetail);
  normalSale.saleGoodsDetailList = saleGoodsDetailList;

  saleGoodsDetail.goodsNum = 4;
  saleGoodsDetail.goodsPrice = 10000;
  saleGoodsDetail.goodsAmount = 20000;
  saleGoodsDetail.goodsSizeNameList = <String>["M", "L"];
  saleGoodsDetail.goodsSizeNumList = <int>[1, 1];

  salePrintDo.normalSale = normalSale;

  salePrintDo.taxReceivableAmount = 20000;
  salePrintDo.balanceAmount = 0;
  salePrintDo.checkAmount = 20000;
  salePrintDo.wipeOffAmount = 0;
  salePrintDo.customerOweAmount = 1437615287;

  RemitDetail remitDetail = new RemitDetail();
  remitDetail.orderSerialNo = "2";
  remitDetail.remitAmount = 200000;

  List<RemitRecordMethod> remitRecordMethodList = <RemitRecordMethod>[];
  RemitRecordMethod remitRecordMethod = new RemitRecordMethod();
  remitRecordMethod.remitMethodName = "微信";
  remitRecordMethod.amount = 200000;
  remitRecordMethodList.add(remitRecordMethod);
  remitDetail.remitRecordMethodList = remitRecordMethodList;

  salePrintDo.remitDetail = remitDetail;

  BasePrintDo basePrintDo = new BasePrintDo();
  basePrintDo.printFooterList = <String>["测试1", "测试2"];

  List<ConfigImage> printImageList = <ConfigImage>[];
  ConfigImage configImage1 = new ConfigImage();
  configImage1.text = "测试";
  configImage1.value = "wxp://f2f0BFGG-EoFdq-Gv5lQLL3hwd_4bwcp1Dm2";
  ConfigImage configImage2 = new ConfigImage();
  configImage2.text = "测试2";
  configImage2.value = "http://weixin.qq.com/r/Uxw8JJ7E9sOJrdpH90lB";
  ConfigImage configImage3 = new ConfigImage();
  configImage3.text = "哈哈哈哈见见你扭扭捏捏";
  configImage3.value = "https://u.wechat.com/EIlu7PRZ99v_cN63Z31bLJE";

  printImageList.add(configImage1);
  printImageList.add(configImage2);
  printImageList.add(configImage3);

  basePrintDo.printImageList = printImageList;

  basePrintDo.printByName = "兔兔的午后";
  basePrintDo.printTime = DateTime.now();

  salePrintDo.basePrintDo = basePrintDo;

  List<PrintEntity> salePrintEntityList = SalePrintUtil.build(salePrintDo,PageWidthEnum.ONE_HUNDRED_AND_TEN);
  PrintUtils.merge(PageWidthEnum.ONE_HUNDRED_AND_TEN,salePrintEntityList);
  print("salePrintEntityList:"+salePrintEntityList.length.toString());


  RemitPrintDo remitPrintDo = new RemitPrintDo();

  remitPrintDo.type = RemitTypeEnum.PAYMENT;
  remitPrintDo.printTypeName = "客户联";
  remitPrintDo.deptId = 6;
  remitPrintDo.deptName = "这里是发哥";
  remitPrintDo.orderSerialNo = "2";
  remitPrintDo.customerName = "零售";
  remitPrintDo.customizeTime = DateTime.now();
  remitPrintDo.merchandiserId = 1000;
  remitPrintDo.merchandiserName = "兔兔的午后";
  remitPrintDo.remitAmount = 200000;
  remitPrintDo.customerOweAmount = 1437615287;

  List<RemitRecordMethod> remitRecordMethodList2 = <RemitRecordMethod>[];
  RemitRecordMethod remitRecordMethod2 = new RemitRecordMethod();
  remitRecordMethod2.remitMethodName = "微信";
  remitRecordMethod2.amount = 200000;
  remitRecordMethodList2.add(remitRecordMethod2);
  remitPrintDo.remitRecordMethodList = remitRecordMethodList2;

  BasePrintDo basePrintDo2 = new BasePrintDo();
  basePrintDo2.printFooterList = <String>["测试1", "测试2"];

  List<ConfigImage> printImageList2 = <ConfigImage>[];
  ConfigImage configImage4 = new ConfigImage();
  configImage4.text = "测试";
  configImage4.value = "wxp://f2f0BFGG-EoFdq-Gv5lQLL3hwd_4bwcp1Dm2";
  ConfigImage configImage5 = new ConfigImage();
  configImage5.text = "测试2";
  configImage5.value = "http://weixin.qq.com/r/Uxw8JJ7E9sOJrdpH90lB";
  ConfigImage configImage6 = new ConfigImage();
  configImage6.text = "哈哈哈哈见见你扭扭捏捏";
  configImage6.value = "https://u.wechat.com/EIlu7PRZ99v_cN63Z31bLJE";

  printImageList2.add(configImage4);
  printImageList2.add(configImage5);
  printImageList2.add(configImage6);

  basePrintDo2.printImageList = printImageList2;

  basePrintDo2.printByName = "兔兔的午后";
  basePrintDo2.printTime = DateTime.now();

  remitPrintDo.basePrintDo = basePrintDo2;

  List<PrintEntity> remitPrintEntityList = RemitPrintUtil.build(remitPrintDo,PageWidthEnum.ONE_HUNDRED_AND_TEN);
  PrintUtils.merge(PageWidthEnum.ONE_HUNDRED_AND_TEN,remitPrintEntityList);
  print("remitPrintEntityList:"+remitPrintEntityList.length.toString());
}
