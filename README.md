# charset_detector

Automatically detect and decode the charset (character encoding) of text bytes.

_这是一个 Fork 版本，原版本来自[这里](https://github.com/amake/flutter_charset_detector)_

相较于原版，此版本添加 MacOS 支持，并且重新整理文件目录。

<img width="300" src="https://user-images.githubusercontent.com/25399519/195046717-dfaad10b-0130-49b5-a982-e3d0230d2900.png">

_The example app; [details](./example/README.md)_
This plugin uses native libraries derived from the universal charset detection
libraries created by Mozilla.

- iOS: [UniversalDetector2](https://cocoapods.org/pods/UniversalDetector2), a
  thin wrapper around
  [uchardet](https://www.freedesktop.org/wiki/Software/uchardet/)
- Android:
  [juniversalchardet](https://github.com/albfernandez/juniversalchardet), a Java
  implementation of universalchardet

## Supported platforms

- Android 4.1 (SDK 16) and higher
- iOS 9 and higher

## Supported charsets

The detectable charsets differ by platform according to the capabilities of the
underlying library; for specifics see:

- [iOS](https://gitlab.freedesktop.org/uchardet/uchardet/-/blob/v0.0.7/README.md#supported-languagesencodings)
- [Android](https://github.com/albfernandez/juniversalchardet/blob/v2.4.0/README.md#encodings-that-can-be-detected)

## Usage

```dart
import 'package:flutter_charset_detector/flutter_charset_detector.dart';
Uint8List bytes = getBytes(); // bytes with unknown encoding
DecodingResult result = CharsetDetector.autoDecode(bytes);
print(result.charset); // => e.g. 'SHIFT_JIS'
print(result.string); // => e.g. '日本語'
```

## See also

- [charset_converter](https://pub.dev/packages/charset_converter) if you already
  know the name of the charset you want to encode/decode
