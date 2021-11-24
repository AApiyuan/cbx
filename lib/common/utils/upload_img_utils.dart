import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';

Future<String> uploadInventoryRecordImg(
    num deptId, int inventoryId, String imgUrl) async {
  int index = imgUrl.lastIndexOf(".");
  String imageSuffix = imgUrl.substring(index);
  print('flutter === imageSuffix $imageSuffix');
  String objectKey =
      "$deptId/inventory/$inventoryId/${generateMD5(imgUrl)}$imageSuffix";
  print('flutter === objectKey $objectKey');
  MethodChannel channel = MethodChannel(ChannelConfig.flutterToNative);
  String? url = await channel.invokeMethod(ChannelConfig.methodUploadImg, {
    "objectKey": objectKey,
    "uploadFilePath": imgUrl,
  });
  if (url == null) {
    Future.error("图片上传失败");
    return "";
  }
  return url;
}

String generateMD5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}
