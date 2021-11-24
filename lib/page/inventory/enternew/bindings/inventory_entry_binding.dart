
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/inventory/enternew/controller/entry_confim_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enternew/controller/inventoryentry_controller.dart';

class InventoryEntryBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies]
    Get.lazyPut(() => EntryConfirmController());
    Get.lazyPut(() => InventoryEntryController());
  }
}