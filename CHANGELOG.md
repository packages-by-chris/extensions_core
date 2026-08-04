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
