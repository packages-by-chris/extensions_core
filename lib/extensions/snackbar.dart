/// SnackBar helpers on [BuildContext].
library;

import 'package:flutter/material.dart';

/// SnackBar shortcuts for [BuildContext].
extension SnackBarExtension on BuildContext {
  /// Shows a [SnackBar] with [message] via the nearest [ScaffoldMessenger].
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      String message) {
    return ScaffoldMessenger.of(this)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  /// Hides the currently displayed [SnackBar] (if any) on the nearest
  /// [ScaffoldMessenger].
  void removeSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }
}
