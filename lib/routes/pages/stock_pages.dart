import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/distribution/bindings/distribution_binding.dart';
import 'package:haidai_flutter_module/page/distribution/view/distribution_view.dart';
import 'package:haidai_flutter_module/page/inventory/enternew/bindings/inventory_entry_binding.dart';
import 'package:haidai_flutter_module/page/inventory/enternew/controller/inventoryentry_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enternew/view/inventoryentry_controller_view.dart';
import 'package:haidai_flutter_module/page/stock/create/bindings/stock_binding.dart';
import 'package:haidai_flutter_module/page/stock/create/view/stock_view.dart';
import 'package:haidai_flutter_module/page/stock/detail/bindings/stock_detail_binding.dart';
import 'package:haidai_flutter_module/page/stock/detail/view/stock_detail_view.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/bindings/select_stock_binding.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/view/select_stock_view.dart';
import 'package:haidai_flutter_module/page/transfer/center/bindings/transfer_center_binding.dart';
import 'package:haidai_flutter_module/page/transfer/center/bindings/transfer_center_selectgood_binding.dart';
import 'package:haidai_flutter_module/page/transfer/center/view/transfer_center_selectgood_view.dart';
import 'package:haidai_flutter_module/page/transfer/center/view/transfer_center_view.dart';
import 'package:haidai_flutter_module/page/transfer/center/widget/transfer_filter_good.dart';
import 'package:haidai_flutter_module/page/transfer/create/bindings/transfer_binding.dart';
import 'package:haidai_flutter_module/page/transfer/create/view/transfer_view.dart';
import 'package:haidai_flutter_module/page/transfer/detail/bindings/transfer_detail_binding.dart';
import 'package:haidai_flutter_module/page/transfer/detail/view/transfer_detail_view.dart';
import 'package:haidai_flutter_module/page/transfer/distribution/bindings/transfer_distribution_binding.dart';
import 'package:haidai_flutter_module/page/transfer/distribution/bindings/transfer_distribution_record_binding.dart';
import 'package:haidai_flutter_module/page/transfer/distribution/view/transfer_distribution_record_view.dart';
import 'package:haidai_flutter_module/page/transfer/distribution/view/transfer_distribution_view.dart';
import 'package:haidai_flutter_module/page/transfer/transfer_operation/bindings/transfer_operation_binding.dart';
import 'package:haidai_flutter_module/page/transfer/transfer_operation/view/transfer_operaton_view.dart';

import '../app_pages.dart';

class StockPages {
  static final pages = [
    GetPage(
      name: Routes.STOCK,
      page: () => StockView(),
      binding: StockBinding(),
    ),
    GetPage(
      name: Routes.STOCK_DETAIL,
      page: () => StockDetailView(),
      binding: StockDetailBinding(),
    ),
    GetPage(
      name: Routes.STOCK_SELECT,
      page: () => SelectStockView(),
      binding: SelectStockBinding(),
    ),
    GetPage(
      name: Routes.TRANSFER,
      page: () => TransferView(),
      binding: TransferBinding(),
    ),
    GetPage(
      name: Routes.TRANSFER_OPERATION,
      page: () => TransferOperationView(),
      binding: TransferOperationBinding(),
    ),
    GetPage(
      name: Routes.TRANSFER_DETAIL,
      page: () => TransferDetailView(),
      binding: TransferDetailBinding(),
    ),
    GetPage(
      name: Routes.TRANSFER_CENTER,
      page: () => TransferCenterView(),
      binding: TransferCenterBinding(),
    ),
    GetPage(
      name: Routes.TRANSFER_CENTERSELECTGOOD,
      page: () => TransferCenterSelectgoodView(),
      binding: TransferCenterSelectGoodBinding(),
    ),
    GetPage(
      name: Routes.TRANSFER_DISTRIBUTION,
      page: () => TransferDistributionView(),
      binding: TransferDistributionBinding(),
    ),
    GetPage(
      name: Routes.TRANSFER_DISTRIBUTION_RECORD,
      page: () => TransferDistributionRecordView(),
      binding: TransferDistributionRecordBinding(),
    ),
    GetPage(
      name: Routes.DISTRIBUTION,
      page: () => DistributionView(),
      binding: DistributionBinding(),
    ),
    GetPage(
      name: Routes.ENTERNEW,
      page: () => InventoryEntryControllerView(),
      binding: InventoryEntryBinding(),
    ),
  ];
}
