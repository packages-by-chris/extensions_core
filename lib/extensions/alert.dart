/// Dialog helpers on [BuildContext].
library;

import 'package:flutter/material.dart';

/// Dialog shortcuts for [BuildContext].
extension AlertExtension on BuildContext {
  /// Shows a [dialog] as an app dialog over the current page.
  void showCusDialog(Widget dialog) {
    showDialog(context: this, builder: (BuildContext context) => dialog);
  }
}
