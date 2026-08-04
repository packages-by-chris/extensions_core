
import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  // MediaQuery Extensions
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  Size get screenSize => MediaQuery.of(this).size;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  // Theme Extensions
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get accentColor => Theme.of(this).colorScheme.secondary;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  IconThemeData get iconTheme => Theme.of(this).iconTheme;

  // Device Type Extensions
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;
}
