/// OS flags read from `dart:io` (native platforms).
library;

import 'dart:io';

import 'package:flutter/foundation.dart';

/// Whether the app is running in a browser (always false here).
bool get isWeb => kIsWeb;

/// Whether the OS is Android.
bool get isAndroid => !kIsWeb && Platform.isAndroid;

/// Whether the OS is iOS.
bool get isIOS => !kIsWeb && Platform.isIOS;

/// Whether the OS is macOS.
bool get isMacOS => !kIsWeb && Platform.isMacOS;

/// Whether the OS is Windows.
bool get isWindows => !kIsWeb && Platform.isWindows;

/// Whether the OS is Linux.
bool get isLinux => !kIsWeb && Platform.isLinux;

/// Whether the OS is Fuchsia.
bool get isFuchsia => !kIsWeb && Platform.isFuchsia;
