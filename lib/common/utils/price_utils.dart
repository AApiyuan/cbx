import 'package:flustars/flustars.dart';

class PriceUtils {
  static String priceString(int? price, {String def = "0", String zero = "0"}) {
    if (price == null)
      return def;
    else if (price == 0) return zero;
    return (NumUtil.getNumByValueDouble(price / 100, 2))?.toStringAsFixed(2) ?? def;
  }

  static String getPrice(int? price, {String? def, bool abs = false}) {
    if (price == null && def != null)
      return def;
    else if (price == null) price = 0;
    var minus = price < 0;
    return "${minus && !abs ? "-" : ""}¥${priceString(minus ? -price : price)}";
  }
}
