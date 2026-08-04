
import 'package:flutter/material.dart';

extension IconExtensions on Icon {
  /// Creates a new Icon with a different color.
  Icon withColor(Color color) {
    return Icon(icon, color: color, size: size, semanticLabel: semanticLabel);
  }

  /// Creates a new Icon with a different size.
  Icon withSize(double size) {
    return Icon(icon, color: color, size: size, semanticLabel: semanticLabel);
  }
}
