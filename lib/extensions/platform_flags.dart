/// OS detection flags with platform-specific implementations.
library;

export 'platform_flags_io.dart'
    if (dart.library.js_interop) 'platform_flags_stub.dart';
