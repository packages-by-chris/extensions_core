/// Runtime and target platform detection (web-safe).
library;

import 'package:flutter/material.dart';

import 'platform_flags.dart' as flags;

/// Platform extensions
extension PlatformExt on BuildContext {
  TargetPlatform get _targetPlatform => Theme.of(this).platform;

  /// Platform info
  PlatformInfo get platform => PlatformInfo(
        isAndroid: flags.isAndroid,
        isWeb: flags.isWeb,
        isMacOS: flags.isMacOS,
        isWindows: flags.isWindows,
        isFuchsia: flags.isFuchsia,
        isIOS: flags.isIOS,
        isLinux: flags.isLinux,
      );

  /// Target platform info
  TargetPlatformInfo get targetPlatform => TargetPlatformInfo(
        isAndroid: _targetPlatform == TargetPlatform.android,
        isFuchsia: _targetPlatform == TargetPlatform.fuchsia,
        isIOS: _targetPlatform == TargetPlatform.iOS,
        isLinux: _targetPlatform == TargetPlatform.linux,
        isMacOS: _targetPlatform == TargetPlatform.macOS,
        isWindows: _targetPlatform == TargetPlatform.windows,
      );
}

/// Flags for the platform the app is actually running on.
class PlatformInfo {
  /// Creates a [PlatformInfo] with the given flags.
  const PlatformInfo({
    required this.isAndroid,
    required this.isMacOS,
    required this.isWindows,
    required this.isFuchsia,
    required this.isWeb,
    required this.isIOS,
    required this.isLinux,
  });

  /// Indicates wheter the platform is android
  final bool isAndroid;

  /// Indicates wheter the platform is macOS
  final bool isMacOS;

  /// Indicates wheter the platform is windows
  final bool isWindows;

  /// Indicates wheter the platform is fuchsia
  final bool isFuchsia;

  /// Indicates wheter the platform is web
  final bool isWeb;

  /// Indicates wheter the platform is ios
  final bool isIOS;

  /// Indicates wheter the platform is linux
  final bool isLinux;
}

/// Flags for the [TargetPlatform] resolved from the widget tree theme.
class TargetPlatformInfo {
  /// Creates a [TargetPlatformInfo] with the given flags.
  const TargetPlatformInfo({
    required this.isAndroid,
    required this.isFuchsia,
    required this.isIOS,
    required this.isLinux,
    required this.isMacOS,
    required this.isWindows,
  });

  /// Indicates wheter the target platform is android
  final bool isAndroid;

  /// Indicates wheter the target platform is fuchsia
  final bool isFuchsia;

  /// Indicates wheter the target platform is iOS
  final bool isIOS;

  /// Indicates wheter the target platform is linux
  final bool isLinux;

  /// Indicates wheter the target platform is macOS
  final bool isMacOS;

  /// Indicates wheter the target platform is windows
  final bool isWindows;
}
