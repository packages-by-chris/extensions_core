
import 'dart:io';
import 'dart:math';

extension FileExtensions on File {
  /// Gets the file size in bytes.
  int get sizeBytes => lengthSync();

  /// Gets the file size as a formatted string (e.g., "1.2 MB").
  String sizeFormatted() {
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    if (sizeBytes <= 0) return '0 B';
    var i = (log(sizeBytes) / log(1024)).floor().clamp(0, suffixes.length - 1);
    return '${(sizeBytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }
}
