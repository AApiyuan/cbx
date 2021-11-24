import 'BasePrintDo.dart';
import 'RemarkPrintDo.dart';
import 'RemitRecordMethod.dart';

/// 收退款单打印
/// @author zhanyao
class RemitPrintDo {

	/// 类型 0:收款，1：退款，2核销 3 杂项收入，4杂项支出 {@link RemitTypeEnum}
	String? type;

	/// 打印联类型
	String? printTypeName;

	/// 店铺ID
	int? deptId;

	/// 店铺ID
	String? deptName;

	/// 单据号码序号
	String? orderSerialNo;

	/// 用户名称
	String? customerName;

	/// 单据自定义时间
	DateTime? customizeTime;

	/// 跟单人ID
	int? merchandiserId;

	/// 跟单人名称
	String? merchandiserName;

	/// 收退款金额
	int? remitAmount;

	/// 收退款方式详情
	List<RemitRecordMethod>? remitRecordMethodList;

	/// 单据备注
	List<RemarkPrintDo>? remarkPrintDoList;

	/// 客户总欠款
	int? customerOweAmount;

	/// 基础打印数据
	BasePrintDo? basePrintDo;
}
