/// Widget modifiers: padding, gestures, transforms, constraints.
library;

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Chainable modifiers on [Widget].
extension WidgetExtension on Widget {
  /// Wrap widget with padding
  Widget padding([EdgeInsetsGeometry value = const EdgeInsets.all(16)]) {
    return Padding(
      padding: value,
      child: this,
    );
  }

  /// Wrap widget with margin (visual space, implemented as padding).
  Widget margin([EdgeInsetsGeometry value = const EdgeInsets.all(16)]) {
    return Padding(
      padding: value,
      child: this,
    );
  }

  /// Fill with [color] behind the widget.
  Widget background(Color color) => ColoredBox(color: color, child: this);

  /// Add a rounded border around the widget.
  Widget border({
    required BorderRadius borderRadius,
    Color color = Colors.black,
    double width = 1.0,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: color, width: width),
      ),
      child: this,
    );
  }

  /// Show a tooltip on long press.
  Widget tooltip(String message) => Tooltip(message: message, child: this);

  /// Center widget
  Widget get center => Center(child: this);

  /// Expand widget
  Widget get expanded => Expanded(child: this);

  /// Flexible widget
  Widget flexible({int flex = 1}) => Flexible(flex: flex, child: this);

  /// Add gesture detector
  Widget onTap(VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: this,
    );
  }

  /// Add long-press gesture detector
  Widget onLongPress(VoidCallback action) {
    return GestureDetector(
      onLongPress: action,
      child: this,
    );
  }

  /// Add double-tap gesture detector
  Widget onDoubleTap(VoidCallback action) {
    return GestureDetector(
      onDoubleTap: action,
      child: this,
    );
  }

  /// Add tap handler with a material ripple effect.
  Widget inkWell(VoidCallback action, {BorderRadius? borderRadius}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action,
        borderRadius: borderRadius,
        child: this,
      ),
    );
  }

  /// Show/hide without losing state.
  Widget visible(bool visible) => Visibility(visible: visible, child: this);

  /// Wrap in a [SafeArea].
  Widget safeArea() => SafeArea(child: this);

  /// Gaussian blur behind/over the widget.
  Widget blur(double sigma) => ImageFiltered(
        imageFilter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: this,
      );

  /// Rotate by [turns] (1 = full 360 deg).
  Widget rotated(double turns) =>
      Transform.rotate(angle: turns * 2 * math.pi, child: this);

  /// Scale the widget.
  Widget scaled(double scale) => Transform.scale(scale: scale, child: this);

  /// Constrain size within the given bounds.
  Widget constrained({
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: minHeight ?? 0,
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: this,
    );
  }

  /// Force a width/height ratio.
  Widget aspectRatio(double ratio) =>
      AspectRatio(aspectRatio: ratio, child: this);

  /// Set the width (height unconstrained).
  Widget width(double w) => SizedBox(width: w, child: this);

  /// Set the height (width unconstrained).
  Widget height(double h) => SizedBox(height: h, child: this);

  /// Align widget
  Widget align([AlignmentGeometry alignment = Alignment.center]) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  /// Wrap widget with SizedBox
  Widget size({double? width, double? height}) {
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }

  /// Add opacity to widget
  Widget opacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }

  /// Clip widget with circular border radius
  Widget circular([double radius = 8.0]) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  /// Add card elevation
  Widget elevated([double elevation = 4.0]) {
    return Material(
      elevation: elevation,
      child: this,
    );
  }
}
