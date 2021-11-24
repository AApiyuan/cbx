import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class VerificationModeLogic extends GetxController {
  // 这里应该字段区分 直接模式 或 订单模式

  Map orderTitleMap = {
    "CONFIG_NUCLEAR_3_3": "从最早时间订单开始核销（自动）",
    "CONFIG_NUCLEAR_3_4": "从最近时间订单开始核销（自动）",
    "CONFIG_NUCLEAR_3_5": "手动选择",
    "CONFIG_NUCLEAR_1_0": "优先本单,从最早时间订单开始核销（自动）",
    "CONFIG_NUCLEAR_1_1": "优先本单,从最近时间订单开始核销（自动）",
    "CONFIG_NUCLEAR_1_2": "优先本单,手动选择",
    "CONFIG_NUCLEAR_1_3": "从最早时间订单开始核销（自动）",
    "CONFIG_NUCLEAR_1_4": "从最近时间订单开始核销（自动）",
    "CONFIG_NUCLEAR_1_5": "手动选择",
  };

  // 核销模式
  String _verificationMode = ArgUtils.getArgument('verificationMode') as String;
  int orderSaleId = int.parse(ArgUtils.getArgument('orderSaleId').toString());

  bool isOrderSaleId = false;
  bool isPriority = false;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    if (orderSaleId > 0) {
      this.isOrderSaleId = true;
    }

    if (_verificationMode.contains('CONFIG_NUCLEAR_1')) {
      this.isPriority = true;
    }

    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // 获取一项颜色
  int getItemColor(verificationMode) {
    if (verificationMode == _verificationMode) {
      return ColorConfig.color_1678ff;
    } else {
      return ColorConfig.color_666666;
    }
  }

  // 获取一项背景颜色
  int getItemBackgroundColor(verificationMode) {
    if (verificationMode == _verificationMode) {
      return ColorConfig.color_E8F2FF;
    } else {
      return ColorConfig.color_f5f5f5;
    }
  }

  // 修改选项
  changeSelectedItem(verificationMode) {
    _verificationMode = verificationMode;
    update();
  }

  // 确定-返回
  confirmBack() {
    Get.back(result: _verificationMode);
  }
}
