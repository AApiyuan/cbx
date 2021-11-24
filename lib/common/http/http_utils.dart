import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import 'api_response.dart';
import 'cache.dart';
import 'http.dart';

class HttpUtils {
  static void init(
      {String? baseUrl,
      int connectTimeout = Http.CONNECT_TIMEOUT,
      int receiveTimeout = Http.RECEIVE_TIMEOUT,
      List<Interceptor>? interceptors}) {
    Http().init(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        interceptors: interceptors);
  }

  static void setHeaders(Map<String, dynamic> map) {
    map['requestType'] = "HTKD_FLUTTER";
    Http().setHeaders(map);
  }

  static void cancelRequests({CancelToken? token}) {
    Http().cancelRequests(token: token);
  }

  static Future get(
    String path, {
    required String baseUrl,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    String? cacheKey,
    bool cacheDisk = false,
    bool showLoading = false,
  }) async {
    print(params.toString());
    String tag = path + DateTime.now().toString();
    if (showLoading) {
      // LoadingUtil.show(tag);
      EasyLoading.instance
      ..userInteractions = false
        ..displayDuration = const Duration(milliseconds: 2000)
        ..indicatorType = EasyLoadingIndicatorType.ring
        ..loadingStyle = EasyLoadingStyle.custom
        ..backgroundColor = Color.fromRGBO(0, 0, 0, 0.6)
        ..textColor = Colors.blue
        ..maskColor = Colors.blue
        ..indicatorColor = Colors.blue
        ..contentPadding = EdgeInsets.fromLTRB(75.w, 50.w, 75.w, 50.w)
        ..indicatorWidget = pImage("images/loading.webp", 75.w, 75.w)
        ..radius = 10.w
        ..textStyle =
            TextStyle(color: Color(ColorConfig.color_ffffff), fontSize: 28.w)
        ..indicatorSize = 50.w;
      EasyLoading.show(status: "加载中");
    }
    return await Http()
        .get(
      path,
      params: params,
      baseUrl: baseUrl,
      options: options,
      cancelToken: cancelToken,
      refresh: refresh,
      noCache: noCache,
      cacheKey: cacheKey,
    )
        .then((value) {
      ApiResponse result = ApiResponse.fromJson(value);
      if (result.code == 2000000) {
        return result.data;
      } else {
        ApiResponse.error(result.msg!);
        return Future.delayed(Duration(milliseconds: 1000))
            .then((value) => Future.error(result.msg!));
      }
    }, onError: (e) {
      ApiResponse.error("$e");
      return Future.error(e);
    }).whenComplete(() => EasyLoading.dismiss());
    /*print(response.toString());
    var result = ApiResponse.fromJson(response);
    if (result.code == 2000000) {
      return result.data;
    } else {
      return Future(() => throw ApiResponse.error(result.msg));
    }*/
  }

  static Future post(
    String path, {
    data,
    required String baseUrl,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool showLoading = false,
  }) async {
    String tag = path + DateTime.now().toString();
    if (showLoading) {
      EasyLoading.instance
        ..userInteractions = false
        ..displayDuration = const Duration(milliseconds: 2000)
        ..indicatorType = EasyLoadingIndicatorType.ring
        ..loadingStyle = EasyLoadingStyle.custom
        ..backgroundColor = Color.fromRGBO(0, 0, 0, 0.6)
        ..textColor = Colors.blue
        ..maskColor = Colors.blue
        ..indicatorColor = Colors.blue
        ..contentPadding = EdgeInsets.fromLTRB(75.w, 50.w, 75.w, 50.w)
        ..indicatorWidget = pImage("images/loading.webp", 75.w, 75.w)
        ..radius = 10.w
        ..textStyle =
            TextStyle(color: Color(ColorConfig.color_ffffff), fontSize: 28.w)
        ..indicatorSize = 50.w;
      EasyLoading.show();
    }
    return await Http()
        .post(
      path,
      baseUrl: baseUrl,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    )
        .then((value) {
      var result = ApiResponse.fromJson(value);
      if (result.code == 2000000) {
        return result.data;
      } else {
        ApiResponse.error(result.msg!);
        return Future.delayed(Duration(milliseconds: 1000))
            .then((value) => Future.error(result.msg!));
      }
    }, onError: (e) {
      ApiResponse.error("$e");
      return Future.error(e);
    }).whenComplete(() => EasyLoading.dismiss());
    // print(jsonDecode(data));
    /*var result = ApiResponse.fromJson(response);
    if (result.code == 2000000) {
      return result.data;
    } else {
      return Future(() => throw ApiResponse.error(result.msg));
    }*/
  }

  static Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var response = await Http().put(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
    var result = ApiResponse.fromJson(response);
    if (result.code == 2000000) {
      return result.data;
    } else {
      ApiResponse.error(result.msg!);
    }
  }

  static Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var response = await Http().patch(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
    var result = ApiResponse.fromJson(response);
    if (result.code == 2000000) {
      return result.data;
    } else {
      ApiResponse.error(result.msg!);
    }
  }

  static Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var response = await Http().delete(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
    var result = ApiResponse.fromJson(response);
    if (result.code == 2000000) {
      return result.data;
    } else {
      ApiResponse.error(result.msg!);
    }
  }

  static Future postForm(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var response = await Http().postForm(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
    var result = ApiResponse.fromJson(response);
    if (result.code == 2000000) {
      return result.data;
    } else {
      ApiResponse.error(result.msg!);
    }
  }
}
