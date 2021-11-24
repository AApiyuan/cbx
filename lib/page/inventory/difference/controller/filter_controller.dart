import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/enum/order_by.dart' as OrderByEnum;
import 'package:haidai_flutter_module/model/rep/inventory_report_goods_page.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';

class FilterController extends GetxController {
  late InventoryReportGoodsPage _param;
  StoreDictDo? _storeDictDo;

  String? searchContent;

  final num _deptId = ArgUtils.getArgument2num('deptId')!;

  /// 筛选条件 - 全部 id
  static const int CONDITION_ALL_ID = -101;

  /// 选择的品牌
  List<int> _selectedBrand = <int>[];
  List<int> _oldSelectedBrand = <int>[];

  /// 选择的年份
  List<int> _selectedYear = <int>[];
  List<int> _oldSelectedYear = <int>[];

  /// 选择的季节
  List<int> _selectedSeason = <int>[];
  List<int> _oldSelectedSeason = <int>[];

  /// 选择的标签
  List<int> _selectedLabel = <int>[];
  List<int> _oldSelectedLabel = <int>[];

  /// 分类 - 大
  int? selectedClassifyIndex;
  StoreDictData? _classify;
  StoreDictData? _oldClassify;
  List<StoreDictData> _classifies = <StoreDictData>[];

  /// 分类 - 中
  int? selectedClassifyMiddleIndex;
  StoreDictData? _classifyMiddle;
  StoreDictData? _oldClassifyMiddle;
  List<StoreDictData> _classifyMiddles = <StoreDictData>[];

  /// 分类 - 小
  int? selectedClassifySmallIndex;
  StoreDictData? _classifySmall;
  StoreDictData? _oldClassifySmall;
  List<StoreDictData> _classifySmalls = <StoreDictData>[];

  /// 排序,,{字段名field枚举:,inventoryStock盘点库存，loss盘亏，profit盘盈,} ,OrderBy
  OrderBy _orderBy = OrderBy();

  /// 类型/更新标识
  static const String CONDITION_BRAND = "品牌";
  static const String CONDITION_YEAR = "年份";
  static const String CONDITION_CLASSIFY = "货品分类";
  static const String CONDITION_SEASON = "季节";
  static const String CONDITION_LABEL = "标签";
  static const String SORT_PROFIT = "profit";
  static const String SORT_LOSS = "loss";
  static const String SORT_INVENTORY_STOCK = "inventoryStock";
  static const String SORT_FILTER = "filter";
  static const String CLASSIFY_BAR = "classify_bar";
  static const String CLASSIFY = "classify";
  static const String CLASSIFY_MIDDLE = "classify_middle";
  static const String CLASSIFY_SMALL = "classify_small";

  @override
  void onInit() {
    _orderBy.field = SORT_PROFIT;
    _orderBy.by = OrderByEnum.OrderBy.DESC;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _getGoodsFilterConditions();
  }

  void init() {
    _selectedBrand.clear();
    _selectedBrand.addAll(_oldSelectedBrand);

    _selectedYear.clear();
    _selectedYear.addAll(_oldSelectedYear);

    _selectedSeason.clear();
    _selectedSeason.addAll(_oldSelectedSeason);

    _classify = _oldClassify;
    _classifyMiddle = _oldClassifyMiddle;
    _classifySmall = _oldClassifySmall;

    initClassifyData();
  }

  void initClassifyData() {
    selectedClassifyIndex =
        _classify == null ? null : _classifies.indexOf(_classify!);

    selectedClassifyMiddleIndex = _classifyMiddle == null
        ? null : _classifyMiddles.indexOf(_classifyMiddle!);

    _classifyMiddles = _getClassifyMiddles(_classify?.id);

    selectedClassifySmallIndex = _classifySmall == null ? null : _classifySmalls.indexOf(_classifySmall!);
    _classifySmalls = _getClassifySmalls(_classifyMiddle?.id);
  }

  /// 获取筛选条件数据
  void _getGoodsFilterConditions() async {
    _storeDictDo = await GoodsApi.getGoodsFilterConditions(_deptId);
    _classifies = _getClassify();
  }

