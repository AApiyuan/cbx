/**
 * 部门配置选项
 * @author zhanyao
 */
enum CustomerDeptConfigDataEnum{

	/**
	 * 是
	 */
	CONFIG_PRICE_1_0,
	/**
	 * 否
	 */
	CONFIG_PRICE_1_1,
	/**
	 * 是
	 */
	CONFIG_PRICE_2_0,
	/**
	 * 否
	 */
	CONFIG_PRICE_2_1,
	/**
	 * 优先本单,从最早时间订单开始核销（自动）
	 */
	CONFIG_NUCLEAR_1_0,
	/**
	 * 优先本单,从最近时间订单开始核销（自动）
	 */
	CONFIG_NUCLEAR_1_1,
	/**
	 * 优先本单,手动选择
	 */
	CONFIG_NUCLEAR_1_2,
	/**
	 * 从最早时间订单开始核销（自动）
	 */
	CONFIG_NUCLEAR_1_3,
	/**
	 * 从最近时间订单开始核销（自动）
	 */
	CONFIG_NUCLEAR_1_4,
	/**
	 * 手动选择
	 */
	CONFIG_NUCLEAR_1_5,
	/**
	 * 优先本单,从最早时间订单开始核销（自动）
	 */
	CONFIG_NUCLEAR_3_0,
	/**
	 * 优先本单,从最近时间订单开始核销（自动）
	 */
	CONFIG_NUCLEAR_3_1,
	/**
	 * 优先本单,手动选择
	 */
	CONFIG_NUCLEAR_3_2,
	/**
	 * 从最早时间订单开始核销（自动）
	 */
	CONFIG_NUCLEAR_3_3,
	/**
	 * 从最近时间订单开始核销（自动）
	 */
	CONFIG_NUCLEAR_3_4,
	/**
	 * 手动选择
	 */
	CONFIG_NUCLEAR_3_5,
	/**
	 * 系统默认
	 */
	CONFIG_NUCLEAR_2_0,
	/**
	 * 是
	 */
	CONFIG_PUBLISH_1_0,
	/**
	 * 否
	 */
	CONFIG_PUBLISH_1_1,
	/**
	 * 每次询问
	 */
	CONFIG_STOCK_1_0,
	/**
	 * 默认导入
	 */
	CONFIG_STOCK_1_1,
	/**
	 * 默认不导入
	 */
	CONFIG_STOCK_1_2
}
