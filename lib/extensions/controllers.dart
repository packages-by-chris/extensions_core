/// Extensions on Flutter controllers (text selection, scrolling).
library;

import 'package:flutter/widgets.dart';

/// Helpers on [TextEditingController] for selection and cursor movement.
extension TextEditingControllerExtensions on TextEditingController {
  /// Selects all of the text.
  void selectAll() {
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }

  /// Moves the cursor to the end of the text.
  void cursorToEnd() {
    selection = TextSelection.collapsed(offset: text.length);
  }
}

/// Helpers on [ScrollController] for jumping to the top or bottom.
extension ScrollControllerExtensions on ScrollController {
  /// Animated scroll to the top.
  Future<void> scrollToTop({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) =>
      animateTo(0.0, duration: duration, curve: curve);

  /// Animated scroll to the bottom.
  Future<void> scrollToBottom({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) =>
      animateTo(position.maxScrollExtent, duration: duration, curve: curve);

  /// Jumps instantly to the top.
  void jumpToTop() => jumpTo(0.0);

  /// Jumps instantly to the bottom.
  void jumpToBottom() => jumpTo(position.maxScrollExtent);
}