  /// 获取筛选参数
  InventoryReportGoodsPage getFilterCondition(
      int id, String type, String isInventoryEnum) {
    _param = InventoryReportGoodsPage();
    _param.orderInventoryId = id;
    _param.isInventory = isInventoryEnum;
    _param.orderGoodsType = type;
    _param.goodsBrands = _selectedBrand;
    _param.goodsYears = _selectedYear;
    _param.goodsSeasons = _selectedSeason;
    _param.goodsSeasons = _selectedSeason;
    _param.goodsLabels = _selectedLabel;
    _param.orderBy = _orderBy;
    _param.goodsNameSerial = searchContent;
    _param.goodsClassify = _classify?.id;
    _param.goodsClassifyMiddle = _classifyMiddle?.id;
    _param.goodsClassifySmall = _classifySmall?.id;
    return _param;
  }

  /// 获取筛选条件图片资源
  String getImgAsset(String tag) {
    if (tag == SORT_FILTER) {
      return "images/icon_filtrate_off.png";
    } else if (tag != _orderBy.field) {
      return "images/home_function_null.png";
    } else if (_orderBy.by == OrderByEnum.OrderBy.ASC) {
      return "images/home_function_up.png";
    } else {
      return "images/home_function_down.png";
    }
  }

  /// 修改排序条件
  void changeSortCondition(String tag) {
    List<String> updateIds = <String>[];
    updateIds.add(tag);
    if (_orderBy.field == tag) {
      _orderBy.by = _orderBy.by == OrderByEnum.OrderBy.DESC
          ? OrderByEnum.OrderBy.ASC
          : OrderByEnum.OrderBy.DESC;
    } else {
      updateIds.add(_orderBy.field!);
      _orderBy.field = tag;
      _orderBy.by = OrderByEnum.OrderBy.DESC;
    }
    update(updateIds);
  }

  /// 品牌数据
  List<StoreDictData> getGoodsBrand() {
    return _createConditionList(_storeDictDo?.goodsBrand);
  }

  /// 年份数据
  List<StoreDictData> getGoodsYear() {
    return _createConditionList(_storeDictDo?.goodsYear);
  }

  /// 季节数据
  List<StoreDictData> getGoodsSeason() {
    return _createConditionList(_storeDictDo?.goodsSeason);
  }

  /// 标签数据
  List<StoreDictData> getGoodsLabel() {
    _selectedLabel.clear();
    _selectedLabel.addAll(_oldSelectedLabel);
    return _createConditionList(_storeDictDo?.goodsLabel);
  }

  /// 获取分类数据
  List<StoreDictData> getClassifyData(String tag) {
    List<StoreDictData> list;
    switch (tag) {
      case CLASSIFY:
        list = _classifies;
        break;
      case CLASSIFY_MIDDLE:
        list = _classifyMiddles;
        break;
      case CLASSIFY_SMALL:
        list = _classifySmalls;
        break;
      default:
        list = <StoreDictData>[];
        break;
    }
    return list;
  }

  /// 大类
  List<StoreDictData> _getClassify() {
    return _storeDictDo?.goodsClassify ?? <StoreDictData>[];
  }

  /// 中类
  List<StoreDictData> _getClassifyMiddles(int? parentId) {
    List<StoreDictData> list = <StoreDictData>[];
    if (_storeDictDo == null) {
      return list;
    }
    var goodsClassifyMiddle = _storeDictDo?.goodsClassifyMiddle;
    goodsClassifyMiddle?.forEach((item) {
      if (item.parentId == parentId) {
        list.add(item);
      }
    });
    return list;
  }

  /// 小类
  List<StoreDictData> _getClassifySmalls(int? parentId) {
    List<StoreDictData> list = <StoreDictData>[];
    if (_storeDictDo == null) {
      return list;
    }
    var goodsClassifySmall = _storeDictDo?.goodsClassifySmall;
    goodsClassifySmall?.forEach((item) {
      if (item.parentId == parentId) {
        list.add(item);
      }
    });
    return list;
  }

  /// 分类点击事件
  void actionClassify(String tag, StoreDictData item, int index) {
    List<String> updateIds = <String>[];
    updateIds.add("$tag$index");
    switch (tag) {
      case CLASSIFY:
        _actionClassify(updateIds, tag, item.id!, index);
        break;
      case CLASSIFY_MIDDLE:
        _actionClassifyMiddle(updateIds, tag, item.id!, index);
        break;
      case CLASSIFY_SMALL:
        _actionClassifySmall(updateIds, tag, item.id!, index);
        break;
    }
    if (updateIds.length > 0) {
      update(updateIds);
    }
  }

