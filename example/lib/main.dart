import 'dart:convert';

import 'package:charset_detector/decoding_result.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:charset_detector/charset_detector.dart';

const _kAssetName = 'assets/sjis-example.txt';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Charset Detector Example'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: const [
            _DefaultCharsetCard(_kAssetName),
            _DefaultCharsetReplacingCard(_kAssetName),
            _DetectedCharsetCard(_kAssetName),
          ],
        ),
      ),
    );
  }
}

class _DefaultCharsetCard extends StatelessWidget {
  const _DefaultCharsetCard(this.asset, {Key? key}) : super(key: key);
  final String asset;
  @override
  Widget build(BuildContext context) {
    return _LoadedTextCard(
      title: 'Default Charset (UTF-8)',
      content: rootBundle.loadString(asset),
    );
  }
}

class _DefaultCharsetReplacingCard extends StatelessWidget {
  const _DefaultCharsetReplacingCard(this.asset, {Key? key}) : super(key: key);
  final String asset;
  @override
  Widget build(BuildContext context) {
    return _LoadedTextCard(
      title: 'UTF-8 (allow malformed)',
      content: _load(),
    );
  }

  Future<String> _load() async {
    final bytes = await rootBundle.load(asset);
    return utf8.decode(bytes.buffer.asUint8List(), allowMalformed: true);
  }
}

class _DetectedCharsetCard extends StatelessWidget {
  const _DetectedCharsetCard(this.asset, {Key? key}) : super(key: key);
  final String asset;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DecodingResult>(
      future: _load(),
      builder: (context, snapshot) {
        final charset = snapshot.data?.charset ?? '?';
        return _LoadedTextCard(
          title: 'Detected Charset: $charset',
          content: snapshot.data?.string,
        );
      },
    );
  }

  Future<DecodingResult> _load() async {
    final bytes = await rootBundle.load(asset);
    return CharsetDetector.autoDecode(bytes.buffer.asUint8List());
  }
}

class _LoadedTextCard extends StatelessWidget {
  const _LoadedTextCard({required this.title, required this.content, Key? key})
      : super(key: key);

  final String title;
  final FutureOr<String>? content;

  @override
  Widget build(BuildContext context) {
    return _TitleCard(
      title: title,
      child: FutureBuilder<String?>(
        future: Future.value(content),
        initialData: 'Loading...',
        builder: (context, snapshot) => Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.all(Radius.circular(2)),
          ),
          child: Text(snapshot.data?.trim() ?? snapshot.error.toString()),
        ),
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  const _TitleCard({required this.title, required this.child, Key? key})
      : super(key: key);

  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
