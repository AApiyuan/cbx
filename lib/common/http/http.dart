import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:haidai_flutter_module/common/http/dio_log_interceptor.dart';
import 'package:haidai_flutter_module/common/http/proxy.dart';

import 'cache.dart';
import 'error_interceptor.dart';
import 'global.dart';

class Http {
  ///超时时间
  static const int CONNECT_TIMEOUT = 15000;
  static const int RECEIVE_TIMEOUT = 15000;

  static Http _instance = Http._internal();

  factory Http() => _instance;

  static bool setProxy = false;

  Dio dio = new Dio(BaseOptions(
    connectTimeout: CONNECT_TIMEOUT,
    // 响应流上前后两次接受到数据的间隔，单位为毫秒。
    receiveTimeout: RECEIVE_TIMEOUT,
    // Http请求头.
    headers: {"Content-Encoding": "gzip"},
  ));
  CancelToken _cancelToken = new CancelToken();

  Http._internal() {
    dio.httpClientAdapter = DefaultHttpClientAdapter()
      ..onHttpClientCreate = (HttpClient client) {
        client.idleTimeout = Duration(seconds: 15);
      };
    dio.interceptors.add(new DioLogInterceptor());
    // dio.interceptors.add(InterceptorsWrapper(
    //     onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    //   print(
    //       "\n================================= 请求数据 =================================");
    //   print("method = ${options.method.toString()}");
    //   print("url = ${options.uri.toString()}");
    //   print("headers = ${options.headers}");
    //   print("params = ${options.queryParameters}");
    //   print("data = ${jsonEncode(options.data)}");
    //   handler.next(options);
    // }, onResponse: (Response response, ResponseInterceptorHandler handler) {
    //   print(
    //       "\n================================= 响应数据开始 =================================");
    //   print("code = ${response.statusCode}");
    //   print("data = ${response.data}");
    //   print(
    //       "================================= 响应数据结束 =================================\n");
    //   handler.next(response);
    // }, onError: (DioError e, ErrorInterceptorHandler handler) {
    //   print(
    //       "\n=================================错误响应数据 =================================");
    //   print("type = ${e.type}");
    //   print("message = ${e.message}");
    //   print("\n");
    //   handler.next(e);
    // }));

    // 添加拦截器
    dio.interceptors.add(ErrorInterceptor());
    // 加内存缓存
    // dio.interceptors.add(NetCacheInterceptor());
    // if (Global.retryEnable) {
    //   dio.interceptors.add(
    //     RetryOnConnectionChangeInterceptor(
    //       requestRetrier: DioConnectivityRequestRetrier(
    //         dio: dio,
    //         connectivity: Connectivity(),
    //       ),
    //     ),
    //   );
    // }
    // dio.interceptors.add(LogInterceptor());

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    initProxy();
  }

  initProxy() {
    if (!setProxy && Proxy.PROXY_ENABLE && Proxy.proxy != null) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.findProxy = (uri) {
          return "PROXY ${Proxy.proxy?.ip}:${Proxy.proxy?.port}";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
      setProxy = true;
    }
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init(
      {String? baseUrl,
      int connectTimeout = CONNECT_TIMEOUT,
      int receiveTimeout = RECEIVE_TIMEOUT,
      List<Interceptor>? interceptors}) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  /// 设置headers
  void setHeaders(Map<String, dynamic> map) {
    dio.options.headers.addAll(map);
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }

  /// 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers;
    String? accessToken = Global.accessToken;
    if (accessToken != null) {
      headers = {"Authorization": '$accessToken', "requestType": 'HTKD_FLUTTER'};
    }
    return headers;
  }

  /// restful get 操作
  Future get(
    String path, {
    required String baseUrl,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    String? cacheKey,
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    dio.options.baseUrl = baseUrl;
    requestOptions = requestOptions.copyWith(extra: {
      "refresh": refresh,
      "noCache": noCache,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    Response response;
    response =
        await dio.get(path, queryParameters: params, options: requestOptions, cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful post 操作
  Future post(
    String path, {
    required String baseUrl,
    Map<String, dynamic>? params,
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    //requestOptions.baseUrl = baseUrl;
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    dio.options.baseUrl = baseUrl;
    var response = await dio.post(path,
        data: data, queryParameters: params, options: requestOptions, cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful put 操作
  Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.put(path,
        data: data, queryParameters: params, options: requestOptions, cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful patch 操作
  Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.patch(path,
        data: data, queryParameters: params, options: requestOptions, cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful delete 操作
  Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.delete(path,
        data: data, queryParameters: params, options: requestOptions, cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.post(path,
        data: FormData.fromMap(params ?? <String, dynamic>{}),
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }
}