  /// 大类点击事件
  void _actionClassify(List<String> updateIds, String tag, int id, int index) {
    updateIds.add("$tag$selectedClassifyIndex");
    updateIds.add(CLASSIFY_MIDDLE);
    updateIds.add(CLASSIFY_SMALL);
    selectedClassifyIndex = index;
    _classifyMiddles = _getClassifyMiddles(id);
    _classifyMiddle = null;
    _classifySmalls.clear();
    _classifySmall = null;
    selectedClassifyMiddleIndex = -1;
    selectedClassifySmallIndex = -1;
  }

  /// 中类点击事件
  void _actionClassifyMiddle(
      List<String> updateIds, String tag, int id, int index) {
    updateIds.add("$tag$selectedClassifyMiddleIndex");
    updateIds.add(CLASSIFY_SMALL);
    selectedClassifyMiddleIndex = index;
    _classifySmalls = _getClassifySmalls(id);
    _classifySmall = null;
    selectedClassifySmallIndex = -1;
  }

  /// 小类点击事件
  void _actionClassifySmall(
      List<String> updateIds, String tag, int id, int index) {
    updateIds.add("$tag$selectedClassifySmallIndex");
    selectedClassifySmallIndex = index;
  }

  /// 是否被选中的分类
  bool isSelectedClassify(String tag, int index) {
    bool isSelected;
    switch (tag) {
      case CLASSIFY:
        isSelected = index == selectedClassifyIndex;
        break;
      case CLASSIFY_MIDDLE:
        isSelected = index == selectedClassifyMiddleIndex;
        break;
      case CLASSIFY_SMALL:
        isSelected = index == selectedClassifySmallIndex;
        break;
      default:
        isSelected = false;
        break;
    }
    return isSelected;
  }

  /// 确定分类筛选条件
  void actionConfirmClassifyCondition() {
    if (selectedClassifyIndex != null &&
        selectedClassifyIndex! >= 0 &&
        selectedClassifyIndex! < _classifies.length) {
      _classify = _classifies[selectedClassifyIndex!];
    }
    if (selectedClassifyMiddleIndex != null &&
        selectedClassifyMiddleIndex! >= 0 &&
        selectedClassifyMiddleIndex! < _classifyMiddles.length) {
      _classifyMiddle = _classifyMiddles[selectedClassifyMiddleIndex!];
    }
    if (selectedClassifySmallIndex != null &&
        selectedClassifySmallIndex! >= 0 &&
        selectedClassifySmallIndex! < _classifySmalls.length) {
      _classifySmall = _classifySmalls[selectedClassifySmallIndex!];
    }
    selectedClassifyIndex = -1;
    selectedClassifyMiddleIndex = -1;
    selectedClassifySmallIndex = -1;
    update([CLASSIFY_BAR]);
  }

  /// 清空分类条件
  void clearClassifyCondition() {
    _classify = null;
    _classifyMiddle = null;
    _classifyMiddles.clear();
    _classifySmall = null;
    _classifySmalls.clear();
    update([CLASSIFY_BAR]);
  }

  /// 当前分类条件
  String getClassCondition() {
    return "${_classify?.dictName ?? '无'}-${_classifyMiddle?.dictName ?? '无'}-${_classifySmall?.dictName ?? '无'}";
  }

  /// 是否有分类筛选条件
  bool hasClassifyCondition() {
    return _classify != null;
  }

  List<StoreDictData> _createConditionList(List<StoreDictData>? data) {
    List<StoreDictData> list = <StoreDictData>[];
    StoreDictData all = StoreDictData();
    all.dictName = "全部";
    all.id = CONDITION_ALL_ID;
    list.add(all);
    if (data != null) {
      list.addAll(data);
    }
    return list;
  }

  /// 重置条件
  void resetCondition() {
    List<String> updateIds = <String>[];
    if (_selectedBrand.length > 0) {
      _selectedBrand.clear();
      updateIds.add(CONDITION_BRAND);
    }
    if (_selectedYear.length > 0) {
      _selectedYear.clear();
      updateIds.add(CONDITION_YEAR);
    }
    if (_selectedSeason.length > 0) {
      _selectedSeason.clear();
      updateIds.add(CONDITION_SEASON);
    }
    if (_selectedLabel.length > 0) {
      _selectedLabel.clear();
      updateIds.add(CONDITION_LABEL);
    }
    clearClassifyCondition();
    if (updateIds.length > 0) {
      update(updateIds);
    }
  }

