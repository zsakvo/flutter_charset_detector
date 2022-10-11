import 'package:charset_detector/decoding_result.dart';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:charset_detector/charset_detector.dart';
import 'package:charset_detector/charset_detector_platform_interface.dart';
import 'package:charset_detector/charset_detector_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCharsetDetectorPlatform
    with MockPlatformInterfaceMixin
    implements CharsetDetectorPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<DecodingResult> autoDecode(Uint8List bytes) {
    return Future.value(DecodingResult.fromJson({}.cast<String, dynamic>()));
  }
}

void main() {
  final CharsetDetectorPlatform initialPlatform =
      CharsetDetectorPlatform.instance;

  test('$MethodChannelCharsetDetector is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCharsetDetector>());
  });

  test('getPlatformVersion', () async {
    CharsetDetector charsetDetectorPlugin = CharsetDetector();
    MockCharsetDetectorPlatform fakePlatform = MockCharsetDetectorPlatform();
    CharsetDetectorPlatform.instance = fakePlatform;

    expect(await charsetDetectorPlugin.getPlatformVersion(), '42');
  });
}
