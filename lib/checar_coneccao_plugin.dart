
import 'dart:async';

import 'package:flutter/services.dart';

class ChecarConeccaoPlugin {
  static const MethodChannel _channel =
      const MethodChannel('checar_coneccao_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
