import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/inventory_report_entity.dart';
import 'package:haidai_flutter_module/repository/difference_api.dart';
import 'package:haidai_flutter_module/repository/check_api.dart';

class DifferenceController extends GetxController {
  InventoryReportEntity _data = InventoryReportEntity();
  final id = ArgUtils.getArgument2num('id')!;
  final depId = ArgUtils.getArgument2num('depId');

  num radioGroupQuality = 0;
  num radioGroupInferior=  0;

  @override
  void onReady(){
    super.onReady();
    getInventoryReport(id);
  }

  Future getInventoryReport(num id) async {
    return await DifferenceApi.getInventoryReport(id).then((value) {
      _data = value;
      update();
    });
  }

  Future<bool> checkFinish(dynamic param) async {
    return await CheckApi.checkFinish(param);
  }

  InventoryReportEntity data(){
    return _data;
  }

  void handleRadioValueChangedQuality(int value) {
    update(["quality $radioGroupQuality"]);
    radioGroupQuality = value;
    update(["quality $radioGroupQuality"]);
  }

  void handleRadioValueChangedInferior(int value) {
    update(["inferior $radioGroupInferior"]);
    radioGroupInferior = value;
    update(["inferior $radioGroupInferior"]);
  }
}
