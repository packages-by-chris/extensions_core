/// OS flags for the web (compiles where `dart:io` is unavailable).
library;

/// Whether the app is running in a browser (always true here).
bool get isWeb => true;

/// Whether the OS is Android (never on the web).
bool get isAndroid => false;

/// Whether the OS is iOS (never on the web).
bool get isIOS => false;

/// Whether the OS is macOS (never on the web).
bool get isMacOS => false;

/// Whether the OS is Windows (never on the web).
bool get isWindows => false;

/// Whether the OS is Linux (never on the web).
bool get isLinux => false;

/// Whether the OS is Fuchsia (never on the web).
bool get isFuchsia => false;
