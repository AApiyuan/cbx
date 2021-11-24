import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/classify_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/sort_dialog.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';

class SearchScreenSortController extends GetxController {
  final deptId = ArgUtils.getArgument2num('deptId')!;

  /**********************************   排序   *******************************/

  static get bIdSort => "b_id_sort";

  static get filterData => "filterData";

  String? sortName;

  initSort(String? name) {
    if (sortName == null) updateSort(name);
  }

  updateSort(String? name) {
    this.sortName = name;
    update([bIdSort]);
  }

  OrderBy get orderBy => SortDialog.orderBy[SortDialog.name.indexOf(sortName!)];

  /**********************************   筛选   *******************************/

  static get bIdGoodsBrand => "b_id_goods_brand";

  static get bIdGoodsSeason => "b_id_goods_season";

  static get bIdGoodsLabel => "b_id_goods_label";

  static get bIdGoodsYear => "b_id_goods_year";

  static get bIdGoodsClassify => "b_id_goods_classify";

  static get bIdGoodsClassifySmall => "b_id_goods_classify_small";

  static get bIdGoodsClassifyMiddle => "b_id_goods_classify_middle";

  static get bIdGoodsSearch => "b_id_goods_search";

  static get bIdGoodsSearchState => "b_id_goods_search_state";

  String searchText = '';
  bool searchShow = false;

  late StoreDictDo _storeDictDo;
  Map<String, List<int>> _selectData = {
    bIdGoodsBrand: [],
    bIdGoodsSeason: [],
    bIdGoodsLabel: [],
    bIdGoodsYear: [],
    bIdGoodsClassify: [],
    bIdGoodsClassifyMiddle: [],
    bIdGoodsClassifySmall: [],
  };
  Map<String, List<int?>> _tempSelectData = {
    bIdGoodsBrand: [],
    bIdGoodsSeason: [],
    bIdGoodsLabel: [],
    bIdGoodsYear: [],
    bIdGoodsClassify: [],
    bIdGoodsClassifyMiddle: [],
    bIdGoodsClassifySmall: [],
  };

  initScreenData() {
    _tempSelectData.forEach((key, value) => _tempSelectData[key]!.clear());
    _selectData.forEach((key, value) =>
        value.forEach((element) => _tempSelectData[key]!.add(element)));
  }

  @override
  void onInit() {
    super.onInit();
    _getGoodsFilterConditions();
  }

  _getGoodsFilterConditions() async {
    _storeDictDo = await GoodsApi.getGoodsFilterConditions(deptId);
  }

  // Map<String, StoreDictData> _classifyData = {
  //   ClassifyController.CLASSIFY: null,
  //   ClassifyController.CLASSIFY_MIDDLE: null,
  //   ClassifyController.CLASSIFY_SMALL: null,
  // };

  // Map<String, StoreDictData> get classifyData => _classifyData;

  Map<String, List<int>>? get selectData => _selectData;

  List<StoreDictData>? get goodsBrand => _storeDictDo.goodsBrand;

  List<StoreDictData>? get goodsSeason => _storeDictDo.goodsSeason;

  List<StoreDictData>? get goodsLabel => _storeDictDo.goodsLabel;

  List<StoreDictData>? get goodsYear => _storeDictDo.goodsYear;

  List<StoreDictData>? get goodsClassify => _storeDictDo.goodsClassify;

  List<StoreDictData>? get goodsClassifyMiddle =>
      _storeDictDo.goodsClassifyMiddle;

  List<StoreDictData>? get goodsClassifySmall => _storeDictDo.goodsClassifySmall;

  bool get goodsBrandEmpty => goodsBrand == null || goodsBrand?.length == 0;

  bool get goodsSeasonEmpty => goodsSeason == null || goodsSeason?.length == 0;

  bool get goodsLabelEmpty => goodsLabel == null || goodsLabel?.length == 0;

  bool get goodsYearEmpty => goodsYear == null || goodsYear?.length == 0;

  bool get goodsClassifyEmpty =>
      goodsClassify == null || goodsClassify?.length == 0;

  saveOrRemoveSelect(String conditionType, int id) {
    if (_tempSelectData[conditionType]!.contains(id)) {
      _tempSelectData[conditionType]!.remove(id);
    } else {
      _tempSelectData[conditionType]!.add(id);
    }
    update([conditionType]);
  }

  saveClassifySelect(Map<String, StoreDictData?> classifyData) {
    _tempSelectData[bIdGoodsClassify]!.clear();
    _tempSelectData[bIdGoodsClassifyMiddle]!.clear();
    _tempSelectData[bIdGoodsClassifySmall]!.clear();
    _tempSelectData[bIdGoodsClassify]!
        .add(classifyData[ClassifyController.CLASSIFY]?.id ?? null);
    _tempSelectData[bIdGoodsClassifyMiddle]!
        .add(classifyData[ClassifyController.CLASSIFY_MIDDLE]?.id ?? null);
    _tempSelectData[bIdGoodsClassifySmall]!
        .add(classifyData[ClassifyController.CLASSIFY_SMALL]?.id ?? null);
    update([bIdGoodsClassify]);
  }

  String getClassifyName() {
    String big = "无";
    goodsClassify?.forEach((element) {
      if (_tempSelectData[bIdGoodsClassify]!.contains(element.id))
        big = element.dictName!;
      return;
    });
    String middle = "无";
    goodsClassifyMiddle?.forEach((element) {
      if (_tempSelectData[bIdGoodsClassifyMiddle]!.contains(element.id))
        middle = element.dictName!;
      return;
    });
    String small = "无";
    goodsClassifySmall?.forEach((element) {
      if (_tempSelectData[bIdGoodsClassifySmall]!.contains(element.id))
        small = element.dictName!;
      return;
    });
    return "$big-$middle-$small";
  }

  bool hasSelect(String conditionType, int id) {
    return _tempSelectData[conditionType]!.contains(id);
  }

  int? getClassifySelect(String conditionType) {
    return _tempSelectData[conditionType]!.length == 0
        ? null
        : _tempSelectData[conditionType]![0];
  }

  clearClassifyCondition() {
    _tempSelectData[bIdGoodsClassify]!.clear();
    _tempSelectData[bIdGoodsClassifyMiddle]!.clear();
    _tempSelectData[bIdGoodsClassifySmall]!.clear();
    update([bIdGoodsClassify]);
  }

  bool hasClassifyCondition() => _tempSelectData[bIdGoodsClassify]!.length > 0;

  clearSearch() {
    searchText = '';
    update([bIdGoodsSearch]);
  }

  updateSearchText(String text) {
    searchText = text;
    update([bIdGoodsSearch]);
  }

  hideSearch() {
    clearSearch();
    searchShow = false;
    update([bIdGoodsSearchState]);
  }

  showSearch() {
    searchShow = true;
    update([bIdGoodsSearchState]);
  }

  void reset() {
    _tempSelectData.forEach((key, value) => value.clear());
    update([
      bIdGoodsClassify,
      bIdGoodsYear,
      bIdGoodsLabel,
      bIdGoodsSeason,
      bIdGoodsBrand
    ]);
  }

  affirmSelect() {
    _selectData.forEach((key, value) => _selectData[key]!.clear());
    _tempSelectData.forEach((key, value) =>
        value.forEach((element) => _selectData[key]!.add(element!)));

    update([filterData]);
    /**********************************   搜索   *******************************/
  }

  /// 是否有筛选条件
  bool hasFilterCondition() {
    var b = false;
    _selectData.forEach((key, value) {
      if (value.length > 0){
        b = true;
      }
    });
    return b;
  }
}
