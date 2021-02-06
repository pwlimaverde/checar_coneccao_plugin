import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:checar_coneccao_plugin/checar_coneccao_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('checar_coneccao_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ChecarConeccaoPlugin.platformVersion, '42');
  });
}
