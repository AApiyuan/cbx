import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class AddGoodsEvent {
  int? goodsId;
  int? fixGoodsId;
  String? tag;

  AddGoodsEvent(int goodsId, {int? fixGoodsId, String? tag}) {
    this.goodsId = goodsId;
    if (fixGoodsId != null) {
      this.fixGoodsId = fixGoodsId;
    }
    if (tag != null) {
      this.tag = tag;
    }
  }
}

class UpdateHangOrderEvent {
}