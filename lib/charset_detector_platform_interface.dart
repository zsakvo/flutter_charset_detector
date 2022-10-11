import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'charset_detector_method_channel.dart';
import 'decoding_result.dart';

abstract class CharsetDetectorPlatform extends PlatformInterface {
  /// Constructs a CharsetDetectorPlatform.
  CharsetDetectorPlatform() : super(token: _token);

  static final Object _token = Object();

  static CharsetDetectorPlatform _instance = MethodChannelCharsetDetector();

  /// The default instance of [CharsetDetectorPlatform] to use.
  ///
  /// Defaults to [MethodChannelCharsetDetector].
  static CharsetDetectorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CharsetDetectorPlatform] when
  /// they register themselves.
  static set instance(CharsetDetectorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<DecodingResult> autoDecode(Uint8List bytes) =>
      throw UnimplementedError('autoDecode() has not been implemented.');
}
