import 'package:flutter/services.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/config/config.dart';

import 'http.dart';


class Proxy {
// 是否启用代理
  static bool PROXY_ENABLE = Config.isDebug;

  static Proxy? _proxy;

  final String ip;
  final String port;

  Proxy(this.ip, this.port);

  static Proxy? get proxy => _proxy;

  static void init() {
    if (_proxy == null) {
      MethodChannel(ChannelConfig.flutterToNative)
          .invokeMethod(ChannelConfig.methodProxyConfig)
          .then((value) {
        print("flutter_tag===============$value");
        if (_checkNull(value)) return;
        _proxy = Proxy(value['ip'], value['port']);
        print("flutter_tag===============$_proxy");
        Http().initProxy();
      }, onError: (e) => print("flutter_tag=======onError=======Proxy.init()"));
    }
  }

  static bool _checkNull(Map? value) {
    return value == null || value['ip'] == null || value['port'] == null;
  }
}
