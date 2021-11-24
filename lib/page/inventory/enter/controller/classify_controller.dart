import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';

class ClassifyController extends GetxController {
  static const CLASSIFY = "CLASSIFY";
  static const CLASSIFY_MIDDLE = "CLASSIFY_MIDDLE";
  static const CLASSIFY_SMALL = "CLASSIFY_SMALL";

  late Map<String, List<StoreDictData>?> _classifyData;
  Map<String, int?> _tempMap = {};

  initData(Map<String, List<StoreDictData>?> classifyData,
      {int? big, int? middle, int? small}) {
    this._classifyData = classifyData;
    this._tempMap[CLASSIFY] = big;
    this._tempMap[CLASSIFY_MIDDLE] = middle;
    this._tempMap[CLASSIFY_SMALL] = small;
  }

  Map<String, StoreDictData?> getSelectMap() {
    Map<String, StoreDictData?> map = {};
    map[CLASSIFY] = null;
    _classifyData[CLASSIFY]?.forEach((element) {
      if (element.id == _tempMap[CLASSIFY]) {
        map[CLASSIFY] = element;
      }
    });
    map[CLASSIFY_MIDDLE] = null;
    _classifyData[CLASSIFY_MIDDLE]?.forEach((element) {
      if (element.id == _tempMap[CLASSIFY_MIDDLE]) {
        map[CLASSIFY_MIDDLE] = element;
      }
    });
    map[CLASSIFY_SMALL] = null;
    _classifyData[CLASSIFY_SMALL]?.forEach((element) {
      if (element.id == _tempMap[CLASSIFY_SMALL]) {
        map[CLASSIFY_SMALL] = element;
      }
    });
    return map;
  }

  List<StoreDictData>? getClassifyData(String tag) {
    if (tag == CLASSIFY) {
      return _classifyData[tag];
    } else if (tag == CLASSIFY_MIDDLE) {
      List<StoreDictData> list = [];
      if (_tempMap[CLASSIFY] != null) {
        int parentId = _tempMap[CLASSIFY]!;
        _classifyData[tag]?.forEach((element) {
          if (element.parentId == parentId) list.add(element);
        });
      }
      return list;
    } else {
      List<StoreDictData> list = [];
      if (_tempMap[CLASSIFY_MIDDLE] != null) {
        int parentId = _tempMap[CLASSIFY_MIDDLE]!;
        _classifyData[tag]?.forEach((element) {
          if (element.parentId == parentId) list.add(element);
        });
      }
      return list;
    }
  }

  bool isSelectedClassify(String tag, int id) {
    return _tempMap[tag] != null && _tempMap[tag] == id;
  }

  actionClassify(String tag, int id) {
    if (tag == CLASSIFY) {
      _tempMap[tag] = id;
      _tempMap[CLASSIFY_MIDDLE] = null;
      _tempMap[CLASSIFY_SMALL] = null;
      update([CLASSIFY, CLASSIFY_MIDDLE, CLASSIFY_SMALL]);
    } else if (tag == CLASSIFY_MIDDLE) {
      _tempMap[tag] = id;
      _tempMap[CLASSIFY_SMALL] = null;
      update([CLASSIFY_MIDDLE, CLASSIFY_SMALL]);
    } else {
      _tempMap[tag] = id;
      update([CLASSIFY_SMALL]);
    }
  }
}
