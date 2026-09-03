/// EdgeInsets helpers.
library;

import 'package:flutter/widgets.dart';

/// [EdgeInsets] has no `copyWith` in Flutter, so we add one.
extension EdgeInsetsExtensions on EdgeInsets {
  /// Returns a copy with only the given fields overridden.
  EdgeInsets copyWith({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }
}
