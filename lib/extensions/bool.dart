/// Helpers on [bool].
library;

/// Extensions on [bool] for conversions.
extension BoolExtensions on bool {
  /// 1 when true, 0 when false.
  int toInt() => this ? 1 : 0;

  /// The opposite value.
  bool toggle() => !this;

  /// A human-readable yes/no pair.
  String toYesNo({String yes = 'Yes', String no = 'No'}) => this ? yes : no;
}