  /// 是否选择
  bool isSelected(String conditionType, int id) {
    bool selected;
    switch (conditionType) {
      case CONDITION_BRAND:
        selected = _selectedBrand.contains(id);
        break;
      case CONDITION_YEAR:
        selected = _selectedYear.contains(id);
        break;
      case CONDITION_SEASON:
        selected = _selectedSeason.contains(id);
        break;
      case CONDITION_LABEL:
        selected = _selectedLabel.contains(id);
        break;
      default:
        selected = false;
        break;
    }
    return selected;
  }

  /// 保存/移除选择
  void saveOrRemoveSelect(String conditionType, int id) {
    switch (conditionType) {
      case CONDITION_BRAND:
        _saveOrRemoveBrand(conditionType, id);
        break;
      case CONDITION_YEAR:
        _saveOrRemoveYear(conditionType, id);
        break;
      case CONDITION_SEASON:
        _saveOrRemoveSeason(conditionType, id);
        break;
      case CONDITION_LABEL:
        _saveOrRemoveLabel(conditionType, id);
        break;
    }
    update([conditionType]);
  }

  /// 保存/移除 品牌选择
  void _saveOrRemoveBrand(String conditionType, int id) {
    if (id == CONDITION_ALL_ID) {
      _selectedBrand.clear();
    } else if (isSelected(conditionType, id)) {
      _selectedBrand.remove(id);
    } else {
      _selectedBrand.add(id);
    }
  }

  /// 保存/移除 年份选择
  void _saveOrRemoveYear(String conditionType, int id) {
    if (id == CONDITION_ALL_ID) {
      _selectedYear.clear();
    } else if (isSelected(conditionType, id)) {
      _selectedYear.remove(id);
    } else {
      _selectedYear.add(id);
    }
  }

  /// 保存/移除 季节选择
  void _saveOrRemoveSeason(String conditionType, int id) {
    if (id == CONDITION_ALL_ID) {
      _selectedSeason.clear();
    } else if (isSelected(conditionType, id)) {
      _selectedSeason.remove(id);
    } else {
      _selectedSeason.add(id);
    }
  }

  /// 保存/移除 标签选择
  void _saveOrRemoveLabel(String conditionType, int id) {
    if (id == CONDITION_ALL_ID) {
      _selectedLabel.clear();
    } else if (isSelected(conditionType, id)) {
      _selectedLabel.remove(id);
    } else {
      _selectedLabel.add(id);
    }
  }

  /// 获取已选条件数量
  int getSelectedConditionCount(String conditionType) {
    int count;
    switch (conditionType) {
      case CONDITION_BRAND:
        count = _selectedBrand.length;
        break;
      case CONDITION_YEAR:
        count = _selectedYear.length;
        break;
      case CONDITION_SEASON:
        count = _selectedSeason.length;
        break;
      case CONDITION_LABEL:
        count = _selectedLabel.length;
        break;
      default:
        count = 0;
        break;
    }
    return count;
  }

  /// 是否选择排序条件
  bool hasSelectedSort(String tag) {
    if (tag == SORT_FILTER) {
      return _hasFilterCondition();
    } else {
      return _orderBy.field == tag;
    }
  }

  /// 是否有筛选条件
  bool _hasFilterCondition() {
    return _selectedBrand.length > 0 ||
        _selectedSeason.length > 0 ||
        _selectedYear.length > 0 ||
        _selectedLabel.length > 0 ||
        _classify != null;
  }

  /// 保存上次筛选条件
  void saveCondition() {
    _oldSelectedBrand.clear();
    _oldSelectedBrand.addAll(_selectedBrand);

    _oldSelectedYear.clear();
    _oldSelectedYear.addAll(_selectedYear);

    _oldSelectedSeason.clear();
    _oldSelectedSeason.addAll(_selectedSeason);

    _oldSelectedLabel.clear();
    _oldSelectedLabel.addAll(_selectedLabel);

    _oldClassify = _classify;
    _oldClassifyMiddle = _classifyMiddle;
    _oldClassifySmall = _classifySmall;

    update([SORT_FILTER]);
  }
}
