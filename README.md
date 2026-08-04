# Extensions Core

A collection of useful extensions for Dart and Flutter to streamline your development process.

## Features

### Alert

- `showCusDialog(Widget dialog)`: Shows a custom dialog.

### BuildContext

- `screenWidth`: Gets the screen width.
- `screenHeight`: Gets the screen height.
- `screenSize`: Gets the screen size.
- `viewInsets`: Gets the view insets.
- `viewPadding`: Gets the view padding.
- `theme`: Gets the `ThemeData`.
- `textTheme`: Gets the `TextTheme`.
- `colorScheme`: Gets the `ColorScheme`.
- `primaryColor`: Gets the primary color.
- `accentColor`: Gets the accent color.
- `scaffoldBackgroundColor`: Gets the scaffold background color.
- `iconTheme`: Gets the `IconThemeData`.
- `isMobile`: Checks if the device is a mobile phone.
- `isTablet`: Checks if the device is a tablet.
- `isDesktop`: Checks if the device is a desktop.

### Color

- `toHex()`: Converts a `Color` to a hex string.
- `isDark`: Checks if a color is dark.
- `isLight`: Checks if a color is light.
- `blend(Color other, [double factor = 0.5])`: Blends the color with another color.

### Date

- `isToday()`: Checks if the `DateTime` is today.
- `format(String pattern)`: Formats the `DateTime` to a string with the given pattern.
- `formattedDate(BuildContext context, {String pattern = 'yyyy-MM-dd'})`: Get formatted date string based on locale from BuildContext.
- `timeAgo(BuildContext context)`: Get relative time description (e.g., "5 minutes ago").
- `isYesterday()`: Check if the DateTime is yesterday.
- `isInFuture()`: Check if the DateTime is in the future.
- `isInPast()`: Check if the DateTime is in the past.

### Double

- `toFixed(int fractionDigits)`: Formats a double to a fixed number of decimal places.
- `lerp(double other, double t)`: Linearly interpolates between two doubles.

### File

- `sizeBytes`: Gets the file size in bytes.
- `sizeFormatted()`: Gets the file size as a formatted string (e.g., "1.2 MB").

### Icon

- `withColor(Color color)`: Creates a new `Icon` with a different color.
- `withSize(double size)`: Creates a new `Icon` with a different size.

### Image

- `toBase64()`: Converts an `Image` to a base64 string.
- `withFilter(ColorFilter colorFilter)`: Applies a color filter to an `Image`.

### Iterable

- `firstWhereOrNull(bool Function(T) test)`: Finds the first element that satisfies a condition, or return `null`.
- `sumBy(num Function(T) selector)`: Sums the values of a property of each element.
- `averageBy(num Function(T) selector)`: Calculates the average of a property of each element.
- `groupBy<K>(K Function(T) keySelector)`: Groups elements by a key.

### List

- `isNullOrEmpty()`: Checks if the list is null or empty.
- `takeLast(int n)`: Returns the last `n` elements of the list.
- `takeFirst(int n)`: Returns the first `n` elements of the list.
- `chunked(int chunkSize)`: Splits the list into chunks of size `chunkSize`.
- `reversedList()`: Returns a reversed copy of the list.
- `distinct()`: Removes duplicate elements and returns a new list.
- `whereNotNull()`: Removes all null values and returns a new list.
- `shuffledList()`: Returns the list shuffled randomly.
- `mapToList<R>(R Function(T item) transform)`: Maps elements to a new list with a given function `transform`.
- `safeGet(int index)`: Returns a safe element at the given index or null if out of bounds.
- `hasUniqueElements()`: Checks whether the list contains only unique elements.

### Map

- `getOrElse(K key, V defaultValue)`: Gets a value from a map, or a default value if the key doesn't exist.
- `deepMerge(Map<K, V> other)`: Recursively merges two maps.
- `where(bool Function(K key, V value) test)`: Filters a map based on a predicate.
- `mapKeys<T>(T Function(K key) transform)`: Transforms the keys of a map.
- `mapValues<T>(T Function(V value) transform)`: Transforms the values of a map.

### Navigation

- `navigateTo({required Widget screen, state, bool fade = false})`: Navigates to a new screen.
- `navigateAndRestore({required Widget screen, onBack, bool fade = false})`: Navigates to a new screen and restores the previous screen when the new screen is popped.
- `navigateToReplace({required Widget screen})`: Replaces the current screen with a new screen.
- `navigateAndRemoveUntil({required Widget screen, bool fade = false})`: Navigates to a new screen and removes all the previous screens.
- `navigateBack()`: Navigates back to the previous screen.
- `pushScreen<T>(Widget screen)`: Navigate to a new screen.
- `replaceScreen<T>(Widget screen)`: Replace the current screen.
- `popUntilRoute(String routeName)`: Pop until a specific route name.
- `clearStackAndShow(Widget screen)`: Clear the entire navigation stack and show a new screen.
- `pushWithFade<T>(Widget screen)`: Push screen with fade transition.

