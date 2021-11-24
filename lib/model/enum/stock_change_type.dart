class OrderStockTypeEnum {
  /// 入库
  static const String DIRECT_IN = "DIRECT_IN";

  /// 出库单，直接出库
  static const String DIRECT_OUT = "DIRECT_OUT";

  /// 调拨入库
  static const String TRANSFER_IN = "TRANSFER_IN";

  /// 调拨出库
  static const String TRANSFER_OUT = "TRANSFER_OUT";

  /// 工厂发货入库
  static const String FACTORY_IN = "FACTORY_IN";

  /// 工厂发货出库
  static const String DELIVER_OUT = "DELIVER_OUT";

  /// 档口配货出库
  static const String DISTRIBUTION_OUT = "DISTRIBUTION_OUT";

  /// 档口配货出库
  static const String DISTRIBUTION_IN = "DISTRIBUTION_IN";

  /// 档口退货入库
  static const String BACK_IN = "BACK_IN";

  /// 库存调整单，可正可负
  static const String ADJUST = "ADJUST";

  /// 改码调整单，可正可负
  static const String EXCHANGE_ADJUST = "EXCHANGE_ADJUST";

  /// 盘点调整(正)
  static const String INVENTORY_ADJUST = "INVENTORY_ADJUST";

  /// 次品记录
  static const String SUBSTANDARD_RECORD = "SUBSTANDARD_RECORD";

  /// 次品复原
  static const String SUBSTANDARD_RECOVER = "SUBSTANDARD_RECOVER";

  /// 次品调整
  static const String SUBSTANDARD_ADJUST = "SUBSTANDARD_ADJUST";

  /// 次品出库
  static const String SUBSTANDARD_OUT = "SUBSTANDARD_OUT";

  /// 次品退货
  static const String SUBSTANDARD_BACK = "SUBSTANDARD_BACK";

  /// 盘点调整(次)
  static const String INVENTORY_SUBSTANDARD_ADJUST = "INVENTORY_SUBSTANDARD_ADJUST";

  /// 次品调拨入库
  static const String SUBSTANDARD_TRANSFER_IN = "SUBSTANDARD_TRANSFER_IN";

  /// 次品调拨出库
  static const String SUBSTANDARD_TRANSFER_OUT = "SUBSTANDARD_TRANSFER_OUT";

  static String transfer(String name) {
    if (name == DIRECT_IN) {
      return "直接入库";
    }
    if (name == DIRECT_OUT) {
      return "直接出库";
    }
    if (name == TRANSFER_IN) {
      return "调拨入库";
    }
    if (name == TRANSFER_OUT) {
      return "调拨出库";
    }

    if (name == FACTORY_IN) {
      return "工厂发货入库";
    }
    if (name == DELIVER_OUT) {
      return "发货出库";
    }
    if (name == DISTRIBUTION_OUT) {
      return "配货出库";
    }
    if (name == DISTRIBUTION_IN) {
      return "配货入库";
    }
    if (name == BACK_IN) {
      return "退货入库";
    }
    if (name == ADJUST) {
      return "正品调整";
    }
    if (name == EXCHANGE_ADJUST) {
      return "改码调整";
    }
    if (name == INVENTORY_ADJUST) {
      return "盘点调整(正)";
    }
    if (name == SUBSTANDARD_RECORD) {
      return "次品记录";
    }
    if (name == SUBSTANDARD_RECOVER) {
      return "次品复原";
    }
    if (name == SUBSTANDARD_ADJUST) {
      return "次品调整";
    }
    if (name == SUBSTANDARD_OUT) {
      return "次品出库";
    }
    if (name == SUBSTANDARD_ADJUST) {
      return "次品调整";
    }
    if (name == SUBSTANDARD_BACK) {
      return "次品退货";
    }
    if (name == INVENTORY_SUBSTANDARD_ADJUST) {
      return "盘点调整(次)";
    }
    if (name == SUBSTANDARD_TRANSFER_IN) {
      return "次品调拨入库";
    }
    if (name == SUBSTANDARD_TRANSFER_OUT) {
      return "次品调拨出库";
    }
    return "";
  }
}
