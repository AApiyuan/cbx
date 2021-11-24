class Table {
  /// 打印文字大小倍数
  int? width;

  /// 打印内容
  String? body;

  /// 打印内容
  bool? placeholder;

  static Table createTable1(int width, String body) {
    Table table = new Table();
    table.width = width;
    table.body = body;
    table.placeholder = false;
    return table;
  }

  static Table createTable2(bool placeholder) {
    Table table = new Table();
    table.width = 0;
    table.placeholder = true;
    return table;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['width'] = width;
    map['body'] = body;
    map['placeholder'] = placeholder;
    return map;
  }
}