
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

  // MediaQuery passthrough
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Safe-area padding (status bar / notches).
  EdgeInsets get safePadding => mediaQuery.padding;

  /// Current locale.
  Locale get locale => Localizations.localeOf(this);

  /// Current text direction.
  TextDirection get textDirection => Directionality.of(this);

  /// Current screen orientation.
  Orientation get orientation => mediaQuery.orientation;

  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  /// Logical pixels per physical pixel.
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Current text scaling.
  TextScaler get textScaler => mediaQuery.textScaler;

  /// Dismisses the keyboard if it is open.
  void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