### Number

- `toCurrency({String symbol = '\

## Installation

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  extensions_core: ^0.0.3
```

Then run `flutter pub get`.

## Usage

Import the package:

```dart
import 'package:extensions_core/extensions.dart';
```

### Examples

**Alert**

```dart
context.showCusDialog(
  AlertDialog(
    title: Text('Title'),
    content: Text('This is a custom dialog.'),
  ),
);
```

**BuildContext**

```dart
// Get screen width
final screenWidth = context.screenWidth;

// Check if the device is a tablet
if (context.isTablet) {
  // ...
}

// Get the primary color from the theme
final primaryColor = context.primaryColor;
```

**Color**

```dart
final hexColor = Colors.blue.toHex(); // #ff2196f3
final isColorDark = Colors.black.isDark; // true
final blendedColor = Colors.red.blend(Colors.blue);
```

**Date**

```dart
final now = DateTime.now();
print(now.isToday()); // true
print(now.format('dd/MM/yyyy'));
print(now.timeAgo(context));
```

**Double**

```dart
final value = 3.14159;
print(value.toFixed(2)); // 3.14

final interpolated = 10.0.lerp(20.0, 0.5); // 15.0
```

**File**

```dart
final file = File('path/to/file.txt');
print(file.sizeFormatted()); // e.g., "1.23 MB"
```

**Icon**

```dart
Icon(Icons.home).withColor(Colors.blue);
Icon(Icons.settings).withSize(32.0);
```

**Image**

```dart
final image = Image.asset('assets/my_image.png');
final base64String = await image.toBase64();
image.withFilter(ColorFilter.mode(Colors.red, BlendMode.color));
```

**Iterable**

```dart
final numbers = [1, 2, 3, 4, 5];
final evenNumber = numbers.firstWhereOrNull((x) => x.isEven); // 2

final people = [Person('Alice', 25), Person('Bob', 30)];
final totalAge = people.sumBy((p) => p.age); // 55
final averageAge = people.averageBy((p) => p.age); // 27.5

final groupedByAge = people.groupBy((p) => p.age);
// { 25: [Person('Alice', 25)], 30: [Person('Bob', 30)] }
```

**List**

```dart
final list = [1, 2, 2, 3, 4, null];
print(list.distinct()); // [1, 2, 3, 4, null]
print(list.whereNotNull()); // [1, 2, 2, 3, 4]
print(list.chunked(2)); // [[1, 2], [2, 3], [4, null]]
```

**Map**

```dart
final map = {'a': 1, 'b': 2};
print(map.getOrElse('c', 3)); // 3

final map1 = {'a': 1, 'b': {'c': 2}};
final map2 = {'b': {'d': 3}, 'e': 4};
print(map1.deepMerge(map2)); // {a: 1, b: {c: 2, d: 3}, e: 4}
```

**Navigation**

```dart
context.navigateTo(screen: DetailsScreen());
context.navigateBack();
```

**Number**

```dart
print(1000.toCompact()); // 1K
print(12345.67.toCurrency(symbol: '€')); // €12,345.67
10.heightBox; // SizedBox(height: 10)
```

**Platform**

```dart
if (context.platform.isIOS) {
  // Show Cupertino widgets
} else if (context.platform.isAndroid) {
  // Show Material widgets
}
```

**Snackbar**

```dart
context.showSnackBar('This is a message.');
```

**State**

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  void updateSomething() {
    // ... do something async
    safeSetState(() {
      // update state
    });
  }
}
```

**String**

```dart
print('hello'.capitalize()); // Hello
print('test@test.com'.isEmail()); // true
```

**TextStyle**

```dart
Text(
  'Styled Text',
  style: TextStyle().bold.color(Colors.red).size(24),
  textAlign: TextStyle().align(),
);
```

**Theme**

```dart
final isDark = context.isDarkMode;
if (isDark) {
  // ...
}
```

**Widget**

```dart
Text('Hello').padding();
Text('Click me').onTap(() => print('Tapped!'));
Container().size(width: 100, height: 100);
```, String locale = 'en_US'})`: Convert number to currency format.
- `toCompact({String locale = 'en_US'})`: Convert number to compact format (e.g., 1K, 1M).
- `toPercentage({int decimals = 0, String locale = 'en_US'})`: Convert number to percentage.
- `toDecimal({int decimals = 2, String locale = 'en_US'})`: Format number with specific decimal places.
- `milliseconds`, `seconds`, `minutes`, `hours`, `days`: Convert to `Duration`.
- `heightBox`, `widthBox`: Convert to `SizedBox`.
- `isBetween(num start, num end)`: Check if number is between a range.
- `clamp(num min, num max)`: Ensure number is within a range.
- `toRadians`, `toDegrees`: Convert to radians/degrees.

