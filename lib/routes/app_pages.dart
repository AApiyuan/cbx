import 'package:haidai_flutter_module/routes/pages/Inventory_pages.dart';
import 'package:haidai_flutter_module/routes/pages/bi_pages.dart';
import 'package:haidai_flutter_module/routes/pages/common_pages.dart';
import 'package:haidai_flutter_module/routes/pages/customer_pages.dart';
import 'package:haidai_flutter_module/routes/pages/deliver_pages.dart';
import 'package:haidai_flutter_module/routes/pages/goods_pages.dart';
import 'package:haidai_flutter_module/routes/pages/hang_order_pages.dart';
import 'package:haidai_flutter_module/routes/pages/help_pages.dart';
import 'package:haidai_flutter_module/routes/pages/sale_pages.dart';
import 'package:haidai_flutter_module/routes/pages/stock_pages.dart';
import 'package:haidai_flutter_module/routes/pages/verification_pages.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    ...CommonPages.pages,
    ...InventoryPages.pages,
    ...GoodsPages.pages,
    ...CustomerPages.pages,
    ...StockPages.pages,
    ...SalePages.pages,
    ...HangOrderPages.pages,
    ...BiPages.pages,
    ...VerificationPages.pages,
    ...DeliverPages.pages,
    ...HelpPages.pages,
  ];
}
