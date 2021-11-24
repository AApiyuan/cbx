import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/controller/select_stock_controller.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/widget/confirm.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/widget/stock_filter.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/widget/stock_list.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/widget/table_header.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class SelectStockView extends GetView<SelectStockController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(ColorConfig.color_ffffff),
        appBar: pAppBar("复制入库单直接调拨", back: true, type: 0),
        body: StockListView(data: controller.data),
        bottomSheet: confirm());
  }
}
