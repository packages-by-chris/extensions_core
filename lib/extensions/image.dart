
import 'dart:async';
import 'dart:convert';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension ImageExtensions on Image {
  /// Converts an image to a base64 string.
  Future<String> toBase64() async {
    final completer = Completer<String>();
    image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info, _) async {
        final byteData = await info.image.toByteData(format: ImageByteFormat.png);
        final buffer = byteData!.buffer.asUint8List();
        final base64 = base64Encode(buffer);
        completer.complete(base64);
      }),
    );
    return completer.future;
  }

  /// Applies a color filter to an image.
  Widget withFilter(ColorFilter colorFilter) {
    return ColorFiltered(
      colorFilter: colorFilter,
      child: this,
    );
  }
}
