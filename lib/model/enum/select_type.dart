class SelectType {
  static const String BASIC = "BASIC"; //只有基础信息
  static const String BASIC_STATIC = "BASIC_STATIC"; //基础信息价统计有库存量销售量，欠货量
  static const String BASIC_STOCK = "BASIC_STOCK"; //只有基础信息+库存量
  static const String NO_HAVE = "NO_HAVE"; //本店没有的商品
  static const String ALL_GOODS = "ALL_GOODS"; //老板所有货品
  static const String SALE_HOT = "SALE_HOT"; //销量热度
  static const String CUSTOMER_BUY = "CUSTOMER_BUY";
  static const String INVENTORY = "INVENTORY";//盘点查找
}
