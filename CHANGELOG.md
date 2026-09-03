## 0.0.6

### Added

- `lib/extensions_core.dart` — primary library entry point (importing `package:extensions_core/extensions_core.dart` now works; the existing `extensions.dart` barrel is unchanged and still exported).

### Changed

- **Web and WASM support.** `dart:io` usage moved behind conditional imports:
  - `PlatformInfo` OS detection no longer imports `dart:io` directly — new `platform_flags.dart` with io/web implementations (`kIsWeb` + `Platform` on native, all-false-but-web on browsers).
  - `File` extensions moved to `file_io.dart`, exported only where `dart:io` exists — they remain unavailable on the web (documented in the README).
- pubspec now declares `repository` and `issue_tracker`, and `topics` (`dart`, `flutter`, `extensions`, `utilities`).
- Verified with pana: 160/160 points, 6/6 platforms supported, WASM-ready.

---

## 0.0.5

### Added

- `example/example.dart` — runnable demo showing common extensions (adds the pub.dev "package has an example" points).

### Changed

- Rewrote the `pubspec.yaml` description (previous one was too short, costing pub points).
- Added dartdoc comments across the whole public API: every library, extension, class, and member is now documented (262 → 100% coverage).
- Expanded `example/example.dart` to demonstrate extensions from every file in the package.
- **The package now compiles on the web (and is WASM-ready).** `dart:io` usages moved behind conditional imports: `platform.dart` OS detection uses `platform_flags.dart` (stub/web implementations), and `File` extensions moved to `file_io.dart`, exported only where `dart:io` exists. Added `lib/extensions_core.dart` as the primary entry point (the `extensions.dart` barrel still works).

### Removed

- Unusable `TextStyle` extension members that collided with instance fields of `TextStyle` and could never be called: `color()`, `letterSpacing()`, `wordSpacing()`, `backgroundColor()`, `fontFamily()`, `decorationThickness()`, and the no-op `align()`. Use `copyWith(color: …)` etc. instead.

### Tests

- No API changes; all 36 existing tests pass, `flutter analyze` and `dart format` clean, local pana score 160/160.

---

## 0.0.4

### Added

- New extension files:
  - `object.dart`: `let`, `also`, `run`, `isNull`, `isNotNull`
  - `duration.dart`: `inWeeks`, `format()`
  - `edge_insets.dart`: `EdgeInsets.copyWith()`
  - `form_validators.dart`: `requiredField`, `emailValidator`, `phoneValidator`, `minLengthValidator`, `maxLengthValidator`
- `String`: case conversion (`toCamelCase`, `toPascalCase`, `toSnakeCase`, `toKebabCase`), safe parsing (`toIntSafe`, `toDoubleSafe`, `toBool`), slicing (`before`, `after`, `between`, `replaceLast`, `countOccurrences`), `isNullOrEmpty` (nullable), `slugify`, `collapseWhitespace`, `initials`, `masked`, `isStrongPassword`, `containsSpecialCharacter`, `isAlphanumeric`, `isJson`, `onlyDigits`, `withoutDigits`
- `Number`/`int`: `isPositive`, `isZero`, `isDivisibleBy`, `percentageOf`, `formatBytes`, `isEven`, `isOdd`, `ordinal`, `toBinary`, `toOctal`, `toHex`
- `DateTime`: `isTomorrow`, `isSameDay/Month/Year`, `isBetween`, `isWeekend`, `isWeekday`, `isLeapYear`, `quarter`, `startOf/endOf` (day, week, month, year), `tomorrow`, `yesterday`, `copyWith`, `ageInYears`
- `Iterable`: `distinctBy`, `countWhere`, `containsAll`, `containsAny`, `zip`, `unzip`, `flatten`, `insertBetween`; `sum`, `min`, `max`, `average` on `Iterable<num>`
- `List`: `rotate`
- `Map`: `invert`, `getOrPut`, `merge`, `pick`, `omit`, `filterKeys`, `filterValues`, `keysOf`
- `Color`: `colorFromHex()`, `darken`, `lighten`, `inverse`, `complementary`, `hue`, `saturation`, `brightness`, `withBrightness`, `isTransparent`, `toMaterialColor`
- `BuildContext`: `mediaQuery`, `safePadding`, `locale`, `textDirection`, `orientation`, `isPortrait`, `isLandscape`, `devicePixelRatio`, `textScaler`, `hideKeyboard`
- `Widget`: `margin`, `background`, `border`, `tooltip`, `onLongPress`, `onDoubleTap`, `inkWell`, `visible`, `safeArea`, `blur`, `rotated`, `scaled`, `constrained`, `aspectRatio`, `width`, `height`
- `Navigation`: `canPop`, `maybePop`, `popWithResult`, `popToFirst`, `currentRouteName`, `pushWithSlide`, `showSheet`, `showAppDialog`
- `File`: `isImage`, `isVideo`, `isAudio`, `sizeInMB`, `readAsStringSafe`

### Changed

- Public types `PlatformInfo` / `TargetPlatformInfo` replace the private `_Platform` / `_TargetPlatform` (accessible from app code).
- Minimum Flutter raised to `>=3.27.0` for the modern wide-gamut `Color` API.
- Removed unused dev dependencies (`path_provider`, `mocktail`).

### Fixed

- `Color.toHex()` returned incorrect values on Flutter ≥3.27 (`alpha`/`red`/`green`/`blue` now return 0–255, breaking the old math); now uses the `a/r/g/b` accessors.
- `File.sizeFormatted()` crashed on empty files (`log(0)` → `-inf`); now returns `0 B`.

### Tests

- Added `test/extensions_test.dart` covering all new extensions (36 tests).

---

## 0.0.3

## What's Changed

### Dependencies

- Updated `intl` package to ^0.20.2
- Updated `flutter_lints` to ^6.0.0
- Updated minimum Dart SDK to ^3.6.0

### New Features

- Added new widget extensions:
  - `padding()` - Wrap widget with padding
  - `center` - Center widget
  - `expanded` - Expand widget
  - `flexible()` - Make widget flexible
  - `onTap()` - Add tap gesture detector
  - `align()` - Align widget
  - `size()` - Wrap with SizedBox
  - `opacity()` - Add opacity
  - `circular()` - Clip with circular border radius
  - `elevated()` - Add card elevation
- Added navigation extensions:
  - Simplified navigation helpers
  - Easy page transitions
  - Route management utilities

### Improvements

- Enhanced code documentation
- Improved type safety
- Better error handling
