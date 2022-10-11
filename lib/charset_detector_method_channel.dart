import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'charset_detector_platform_interface.dart';
import 'decoding_result.dart';

/// An implementation of [CharsetDetectorPlatform] that uses method channels.
class MethodChannelCharsetDetector extends CharsetDetectorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('charset_detector');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<DecodingResult> autoDecode(Uint8List bytes) async {
    final result = await methodChannel
        .invokeMethod<Map>('autoDecode', {'data': bytes}) as Map;
    return DecodingResult.fromJson(result.cast<String, dynamic>());
  }
}
