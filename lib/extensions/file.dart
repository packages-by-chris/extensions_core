/// File helpers (available only where `dart:io` exists — not on the web).
library;

export 'file_io.dart' if (dart.library.js_interop) 'file_stub.dart';
