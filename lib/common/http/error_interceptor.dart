import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'app_exceptions.dart';

/// 错误处理拦截器
class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    // error统一处理
    AppException appException = AppException.create(err);
    // 错误提示
    debugPrint('DioError===: ${appException.toString()}');
    if (err.error is SocketException) {
      showTip("网络请求失败");
    } else if (err.type == DioErrorType.connectTimeout) {
      showTip("请求超时，请重试");
    }
    err.error = appException;
    return super.onError(err, handler);
  }

  showTip(String tip) => Future.delayed(Duration(milliseconds: 300)).then((value) => toastMsg(tip));
}
