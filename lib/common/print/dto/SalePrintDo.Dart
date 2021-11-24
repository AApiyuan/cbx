import 'SaleDetail.dart';
import 'BasePrintDo.dart';
import 'RemarkPrintDo.dart';
import 'RemitDetail.dart';

/**
 * 销售单打印
 * @author zhanyao
 */
class SalePrintDo {

	/**
	 * 打印联类型
	 */
	String? printTypeName;

	/**
	 * 店铺ID
	 */
	int? deptId;

	/**
	 * 店铺名称
	 */
	String? deptName;

	/**
	 * 单据号码序号
	 */
	String? orderSerialNo;

	/**
	 * 用户名称
	 */
	String? customerName;

	/**
	 * 客户手机
	 */
	String? customerPhone;

	/**
	 * 单据自定义时间
	 */
	DateTime? customizeTime;

	/**
	 * 跟单人ID
	 */
	int? merchandiserId;

	/**
	 * 跟单人名称
	 */
	String? merchandiserName;

	/**
	 * 跟单人手机
	 */
	String? merchandiserPhone;

	/**
	 * 销售单明细
	 */
	SaleDetail? normalSale;

	/**
	 * 退欠货明细
	 */
	SaleDetail? changeBackOrder;

	/**
	 * 退实物明细
	 */
	SaleDetail? returnGoods;

	/**
	 * 单据备注
	 */
	List<RemarkPrintDo>? remarkPrintDoList;

	/**
	 * 实际应收 (含税)
	 */
	int? taxReceivableAmount;

	/**
	 * 结欠
	 */
	int? balanceAmount;

	/**
	 * 核销
	 */
	int? checkAmount;

	/**
	 * 抹零
	 */
	int? wipeOffAmount;

	/**
	 * 客户总欠款
	 */
	int? customerOweAmount;

	/**
	 * 本次收退款单详情
	 */
	RemitDetail? remitDetail;

	/**
	 * 基础打印数据
	 */
	BasePrintDo? basePrintDo;
}
