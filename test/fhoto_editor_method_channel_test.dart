import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fhoto_editor/fhoto_editor_method_channel.dart';

void main() {
  MethodChannelFhotoEditor platform = MethodChannelFhotoEditor();
  const MethodChannel channel = MethodChannel('fhoto_editor');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
