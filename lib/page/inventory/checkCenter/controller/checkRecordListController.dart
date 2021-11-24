import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/common/utils/upload_img_utils.dart';
import 'package:haidai_flutter_module/model/checkCenter/inventory_member_do.dart';
import 'package:haidai_flutter_module/model/checkCenter/inventory_record_item_do_entity.dart';
import 'package:haidai_flutter_module/repository/check_api.dart';
import 'package:haidai_flutter_module/repository/order/inventory_api.dart';

class CheckRecordListController extends GetxController {
  List<InventoryRecordItemDoEntity> _inventoryRecordItemDoEntity = <InventoryRecordItemDoEntity>[];
  int _goodsStyleNum = 0;
  int _goodsNum = 0;

  static String ids = "checkRecordList";
  bool noMore = false; //是否需要加载更多

  final num userId = ArgUtils.getArgument2num('userId')!;
  final num orderId = ArgUtils.getArgument2num('orderId')!;
  final num depId = ArgUtils.getArgument2num('depId')!;
  final isSubstandard = ArgUtils.getArgument2bool('isSubstandard');
  final String? orderGoodsType = ArgUtils.getArgument('orderGoodsType');
  final String? status = ArgUtils.getArgument('status');

  Future checkRecordList() async {
    print("flutter=======checkRecordList await");
    // return await Future.wait([
    //   CheckApi.checkRecordList(orderId, userId, orderGoodsType),
    //   CheckApi.getInventoryMember(orderId, userId, orderGoodsType)
    // ]).then((value) {
    //   _inventoryRecordItemDoEntity = value[0] as List<InventoryRecordItemDoEntity>;
    //   InventoryMemberDo inventoryMemberDo = value[1] as InventoryMemberDo;
    //   _goodsStyleNum = inventoryMemberDo.goodsStyleNum ?? 0;
    //   _goodsNum = inventoryMemberDo.goodsNum ?? 0;
    //   print("flutter=======checkRecordList");
    //   update([ids]);
    // });
    _inventoryRecordItemDoEntity = await CheckApi.checkRecordList(orderId, userId, orderGoodsType);
    InventoryMemberDo inventoryMemberDo = await CheckApi.getInventoryMember(orderId, userId, orderGoodsType);
    _goodsStyleNum = inventoryMemberDo.goodsStyleNum ?? 0;
    _goodsNum = inventoryMemberDo.goodsNum ?? 0;
    update([ids]);
  }

  List<InventoryRecordItemDoEntity> getValue() {
    return _inventoryRecordItemDoEntity;
  }

  int get goodsStyleNum => _goodsStyleNum;

  int get goodsNum => _goodsNum;

  /// 获取图片链接
  String? getImgUrl(InventoryRecordItemDoEntity entity, int index) {
    String? images = entity.recordImg;
    if (images == null) {
      return "";
    }
    final imgList = images.split(",");
    if (index == imgList.length || index > imgList.length) {
      return "";
    }
    return imgList[index];
  }

  /// 修改记录图片
  Future changeRecordImg(
       int inventoryRecordId, String path, int index) async {
    if (path.isEmpty) {
      toastMsg("获取图片失败");
      return;
    }
    String url =
        await uploadInventoryRecordImg(depId, inventoryRecordId, path);
    InventoryRecordItemDoEntity entity = _inventoryRecordItemDoEntity[index];
    if (entity.recordImg == null || entity.recordImg!.isEmpty) {
      entity.recordImg = url;
    } else {
      entity.recordImg = "${entity.recordImg},$url";
    }
    return _requestChangeImg(
        depId, inventoryRecordId, entity.recordImg!, index);
  }

  /// 删除图片
  Future deleteRecordImg(int inventoryRecordId, String? path, int index) async {
    InventoryRecordItemDoEntity entity = _inventoryRecordItemDoEntity[index];
    final split = entity.recordImg?.split(",");
    if (split == null) {
      toastMsg("删除图片失败");
      return;
    }
    split.remove(path);
    entity.recordImg = split.length == 0 ? "" : split[0];
    return _requestChangeImg(
        depId, inventoryRecordId, entity.recordImg!, index);
  }

  /// 请求修改图片
  Future _requestChangeImg(
      num deptId, int inventoryRecordId, String recordImg, int index) async {
    return await CheckApi.checkRecordImg({
      "inventoryRecordId": inventoryRecordId,
      "recordImg": recordImg,
    }).then((value) => update(["$index"]));
  }
  /// 删除盘点记录
  Future deleteData(recordId) {
    return InventoryApi.deleteInventoryOrder(recordId!)
        .then((value){
      toastMsg("删除成功");
      checkRecordList();
    });
  }

  void reset() {
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    checkRecordList();
  }

  @override
  void onClose() {
    super.onClose();
    reset();
  }
}
