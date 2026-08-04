
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

  String get _ext {
    final dot = path.lastIndexOf('.');
    if (dot == -1 || dot == path.length - 1) return '';
    return path.substring(dot + 1).toLowerCase();
  }

  /// Whether the file extension is a common image type.
  bool get isImage => const ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'heic', 'svg'].contains(_ext);

  /// Whether the file extension is a common video type.
  bool get isVideo => const ['mp4', 'mkv', 'avi', 'mov', 'webm', 'm4v'].contains(_ext);

  /// Whether the file extension is a common audio type.
  bool get isAudio => const ['mp3', 'wav', 'aac', 'flac', 'ogg', 'm4a'].contains(_ext);

  /// File size in megabytes.
  double get sizeInMB => sizeBytes / (1024 * 1024);

  /// Reads the file as UTF-8, or returns `null` on error.
  Future<String?> readAsStringSafe() async {
    try {
      return await readAsString();
    } catch (_) {
      return null;
    }
  }
}
