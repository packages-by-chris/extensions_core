/// Comprehensive example for the `extensions_core` package.
///
/// Demonstrates extensions from every file in the package: strings, numbers,
/// dates, duration, double, collections (List/Iterable/Map), colors,
/// EdgeInsets, object scope functions, build context, platform, theme,
/// text styles, widget modifiers, icons, images, files, navigation,
/// snackbars, alerts, form validators, and state.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:extensions_core/extensions.dart';

void main() => runApp(const ExtensionsDemoApp());

class ExtensionsDemoApp extends StatelessWidget {
  const ExtensionsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'extensions_core demo',
      theme: ThemeData(colorSchemeSeed: colorFromHex('#34C3EB')),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  int _counter = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('extensions_core demo'.toTitleCase())),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _stringsCard(),
          _numbersCard(),
          _datesCard(),
          _durationAndDoubleCard(),
          _collectionsCard(),
          _mapCard(),
          _colorCard(),
          _edgeInsetsCard(),
          _objectCard(),
          _contextAndPlatformCard(),
          _widgetAndStyleCard(),
          _iconAndImageCard(),
          _fileCard(),
          _interactionsCard(),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------- helpers

  Widget _card(String title, List<Widget> children) => Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16).bold),
              8.heightBox,
              ...children,
            ],
          ),
        ),
      );

  // ---------------------------------------------------------------- strings

  Widget _stringsCard() => _card('String', [
        _row('capitalize', 'dart'.capitalize()),
        _row('toTitleCase', 'hello dart world'.toTitleCase()),
        _row('toCamelCase', 'hello dart world'.toCamelCase()),
        _row('toPascalCase', 'hello dart world'.toPascalCase()),
        _row('toSnakeCase', 'HelloDart World'.toSnakeCase()),
        _row('toKebabCase', 'HelloDart World'.toKebabCase()),
        _row('slugify', 'My Article Title!'.slugify()),
        _row('reverse', 'dart'.reverse()),
        _row('truncate', 'flutter extensions'.truncate(10)),
        _row('masked', '4111111111111111'.masked()),
        _row('initials', 'LeanQ Chris Dev'.initials()),
        _row('isEmail', 'dev@example.com'.isEmail().toString()),
        _row('isUrl', 'https://pub.dev'.isUrl().toString()),
        _row('isNumeric / isAlphabetic',
            '${'123'.isNumeric()} / ${'abc'.isAlphabetic()}'),
        _row('isAlphanumeric', 'abc123'.isAlphanumeric().toString()),
        _row('isPhoneNumber', '+9779812345678'.isPhoneNumber().toString()),
        _row('isStrongPassword', 'Sup3r\$ecret'.isStrongPassword().toString()),
        _row('isJson', '{"a": 1}'.isJson().toString()),
        _row('toIntSafe / toDoubleSafe',
            '${'42'.toIntSafe()} / ${'3.14'.toDoubleSafe()}'),
        _row('toBool', 'yes'.toBool().toString()),
        _row('before / after', '${'a=b'.before('=')} / ${'a=b'.after('=')}'),
        _row('between', 'Hello [Dart]!'.between('[', ']') ?? '-'),
        _row('replaceLast', 'a-b-c'.replaceLast('-', '+')),
        _row('countOccurrences', 'banana'.countOccurrences('an').toString()),
        _row('collapseWhitespace', ' too   many  spaces'.collapseWhitespace()),
        _row('onlyDigits / withoutDigits',
            '${'a1b2'.onlyDigits()} / ${'a1b2'.withoutDigits()}'),
        _row('isNullOrEmpty (nullable)',
            (null as String?).isNullOrEmpty.toString()),
      ]);

  // ---------------------------------------------------------------- numbers

  Widget _numbersCard() => _card('Number / int', [
        _row('toCurrency', 1234.5.toCurrency()),
        _row('toCompact', 9800000.toCompact()),
        _row('toPercentage', 55.5.toPercentage(decimals: 1)),
        _row('toDecimal', 1234567.891.toDecimal()),
        _row('formatBytes', 1536.formatBytes()),
        _row('duration getters', '${5.seconds} / ${3.days}'),
        _row('isBetween', 5.isBetween(1, 10).toString()),
        _row('isPositive / isZero', '${1.isPositive} / ${0.isZero}'),
        _row('isDivisibleBy', 10.isDivisibleBy(3).toString()),
        _row('percentageOf', 25.percentageOf(200).toString()),
        _row('toRadians', 180.toRadians.toStringAsFixed(3)),
        _row('toDegrees', 3.141592653589793.toDegrees.toStringAsFixed(1)),
        _row('isEven / isOdd', '${4.isEven} / ${7.isOdd}'),
        _row('ordinal / toBinary / toHex',
            '2${2.ordinal()} / ${10.toBinary()} / ${255.toHex()}'),
        _row('heightBox / widthBox',
            'SizedBox shortcuts used between rows on this page'),
      ]);

  // ------------------------------------------------------------------ dates

  Widget _datesCard() {
    final now = DateTime.now();
    return _card('DateTime', [
      _row('isToday / isTomorrow', '${now.isToday()} / ${now.isTomorrow()}'),
      _row('isYesterday / isInFuture',
          '${now.isYesterday()} / ${now.isInFuture()}'),
      _row('isSameDay', now.isSameDay(now).toString()),
      _row('isWeekend / isLeapYear', '${now.isWeekend} / ${now.isLeapYear}'),
      _row('quarter', now.quarter.toString()),
      _row('format', now.format('dd MMM yyyy')),
      _row('formattedDate', now.formattedDate(context)),
      _row('timeAgo', now.subtract(5.minutes).timeAgo(context)),
      _row('startOfDay / endOfDay', '${now.startOfDay} … ${now.endOfDay}'),
      _row(
          'startOfWeek / endOfMonth', '${now.startOfWeek} / ${now.endOfMonth}'),
      _row('copyWith', 'year → ${now.copyWith(year: 2030).year}'),
      _row('ageInYears', DateTime(1990, 6, 15).ageInYears().toString()),
      _row(
          'tomorrow / yesterday', '${now.tomorrow.day} / ${now.yesterday.day}'),
    ]);
  }

  // ----------------------------------------------------- duration & double

  Widget _durationAndDoubleCard() => _card('Duration & double', [
        _row('Duration.format',
            const Duration(hours: 2, minutes: 3, seconds: 45).format()),
        _row('inWeeks', const Duration(days: 14).inWeeks.toString()),
        _row('toFixed', 3.14159.toFixed(2).toString()),
        _row('lerp', 0.0.lerp(10.0, 0.5).toString()),
      ]);

  // ------------------------------------------------------------ collections

  Widget _collectionsCard() {
    final list = [1, 2, 3, 4, 5, 6];
    return _card('List / Iterable', [
      _row(
          'takeFirst / takeLast', '${list.takeFirst(2)} / ${list.takeLast(2)}'),
      _row('chunked', list.chunked(2).toString()),
      _row('reversedList / distinct',
          '${list.reversedList()} / ${[1, 1, 2].distinct()}'),
      _row('whereNotNull', [1, null, 2].whereNotNull().toString()),
      _row('shuffledList', list.shuffledList().toString()),
      _row('mapToList', list.mapToList((n) => n * 2).toString()),
      _row('safeGet', 'index 10 → ${list.safeGet(10)}'),
      _row('hasUniqueElements', list.hasUniqueElements().toString()),
      _row('rotate', list.rotate(2).toString()),
      _row('sum / average / min / max',
          '${list.sum} / ${list.average} / ${list.min} / ${list.max}'),
      _row('firstWhereOrNull', list.firstWhereOrNull((n) => n > 3).toString()),
      _row('groupBy parity',
          list.groupBy((n) => n.isEven ? 'even' : 'odd').toString()),
      _row('distinctBy', list.distinctBy((n) => n % 3).toString()),
      _row('countWhere / containsAll',
          '${list.countWhere((n) => n.isEven)} / ${list.containsAll([1, 2])}'),
      _row('zip', [1, 2].zip(['a', 'b']).toString()),
      _row(
          'flatten',
          [
            [1, 2],
            [3]
          ].flatten().toString()),
      _row('insertBetween', [1, 2, 3].insertBetween(0).toString()),
      _row('unzip', [('a', 1), ('b', 2)].unzip().toString()),
    ]);
  }

  // -------------------------------------------------------------------- map

  Widget _mapCard() {
    final map = {'a': 1, 'b': 2, 'c': 3};
    return _card('Map', [
      _row('getOrElse', map.getOrElse('z', -1).toString()),
      _row('getOrPut', map.getOrPut('d', () => 4).toString()),
      _row('invert', map.invert().toString()),
      _row('pick / omit', '${map.pick(['a', 'c'])} / ${map.omit(['a'])}'),
      _row('merge', map.merge({'c': 9}).toString()),
      _row('deepMerge', 'recursively merges nested maps'),
      _row('where', map.where((k, v) => v > 1).toString()),
      _row('mapKeys / mapValues',
          '${map.mapKeys((k) => 'key_$k')} / ${map.mapValues((v) => v * 10)}'),
      _row('filterKeys / filterValues',
          '${map.filterKeys((k) => k != 'b')} / ${map.filterValues((v) => v.isEven)}'),
      _row('keysOf', map.keysOf(3).toString()),
    ]);
  }

  // ------------------------------------------------------------------ color

  Widget _colorCard() {
    final color = colorFromHex('#34C3EB');
    return _card('Color', [
      _row('toHex', color.toHex()),
      _row('isDark / isLight', '${color.isDark} / ${color.isLight}'),
      _row('darken / lighten',
          '${color.darken().toHex()} / ${color.lighten().toHex()}'),
      _row('inverse / complementary',
          '${color.inverse.toHex()} / ${color.complementary.toHex()}'),
      _row('blend', color.blend(Colors.red).toHex()),
      _row(
          'hue / saturation / brightness',
          '${color.hue.toStringAsFixed(0)}° / '
              '${color.saturation.toStringAsFixed(2)} / '
              '${color.brightness.toStringAsFixed(2)}'),
      _row('isTransparent', color.isTransparent.toString()),
      Wrap(
        spacing: 8,
        children: [
          for (final shade in [50, 300, 500, 700, 900])
            Container(
                width: 32, height: 32, color: color.toMaterialColor()[shade]),
        ],
      ),
    ]);
  }

  // ------------------------------------------------------------- edgeInsets

  Widget _edgeInsetsCard() {
    final insets = const EdgeInsets.only(left: 8, bottom: 4).copyWith(top: 16);
    return _card('EdgeInsets', [
      _row('copyWith', insets.toString()),
    ]);
  }

  // ----------------------------------------------------------------- object

  Widget _objectCard() => _card('Object (scope functions)', [
        _row('let', 'dart'.let((s) => '\$s!')),
        _row('run', 5.run((n) => n * 2).toString()),
        _row('also', 5.also((n) => n).toString()),
        _row('isNull / isNotNull', 'null → ${null.isNull}, 1 → ${1.isNotNull}'),
      ]);

  // ------------------------------------------------ context/platform/theme

  Widget _contextAndPlatformCard() => _card('BuildContext / Platform / Theme', [
        Builder(
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _row('screenSize',
                  '${context.screenWidth.round()} x ${context.screenHeight.round()}'),
              _row('isMobile / isTablet / isDesktop',
                  '${context.isMobile} / ${context.isTablet} / ${context.isDesktop}'),
              _row('orientation / isPortrait',
                  '${context.orientation} / ${context.isPortrait}'),
              _row('safePadding', context.safePadding.toString()),
              _row('viewInsets (keyboard)',
                  context.viewInsets.bottom.toString()),
              _row('devicePixelRatio', context.devicePixelRatio.toString()),
              _row('textScaler', context.textScaler.toString()),
              _row('locale', context.locale.toString()),
              _row('textDirection', context.textDirection.toString()),
              _row(
                  'theme / colorScheme',
                  '${context.theme.primaryColor.toHex()} / '
                      '${context.colorScheme.primary.toHex()}'),
              _row('scaffoldBackgroundColor',
                  context.scaffoldBackgroundColor.toHex()),
              _row('isDarkMode', context.isDarkMode.toString()),
              _row('platform (OS)', _osName(context)),
              _row(
                  'targetPlatform',
                  context.targetPlatform.isIOS
                      ? 'iOS target'
                      : 'not iOS target'),
            ],
          ),
        ),
      ]);

  String _osName(BuildContext context) {
    final p = context.platform;
    return p.isWeb
        ? 'web'
        : p.isAndroid
            ? 'android'
            : p.isIOS
                ? 'iOS'
                : p.isMacOS
                    ? 'macOS'
                    : p.isWindows
                        ? 'windows'
                        : p.isLinux
                            ? 'linux'
                            : 'fuchsia';
  }

  // -------------------------------------------------- widget & text styles

  Widget _widgetAndStyleCard() => _card('Widget & TextStyle', [
        _row(
            'widget modifiers',
            'padding, margin, center, expanded, flexible, align, size, width, '
                'height, aspectRatio, constrained, background, border, circular, '
                'elevated, blur, rotated, scaled, opacity, visible, safeArea, '
                'tooltip, onTap, onLongPress, onDoubleTap, inkWell — used below'),
        Text('bold + size + let() for color',
            style: const TextStyle()
                .size(18)
                .bold
                .let((s) => s.copyWith(color: Colors.teal))),
        Text('italic underlined medium',
            style: const TextStyle().italic.underline.medium),
        Text('glow', style: const TextStyle().glow(color: Colors.deepPurple)),
        Text('scaleSize + lineThrough',
            style: const TextStyle().scaleSize(1.3).lineThrough),
        Text('responsiveSize',
            style: const TextStyle().responsiveSize(context, 0.04)),
        Text('outlined', style: const TextStyle().outlined()),
        const Text('background + tap + rounded corners')
            .onTap(() => debugPrint('tapped'))
            .background(Colors.green.withValues(alpha: 0.2))
            .circular()
            .padding(),
      ]);

  // -------------------------------------------------------- icon and image

  Widget _iconAndImageCard() {
    // 1x1 transparent PNG used to demo Image.toBase64 without assets.
    final png = base64Decode('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJ'
        'AAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==');
    return _card('Icon & Image', [
      _row('Icon.withColor / withSize', 'amber star below'),
      const Icon(Icons.star, size: 24).withColor(Colors.amber).withSize(48),
      _row('Image.withFilter', 'grayscale demo below'),
      SizedBox(
        height: 40,
        child: Image(
          image: MemoryImage(png),
          filterQuality: FilterQuality.low,
        ).withFilter(const ColorFilter.mode(
          Colors.grey,
          BlendMode.saturation,
        )),
      ),
      FutureBuilder<String>(
        future: Image(image: MemoryImage(png)).toBase64(),
        builder: (context, snapshot) => _row(
            'Image.toBase64',
            snapshot.data == null
                ? 'resolving…'
                : '${snapshot.data!.length} chars'),
      ),
    ]);
  }

  // ------------------------------------------------------------------- file

  Widget _fileCard() {
    final file =
        File('${Directory.systemTemp.path}${Platform.pathSeparator}demo.txt')
          ..writeAsStringSync('hello extensions_core');
    return _card('File (VM only)', [
      _row('sizeBytes', file.sizeBytes.toString()),
      _row('sizeFormatted', file.sizeFormatted()),
      _row('sizeInMB', file.sizeInMB.toString()),
      _row('isImage / isVideo / isAudio',
          'demo.txt → ${file.isImage} / ${file.isVideo} / ${file.isAudio}'),
      FutureBuilder<String?>(
        future: file.readAsStringSafe(),
        builder: (context, snapshot) =>
            _row('readAsStringSafe', snapshot.data ?? 'null'),
      ),
    ]);
  }

  // ------------------------------------------------------------ interactions

  Widget _interactionsCard() => _card('Interactions', [
        _row('State.safeSetState',
            'counter = $_counter (mounted-safe setState)'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => setState(() => _counter += 1),
              child: const Text('safeSetState +1'),
            ),
            ElevatedButton(
              onPressed: () => context.showSnackBar('Hello from showSnackBar!'),
              child: const Text('showSnackBar'),
            ),
            ElevatedButton(
              onPressed: () => context.showCusDialog(simpleDialog()),
              child: const Text('showCusDialog'),
            ),
            ElevatedButton(
              onPressed: () => context.showAppDialog(
                title: 'showAppDialog',
                content: const Text('Built from title + content + actions.'),
                actions: [
                  TextButton(onPressed: () {}, child: const Text('OK'))
                ],
              ),
              child: const Text('showAppDialog'),
            ),
            ElevatedButton(
              onPressed: () => context.showSheet(
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('Modal bottom sheet'),
                ),
              ),
              child: const Text('showSheet'),
            ),
            ElevatedButton(
              onPressed: () => context.pushScreen(const DetailScreen()),
              child: const Text('pushScreen'),
            ),
            ElevatedButton(
              onPressed: () => context.pushWithFade(const DetailScreen()),
              child: const Text('pushWithFade'),
            ),
            ElevatedButton(
              onPressed: () => context.pushWithSlide(const DetailScreen()),
              child: const Text('pushWithSlide'),
            ),
            ElevatedButton(
              onPressed: () => context.hideKeyboard(),
              child: const Text('hideKeyboard'),
            ),
          ],
        ),
        8.heightBox,
        _form(),
      ]);

  Widget simpleDialog() => AlertDialog(
        title: const Text('showCusDialog'),
        content: const Text('Any widget can be shown as a dialog.'),
        actions: [
          TextButton(
              onPressed: context.navigateBack, child: const Text('Close')),
        ],
      );

  // -------------------------------------------------------------------- form

  Widget _form() => Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Required field'),
              validator: requiredField,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: emailValidator,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone'),
              validator: phoneValidator,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (v) =>
                  minLengthValidator(v, 8, message: 'At least 8 characters'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Bio (max 140)'),
              validator: (v) => maxLengthValidator(v, 140),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.showSnackBar('Form is valid');
                    }
                  },
                  child: const Text('Validate form'),
                ),
              ),
            ),
          ],
        ),
      );
}

/// Simple target screen for the navigation demos.
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.currentRouteName ?? 'Detail')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Reached via NavigationExtension').padding(),
            Text('canPop: ${context.canPop}').padding(),
            ElevatedButton(
              onPressed: () => context.popWithResult('done'),
              child: const Text('popWithResult'),
            ),
            ElevatedButton(
              onPressed: context.maybePop,
              child: const Text('maybePop'),
            ),
            ElevatedButton(
              onPressed: context.navigateBack,
              child: const Text('navigateBack'),
            ),
            ElevatedButton(
              onPressed: () => context.popUntilRoute('/'),
              child: const Text('popUntilRoute("/")'),
            ),
            ElevatedButton(
              onPressed: () => context.clearStackAndShow(const DemoHomePage()),
              child: const Text('clearStackAndShow'),
            ),
            ElevatedButton(
              onPressed: context.popToFirst,
              child: const Text('popToFirst'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Row helper shared by both demo screens.
Widget _row(String label, String value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text('$label: $value'),
    );
