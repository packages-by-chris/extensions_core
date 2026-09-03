/// Screen, theme, and device helpers on [BuildContext].
library;

import 'package:flutter/material.dart';

/// Convenience getters for [MediaQuery], [Theme], and device breakpoints.
extension BuildContextExtensions on BuildContext {
  /// Screen width in logical pixels.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Screen height in logical pixels.
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Screen size in logical pixels.
  Size get screenSize => MediaQuery.of(this).size;

  /// Insets obscured by system UI (e.g. the keyboard).
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// Padding obscured by system UI, unaffected by the keyboard.
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  /// The current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// The theme's [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// The theme's [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// The theme's primary color.
  Color get primaryColor => Theme.of(this).primaryColor;

  /// The color scheme's secondary (accent) color.
  Color get accentColor => Theme.of(this).colorScheme.secondary;

  /// The [Scaffold] background color from the theme.
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  /// The theme's [IconThemeData].
  IconThemeData get iconTheme => Theme.of(this).iconTheme;

  /// Whether the screen width is below 600 logical pixels.
  bool get isMobile => screenWidth < 600;

  /// Whether the screen width is 600-1199 logical pixels.
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;

  /// Whether the screen width is 1200 logical pixels or more.
  bool get isDesktop => screenWidth >= 1200;

  /// The full [MediaQueryData].
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Safe-area padding (status bar / notches).
  EdgeInsets get safePadding => mediaQuery.padding;

  /// Current locale.
  Locale get locale => Localizations.localeOf(this);

  /// Current text direction.
  TextDirection get textDirection => Directionality.of(this);

  /// Current screen orientation.
  Orientation get orientation => mediaQuery.orientation;

  /// Whether the orientation is portrait.
  bool get isPortrait => orientation == Orientation.portrait;

  /// Whether the orientation is landscape.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Logical pixels per physical pixel.
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Current text scaling.
  TextScaler get textScaler => mediaQuery.textScaler;

  /// Dismisses the keyboard if it is open.
  void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
