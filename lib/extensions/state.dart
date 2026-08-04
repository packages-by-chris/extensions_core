import 'package:flutter/widgets.dart';

extension StateExtensions<T extends StatefulWidget> on State<T> {
  /// Calls `setState` only if the widget is still mounted.
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(fn);
    }
  }
}
