/// Image helpers: base64 encoding and color filters.
library;

import 'dart:async';
import 'dart:convert';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Extensions on [Image] for encoding and filtering.
extension ImageExtensions on Image {
  /// Encodes the resolved image as a base64 PNG string.
  ///
  /// Completes with an error if the image fails to load or encode. The stream
  /// listener is removed once the image resolves.
  Future<String> toBase64() {
    final completer = Completer<String>();
    final stream = image.resolve(ImageConfiguration.empty);
    late final ImageStreamListener listener;
    listener = ImageStreamListener(
      (info, _) async {
        try {
          final byteData =
              await info.image.toByteData(format: ImageByteFormat.png);
          if (byteData == null) {
            completer
                .completeError(StateError('Failed to encode image to PNG'));
          } else {
            completer.complete(base64Encode(byteData.buffer.asUint8List()));
          }
        } catch (error, stackTrace) {
          if (!completer.isCompleted) {
            completer.completeError(error, stackTrace);
          }
        } finally {
          stream.removeListener(listener);
        }
      },
      onError: (error, stackTrace) {
        if (!completer.isCompleted) {
          completer.completeError(error, stackTrace);
        }
        stream.removeListener(listener);
      },
    );
    stream.addListener(listener);
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
