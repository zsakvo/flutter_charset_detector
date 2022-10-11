import 'dart:typed_data';

import 'charset_detector_platform_interface.dart';
import 'decoding_result.dart';

class CharsetDetector {
  Future<String?> getPlatformVersion() {
    return CharsetDetectorPlatform.instance.getPlatformVersion();
  }

  static Future<DecodingResult> autoDecode(Uint8List bytes) =>
      CharsetDetectorPlatform.instance.autoDecode(bytes);
}
