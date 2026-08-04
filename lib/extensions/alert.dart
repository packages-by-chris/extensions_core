import 'package:flutter/material.dart';

extension AlertExtension on BuildContext {
  /// Shows a [dialog] as an app dialog over the current page.
  void showCusDialog(Widget dialog) {
    showDialog(context: this, builder: (BuildContext context) => dialog);
  }
}
