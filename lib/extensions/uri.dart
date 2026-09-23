/// URI helpers.
library;

/// Helpers on [Uri] for schemes, host, and query manipulation.
extension UriExtensions on Uri {
  /// Whether the scheme is `http`.
  bool get isHttp => scheme == 'http';

  /// Whether the scheme is `https`.
  bool get isHttps => scheme == 'https';

  /// Whether the scheme is `http` or `https`.
  bool get isWeb => isHttp || isHttps;

  /// Host with a leading `www.` stripped, or `null` when there is no host.
  String? get domain {
    if (host.isEmpty) return null;
    return host.startsWith('www.') ? host.substring(4) : host;
  }

  /// Last non-empty path segment (e.g. `42` for `/users/42`), or `null`.
  String? get pathLastSegment {
    final segments = pathSegments.where((s) => s.isNotEmpty).toList();
    return segments.isEmpty ? null : segments.last;
  }

  /// Returns a copy with the query parameter [name] set to [value].
  ///
  /// Existing values for that name are replaced.
  Uri withQueryParam(String name, String value) =>
      replace(queryParameters: {...queryParameters, name: value});

  /// Returns a copy without the given query parameter names.
  Uri withoutQueryParams(Iterable<String> names) {
    final excluded = names.toSet();
    final remaining = {
      for (final entry in queryParameters.entries)
        if (!excluded.contains(entry.key)) entry.key: entry.value,
    };
    if (remaining.isEmpty) {
      return Uri(
        scheme: scheme,
        userInfo: userInfo,
        host: host,
        port: port,
        path: path,
        fragment: fragment.isEmpty ? null : fragment,
      );
    }
    return replace(queryParameters: remaining);
  }
}
