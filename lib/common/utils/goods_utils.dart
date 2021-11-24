class GoodsUtils {
  static String getGoodsTitle(String? serial, String? name) {
    return "${serial ?? ""}${name == null || name.length == 0 ? "" : "-$name"}";
  }

  static String getGoodsCover(String? imgPath, String? cover) {
    return "$imgPath/$cover";
  }
}
