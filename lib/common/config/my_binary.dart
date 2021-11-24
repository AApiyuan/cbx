import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class MyWidgetsFlutterBinding extends WidgetsFlutterBinding with MyServicesBinding {
  static WidgetsBinding? ensureInitialized() {
    if (WidgetsBinding.instance == null) {
      MyWidgetsFlutterBinding();
    }
    return WidgetsBinding.instance;
  }
}

mixin MyServicesBinding on BindingBase, ServicesBinding {
  @override
  BinaryMessenger createBinaryMessenger() {
    return TestDefaultBinaryMessenger(super.createBinaryMessenger());
  }
}

class TestDefaultBinaryMessenger extends BinaryMessenger {
  final BinaryMessenger origin;

  TestDefaultBinaryMessenger(this.origin);

  final Map<String, MessageHandler> _outboundHandlers = <String, MessageHandler>{};

  @override
  Future<ByteData?> send(String channel, ByteData? message) {
    final Completer<ByteData?> completer = Completer<ByteData?>();

    final Future<ByteData?>? resultFuture;
    final MessageHandler? handler = _outboundHandlers[channel];
    if (handler != null) {
      resultFuture = handler(message);
      return resultFuture!;
    }

    ui.PlatformDispatcher.instance.sendPlatformMessage(channel, message, (ByteData? reply) {
      try {
        completer.complete(reply);
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'services library',
          context: ErrorDescription('during a platform message response callback'),
        ));
      }
    });
    return completer.future;
  }

  @override
  void setMessageHandler(String channel, MessageHandler? handler) {
    if (handler != null && handler.toString().contains("_textInputHanlde")) {
      _outboundHandlers[channel] = handler;
      return;
    }
    if (handler == null) {
      ui.channelBuffers.clearListener(channel);
    } else {
      ui.channelBuffers.setListener(channel, (ByteData? data, ui.PlatformMessageResponseCallback callback) async {
        ByteData? response;
        try {
          response = await handler(data);
        } catch (exception, stack) {
          FlutterError.reportError(FlutterErrorDetails(
            exception: exception,
            stack: stack,
            library: 'services library',
            context: ErrorDescription('during a platform message callback'),
          ));
        } finally {
          callback(response);
        }
      });
    }
  }

  @override
  Future<void> handlePlatformMessage(
    String channel,
    ByteData? message,
    ui.PlatformMessageResponseCallback? callback,
  ) async {
    ui.channelBuffers.push(channel, message, (ByteData? data) {
      if (callback != null) callback(data);
    });
  }
}
