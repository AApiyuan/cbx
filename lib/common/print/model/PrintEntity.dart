import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';

import '../enums/PrintAlignEnum.dart';
import '../enums/PrintTypeEnum.dart';
import 'Table.dart';

/// 模板打印翻译类
/// @author zhanyao
class PrintEntity {

	/// 打印文字打印居中方式 {@link PrintAlignEnum}
	PrintAlignEnum? align;

	/// 打印文字大小倍数
	int? fontSize;

	/// 是否加粗 true 加粗  false 不加粗
	bool? bold;

	/// 打印内容方式 {@link PrintTypeEnum}
	PrintTypeEnum? type;

	/// 打印内容 ,如果 type是 LINE 类型 那么：DASHED 虚线 DOTTED 实线 STAR 五角星型 EMPTY 空行
	String? body;

	/// 二维码 组
	List<String>? qrs;

	/// 不返回 忽略
	/// 标识打印行表格样式字段
	List<Table>? tables;

	/// 不返回 忽略
	/// 标识打印行是否统一表格样式
	String? id;

	static PrintEntity createPrintEntity1(PrintAlignEnum align, int fontSize, bool bold, PrintTypeEnum type, String body) {
		PrintEntity printEntity = new PrintEntity();
		printEntity.align = align;
		printEntity.fontSize = fontSize;
		printEntity.bold = bold;
		printEntity.type = type;
		printEntity.body = body;
		return printEntity;
	}

	static PrintEntity createPrintEntity2(PrintAlignEnum align, int fontSize, bool bold, PrintTypeEnum type, List<Table> tables, String id) {
		PrintEntity printEntity = new PrintEntity();
		printEntity.align = align;
		printEntity.fontSize = fontSize;
		printEntity.bold = bold;
		printEntity.type = type;
		printEntity.tables = tables;
		printEntity.id = id;
		return printEntity;
	}

	static PrintEntity createPrintEntity3(PrintAlignEnum align, int fontSize, bool bold, List<String> qrs) {
		PrintEntity printEntity = new PrintEntity();
		printEntity.align = align;
		printEntity.fontSize = fontSize;
		printEntity.bold = bold;
		printEntity.type = PrintTypeEnum.QRS;
		printEntity.qrs = qrs;
		return printEntity;
	}

	Map<String, dynamic> toJson() {
		var map = <String, dynamic>{};
		map['align'] = EnumCoverUtils.enumsToString(align);
		map['fontSize'] = fontSize;
		map['bold'] = bold;
		map['type'] = EnumCoverUtils.enumsToString(type);
		map['body'] = body;
		map['qrs'] = qrs;
		// map['tables'] = tables;
		// map['id'] = id;
		return map;
	}
}
