import 'ConfigImage.dart';

/// 基础打印数据
/// @author zhanyao
class BasePrintDo {

	/// 页脚
	List<String>? printFooterList;

	/// 图片
	List<ConfigImage>? printImageList;

	/// 打印人名称 或 分享人名称
	String printByName = "";

	/// 打印时间 或 分享时间
	DateTime printTime = DateTime.now();
}
