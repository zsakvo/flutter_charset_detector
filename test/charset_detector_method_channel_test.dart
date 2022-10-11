import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:charset_detector/charset_detector_method_channel.dart';

void main() {
  MethodChannelCharsetDetector platform = MethodChannelCharsetDetector();
  const MethodChannel channel = MethodChannel('charset_detector');

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
