<div align="center">

# Extensions Core

**A comprehensive, dependency-light collection of Dart & Flutter extensions.**

Stop hunting for separate extension packages — `extensions_core` covers the
daily-driver utilities across strings, numbers, dates, collections, colors,
widgets, navigation, and more in one place.

[![pub package](https://img.shields.io/pub/v/extensions_core.svg)](https://pub.dev/packages/extensions_core)
[![pub points](https://img.shields.io/pub/points/extensions_core)](https://pub.dev/packages/extensions_core/score)
[![pub likes](https://img.shields.io/pub/likes/extensions_core)](https://pub.dev/packages/extensions_core/score)
[![CI](https://github.com/LeanQChris/extensions/actions/workflows/ci.yml/badge.svg)](https://github.com/LeanQChris/extensions/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/LeanQChris/extensions/branch/main/graph/badge.svg)](https://codecov.io/gh/LeanQChris/extensions)
![Dart](https://img.shields.io/badge/Dart-%5E3.6-blue)
![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.27-blueviolet)
![License](https://img.shields.io/badge/License-MIT-green)

---

</div>

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Extension Collections](#extension-collections)
  - [Object](#object)
  - [String](#string)
  - [Number & Int](#number--int)
  - [Double](#double)
  - [DateTime](#datetime)
  - [Duration](#duration)
  - [Iterable](#iterable)
  - [List](#list)
  - [Map](#map)
  - [Color](#color)
  - [BuildContext](#buildcontext)
  - [Widget](#widget)
  - [TextStyle](#textstyle)
  - [Icon](#icon)
  - [Image](#image)
  - [File](#file)
  - [EdgeInsets](#edgeinsets)
  - [State](#state)
  - [Platform](#platform)
  - [Navigation](#navigation)
  - [Alert & Snackbar](#alert--snackbar)
  - [Form Validators](#form-validators)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  extensions_core: ^0.1.0
```

Then run:

```bash
flutter pub get
```

**Requirements:** Dart `^3.6.0` · Flutter `>=3.27.0`

---

## Quick Start

```dart
import 'package:extensions_core/extensions.dart';

void main() {
  // Strings
  'hello world'.toCamelCase();      // helloWorld
  'hello world'.toSnakeCase();      // hello_world
  'user@site.com'.isEmail();        // true

  // Iterables
  [1, 2, 3, 4].sum;                 // 10
  [1, 2, 3].zip(['a', 'b']);        // [(1, a), (2, b)]

  // Colors
  colorFromHex('#2196f3').toHex();  // #ff2196f3

  // Dates
  DateTime.now().startOfWeek;       // Monday
}
```

---

## Extension Collections

### Object

| Extension | Description |
| --- | --- |
| `let<R>(R Function(T))` | Pass `this` to a function, return its result. |
| `also(void Function(T))` | Run a side effect, return `this`. |
| `run<R>(R Function(T))` | Alias of `let`. |
| `isNull` / `isNotNull` | Null checks on any nullable value. |

```dart
final length = 'hello'.let((s) => s.length); // 5
String? maybe;
maybe.isNull; // true
```

### String

Validation: `isEmail` · `isUrl` · `isPhoneNumber` · `isNumeric` ·
`isAlphabetic` · `isAlphanumeric` · `containsUppercase` ·
`containsLowercase` · `containsDigit` · `containsSpecialCharacter` ·
`isStrongPassword` · `isJson`

Parsing: `toIntSafe` · `toDoubleSafe` · `toBool` · `isNullOrEmpty` (nullable) ·
`isNullOrWhiteSpace`

Case: `capitalize` · `toTitleCase` · `toCamelCase` · `toPascalCase` ·
`toSnakeCase` · `toKebabCase`

Slicing: `truncate` · `reverse` · `removeWhitespace` · `collapseWhitespace` ·
`before` · `after` · `between` · `replaceLast` · `countOccurrences` ·
`initials` · `masked` · `onlyDigits` · `withoutDigits` · `slugify`

```dart
'john_smith'.toCamelCase();      // johnSmith
'John Smith'.initials();         // JS
'hello'.masked();                // *ello
```

### Number & Int

Formatting: `toCurrency` · `toCompact` · `toPercentage` · `toDecimal` ·
`formatBytes`

Predicates: `isPositive` · `isZero` · `isDivisibleBy` · `percentageOf` ·
`isEven` · `isOdd` (from `dart:core`)

Conversions: `ordinal` (int) · `toBinary` · `toOctal` · `toHex` (int) ·
`milliseconds`/`seconds`/`minutes`/`hours`/`days` → `Duration` ·
`heightBox`/`widthBox` → `SizedBox` · `toRadians` · `toDegrees` · `isBetween`

`toPercentage` treats the value as an already-scaled percentage (`100` ->
`100%`), and `toDecimal` pads to exactly `decimals` fraction digits.

```dart
1.ordinal();              // 1st
5.toBinary();             // 101
1024.formatBytes();       // 1.00 KB
100.toPercentage();       // 100%
1.5.toDecimal(decimals: 3); // 1.500
10.heightBox;             // SizedBox(height: 10)
12.minutes;               // Duration(minutes: 12)
```

### Double

`toFixed(int fractionDigits)` · `lerp(other, t)`

```dart
3.14159.toFixed(2);              // 3.14
10.0.lerp(20.0, 0.5);            // 15.0
```

### DateTime

Checks: `isToday` · `isYesterday` · `isTomorrow` · `isSameDay` ·
`isSameMonth` · `isSameYear` · `isBetween` · `isWeekend` · `isWeekday` ·
`isLeapYear` · `isInFuture` · `isInPast`

Boundaries: `startOfDay`/`endOfDay` · `startOfWeek`/`endOfWeek` ·
`startOfMonth`/`endOfMonth` · `startOfYear`/`endOfYear` ·
`tomorrow` · `yesterday`

Helpers: `copyWith` · `ageInYears` · `quarter`
Formatting: `format` · `formattedDate` · `timeAgo`

```dart
final now = DateTime.now();
now.startOfMonth;          // 1st of the month
now.ageInYears();          // whole years
now.timeAgo(context);      // "5 minutes ago"
```

### Duration

`inWeeks` · `format()`

```dart
const Duration(hours: 2, minutes: 3, seconds: 45).format(); // 2:03:45
```

### Iterable

Selection: `firstWhereOrNull` · `distinctBy` · `countWhere` ·
`containsAll` · `containsAny`

Nullable: `isNullOrEmpty` (on `Iterable<T>?`) · `whereNotNull` (on
`Iterable<T?>`, narrows to `List<T>`)

Math (`Iterable<num>`): `sum` · `min` · `max` · `average`; plus `sumBy` ·
`averageBy`

Grouping/joining: `groupBy` · `insertBetween` · `zip` · `unzip` · `flatten`

### List

`takeLast` · `takeFirst` · `chunked` · `reversedList` ·
`rotate` · `distinct` · `shuffledList` · `mapToList` ·
`safeGet` · `hasUniqueElements`

```dart
[1, 2, 3, 4, 5].rotate(2);   // [4, 5, 1, 2, 3]
[1, 2, 3].chunked(2);        // [[1, 2], [3]]
```

### Map

`getOrElse` · `getOrPut` · `deepMerge` · `merge` · `invert` · `where` ·
`filterKeys` · `filterValues` · `mapKeys` · `mapValues` · `pick` · `omit` ·
`keysOf`

```dart
{'a': 1, 'b': 2}.invert();               // {1: a, 2: b}
{'a': 1, 'b': 2, 'c': 3}.pick(['a', 'c']); // {a: 1, c: 3}
```

### Color

Conversion: `toHex` · `colorFromHex(String)` (top-level function)

Shading: `darken` · `lighten` · `blend` · `inverse` · `complementary`

Properties: `hue` · `saturation` · `brightness` · `withBrightness` ·
`isDark` · `isLight` · `isTransparent` · `toMaterialColor`

```dart
colorFromHex('#f00').lighten(0.2);
Colors.red.complementary;   // cyan
Colors.red.toMaterialColor();
```

### BuildContext

Media: `screenWidth` · `screenHeight` · `screenSize` · `viewInsets` ·
`viewPadding` · `safePadding` · `mediaQuery` · `devicePixelRatio` ·
`textScaler` · `orientation` · `isPortrait` · `isLandscape` · `hideKeyboard`

Device/Theme: `isMobile` · `isTablet` · `isDesktop` · `theme` · `textTheme` ·
`colorScheme` · `primaryColor` · `accentColor` · `scaffoldBackgroundColor` ·
`iconTheme` · `locale` · `textDirection`

```dart
if (context.isTablet) { /* ... */ }
context.hideKeyboard();
```

### Widget

Layout: `padding` · `margin` · `background` · `border` · `center` ·
`expanded` · `flexible` · `align` · `size` · `width` · `height` ·
`constrained` · `aspectRatio`

Interaction: `onTap` · `onLongPress` · `onDoubleTap` · `inkWell` · `tooltip`

Effect: `opacity` · `visible` · `safeArea` · `circular` · `elevated` ·
`blur` · `rotated` · `scaled`

```dart
Text('Hello').padding().background(Colors.red).tooltip('hi');
Text('Tap').inkWell(onTap);
```

### TextStyle

`size` · `scaleSize` · `weight` · `bold` · `semiBold` · `light` · `medium` ·
`color` · `letterSpacing` · `wordSpacing` · `italic` · `lineHeight` ·
`backgroundColor` · `underline` · `lineThrough` · `overline` ·
`noDecoration` · `decorationThickness` · `mergeWith` · `fontFamily` ·
`withShadow` · `withShadows` · `glow` · `responsiveSize` · `outlined`

```dart
TextStyle().bold.color(Colors.red).size(24);
```

### Icon

`withColor(Color)` · `withSize(double)`

### Image

`toBase64()` · `withFilter(ColorFilter)`

### File

`sizeBytes` · `sizeFormatted` · `sizeInMB` · `isImage` · `isVideo` ·
`isAudio` · `readAsStringSafe`

Only available where `dart:io` exists (not on the web).

```dart
File('photo.jpg').isImage;   // true
file.sizeFormatted();        // "1.23 MB"
```

### EdgeInsets

`copyWith({left, top, right, bottom})` — Flutter's `EdgeInsets` has none.

### State

`safeSetState(fn)` — calls `setState` only while the widget is mounted.

### Platform

On `BuildContext`: `platform` and `targetPlatform` expose `isAndroid`, `isIOS`,
`isWeb`, `isMacOS`, `isWindows`, `isLinux`, `isFuchsia`.

### Navigation

Transitions: `navigateTo` · `navigateBack` · `navigateToReplace` ·
`navigateAndRestore` (runs `onBack` on pop) · `navigateAndRemoveUntil` ·
`pushScreen` · `pushWithFade` · `pushWithSlide` · `replaceScreen`

Stack: `clearStackAndShow` · `popUntilRoute` · `popToFirst` · `canPop` ·
`maybePop` · `popWithResult` · `currentRouteName`

Presenters: `showSheet` · `showAppDialog`

```dart
context.pushWithSlide(DetailsScreen());
context.canPop;
context.showSheet(child);
```

### Alert & Snackbar

`showCusDialog(Widget)` · `showSnackBar(String)` · `removeSnackBar()`

### Form Validators

Composable `String? Function(String?)` validators, ready for `TextFormField`:

`requiredField` · `emailValidator` · `phoneValidator` ·
`minLengthValidator` · `maxLengthValidator`

```dart
TextFormField(validator: emailValidator);
```

---

## Examples

A few pending UI recipes:

```dart
// Ripple button with padding and tooltip
Text('Submit').inkWell(() => submit()).padding(EdgeInsets.all(12));

// Slide-in navigation to a screen
context.pushWithSlide(const ProfileScreen());

// Form field with validation
TextFormField(
  controller: _email,
  validator: emailValidator,
  decoration: const InputDecoration(labelText: 'Email'),
);
```

---

## Contributing

Contributions are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md). To keep the
package consistent:

1. Extensions follow the Dart style guide and `flutter_lints`.
2. New extensions should be added under `lib/extensions/` with a focused file
   per type, then exported from `lib/extensions.dart`.
3. Add tests in `test/` — run `flutter test` and `flutter analyze` before
   submitting.
4. Update this README and the `CHANGELOG.md` for user-visible changes.

---

## License

[MIT](LICENSE)

Copyright © Extensions Core contributors.