### Platform

- `platform`: Get platform info (`isAndroid`, `isIOS`, `isWeb`, etc.).
- `targetPlatform`: Get target platform info (`isAndroid`, `isIOS`, etc.).

### Snackbar

- `showSnackBar(String message)`: Shows a snackbar with the given message.
- `removeSnackBar()`: Removes the current snackbar.

### State

- `safeSetState(VoidCallback fn)`: Calls `setState` only if the widget is still mounted.

### String

- `isEmail()`: Checks if the string is a valid email.
- `capitalize()`: Capitalizes the first letter of the string.
- `isNumeric()`: Returns true if the string contains only numeric characters.
- `isUrl()`: Checks if the string is a valid URL.
- `removeWhitespace()`: Removes all whitespace from the string.
- `reverse()`: Returns a reversed version of the string.
- `isNullOrWhiteSpace()`: Returns true if the string is null, empty, or contains only whitespace.
- `truncate(int maxLength, {String ellipsis = '...'})`: Shortens the string to a specified length with an optional ellipsis.
- `toTitleCase()`: Converts the string to Title Case.
- `isAlphabetic()`: Checks if the string contains only alphabetic characters.
- `containsUppercase()`: Checks if the string contains at least one uppercase letter.
- `containsLowercase()`: Checks if the string contains at least one lowercase letter.
- `containsDigit()`: Checks if the string contains at least one digit.
- `isPhoneNumber()`: Checks if the string is a valid phone number (basic check).

### TextStyle

- `size(double value)`: Sets the font size.
- `scaleSize(double factor)`: Scales the font size by a factor.
- `weight(FontWeight value)`: Sets the font weight.
- `bold`, `semiBold`, `light`, `medium`: Applies bold, semi-bold, light, or medium weight.
- `color(Color value)`: Sets the font color.
- `letterSpacing(double value)`: Sets the letter spacing.
- `wordSpacing(double value)`: Sets the word spacing.
- `italic`: Applies italic style.
- `lineHeight(double value)`: Sets the line height (height factor).
- `backgroundColor(Color value)`: Sets the background color.
- `underline`, `lineThrough`, `overline`, `noDecoration`: Applies or removes text decorations.
- `mergeWith(TextStyle? other)`: Combines two styles.
- `fontFamily(String family)`: Sets a custom font family.
- `withShadow(...)`: Sets text shadows.
- `withShadows(List<Shadow> shadows)`: Applies multiple shadows.
- `decorationThickness(double thickness)`: Adjusts text decoration thickness.
- `glow(...)`: Adds multiple text shadows for a glow effect.
- `responsiveSize(BuildContext context, double factor)`: Makes the font responsive based on screen width.
- `outlined(...)`: Applies an outlined text style.
- `align()`: Sets text alignment using `TextAlign`.

### Theme

- `isDarkMode`: Indicates whether the app is in dark mode.
- `isLightMode`: Indicates whether the app is in light mode.

### Widget

- `padding([EdgeInsetsGeometry value = const EdgeInsets.all(16)])`: Wrap widget with padding.
- `center`: Center widget.
- `expanded`: Expand widget.
- `flexible({int flex = 1})`: Flexible widget.
- `onTap(VoidCallback action)`: Add gesture detector.
- `align([AlignmentGeometry alignment = Alignment.center])`: Align widget.
- `size({double? width, double? height})`: Wrap widget with SizedBox.
- `opacity(double opacity)`: Add opacity to widget.
- `circular([double radius = 8.0])`: Clip widget with circular border radius.
- `elevated([double elevation = 4.0])`: Add card elevation.

## Installation

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  extensions_core: ^0.0.3
```

Then run `flutter pub get`.

## Usage

Import the package:

```dart
import 'package:extensions_core/extensions.dart';
```

### Examples

**String**

```dart
String email = "test@example.com";
print(email.isEmail()); // true

String name = "john";
print(name.capitalize()); // John
```

**Navigation**

```dart
context.navigateTo(screen: MyScreen());
```

**Widget**

```dart
Text("Hello").padding();
Text("World").center();
```

**Date**

```dart
DateTime.now().isToday(); // true
DateTime.now().format("yyyy-MM-dd");
```1