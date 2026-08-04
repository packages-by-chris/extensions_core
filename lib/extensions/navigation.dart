import 'package:flutter/material.dart';

PageRouteBuilder _fadeTransition(Widget screen) => PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    });

extension NavigationExtension on BuildContext {
  Future navigateTo({required Widget screen, state, bool fade = false}) =>
      Navigator.push(
          this,
          fade
              ? _fadeTransition(screen)
              : MaterialPageRoute(builder: (_) => screen));

  Future<Null> navigateAndRestore(
          {required Widget screen, onBack, bool fade = false}) =>
      Navigator.of(this)
          .push(fade
              ? _fadeTransition(screen)
              : MaterialPageRoute(builder: (_) => screen))
          .then((val) {});

  Future navigateToReplace({required Widget screen}) =>
      Navigator.pushReplacement(
          this, MaterialPageRoute(builder: (_) => screen));

  Future navigateAndRemoveUntil({required Widget screen, bool fade = false}) =>
      Navigator.of(this).pushAndRemoveUntil(
          fade
              ? _fadeTransition(screen)
              : MaterialPageRoute(builder: (_) => screen),
          (Route<dynamic> route) => false);

  void navigateBack() => Navigator.pop(this);

  /// Navigate to a new screen
  Future<T?> pushScreen<T>(Widget screen) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  /// Replace the current screen
  Future<T?> replaceScreen<T>(Widget screen) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  /// Pop until a specific route name
  void popUntilRoute(String routeName) {
    Navigator.popUntil(this, ModalRoute.withName(routeName));
  }

  /// Clear the entire navigation stack and show a new screen
  void clearStackAndShow(Widget screen) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

  /// Push screen with fade transition
  Future<T?> pushWithFade<T>(Widget screen) {
    return Navigator.push<T>(
      this,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  /// Push screen sliding in from the right.
  Future<T?> pushWithSlide<T>(Widget screen) {
    return Navigator.push<T>(
      this,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offset =
              Tween(begin: const Offset(1, 0), end: Offset.zero).animate(animation);
          return SlideTransition(position: offset, child: child);
        },
      ),
    );
  }

  /// Whether the navigator can pop.
  bool get canPop => Navigator.of(this).canPop();

  /// Pops if possible; otherwise does nothing.
  void maybePop() => Navigator.of(this).maybePop();

  /// Pops the current route with a [result].
  void popWithResult<T>(T result) => Navigator.of(this).pop(result);

  /// Pops until the first route on the stack.
  void popToFirst() => Navigator.popUntil(this, (route) => route.isFirst);

  /// Name of the current route, or `null` if unnamed.
  String? get currentRouteName => ModalRoute.of(this)?.settings.name;

  /// Shows a modal bottom sheet.
  Future<T?> showSheet<T>(Widget child, {bool isScrollControlled = false}) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      builder: (_) => child,
    );
  }

  /// Shows a material [AlertDialog] with convenience params.
  Future<T?> showAppDialog<T>({
    required Widget content,
    String? title,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (_) => AlertDialog(
        title: title == null ? null : Text(title),
        content: content,
        actions: actions,
      ),
    );
  }
}
