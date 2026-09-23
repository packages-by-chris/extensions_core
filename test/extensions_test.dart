import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:extensions_core/extensions.dart';

void main() {
  group('Object', () {
    test('let/also/run', () {
      expect(5.let((n) => n * 2), 10);
      var log = 0;
      final result = 5.also((n) => log = n);
      expect(result, 5);
      expect(log, 5);
      expect('x'.run((s) => s.length), 1);
    });

    test('isNull/isNotNull', () {
      String? s;
      expect(s.isNull, isTrue);
      expect(''.isNull, isFalse);
      expect(s.isNotNull, isFalse);
      expect('a'.isNotNull, isTrue);
    });
  });

  group('Uri', () {
    test('schemes', () {
      expect(Uri.parse('http://x.dev').isHttp, isTrue);
      expect(Uri.parse('https://x.dev').isHttps, isTrue);
      expect(Uri.parse('https://x.dev').isWeb, isTrue);
      expect(Uri.parse('ftp://x.dev').isWeb, isFalse);
      expect(Uri.parse('').isHttp, isFalse);
    });

    test('domain/pathLastSegment', () {
      expect(
          Uri.parse('https://www.example.com/path/id').domain, 'example.com');
      expect(Uri.parse('https://example.com').domain, 'example.com');
      expect(Uri.parse('relative').domain, isNull);
      expect(Uri.parse('/users/42/').pathLastSegment, '42');
      expect(Uri.parse('/folder/').pathLastSegment, 'folder');
      expect(Uri.parse('').pathLastSegment, isNull);
    });

    test('query manipulation', () {
      final base = Uri.parse('https://x.dev?a=1&b=2');
      expect(base.withQueryParam('b', '9'), Uri.parse('https://x.dev?a=1&b=9'));
      expect(base.withQueryParam('c', '3'),
          Uri.parse('https://x.dev?a=1&b=2&c=3'));
      expect(base.withoutQueryParams(['a']), Uri.parse('https://x.dev?b=2'));
      expect(
          base.withoutQueryParams(['a', 'b', 'z']), Uri.parse('https://x.dev'));
    });
  });

  group('Bool', () {
    test('toInt/toggle/toYesNo', () {
      expect(true.toInt(), 1);
      expect(false.toInt(), 0);
      expect(true.toggle(), isFalse);
      expect(false.toggle(), isTrue);
      expect(true.toYesNo(), 'Yes');
      expect(false.toYesNo(), 'No');
      expect(false.toYesNo(yes: 'Y', no: 'N'), 'N');
    });
  });

  group('String', () {
    test('isNullOrEmpty', () {
      String? s;
      expect(s.isNullOrEmpty, isTrue);
      expect(''.isNullOrEmpty, isTrue);
      expect(' '.isNullOrEmpty, isFalse);
    });

    test('case conversion', () {
      expect('hello world'.toCamelCase(), 'helloWorld');
      expect('HelloWorld'.toSnakeCase(), 'hello_world');
      expect('hello world'.toKebabCase(), 'hello-world');
      expect('hello world'.toPascalCase(), 'HelloWorld');
      expect('foo_bar baz'.toCamelCase(), 'fooBarBaz');
      expect('HelloWorld'.toKebabCase(), 'hello-world');
    });

    test('safe parsing', () {
      expect('42'.toIntSafe(), 42);
      expect('abc'.toIntSafe(), isNull);
      expect('3.14'.toDoubleSafe(), 3.14);
      expect('3.14'.toIntSafe(), isNull);
      expect('yes'.toBool(), isTrue);
      expect('0'.toBool(), isFalse);
      expect('maybe'.toBool(), isNull);
    });

    test('slicing', () {
      expect('a,b,c'.before(','), 'a');
      expect('abc'.before('z'), 'abc');
      expect('a,b,c'.after(','), 'b,c');
      expect('[x]'.between('[', ']'), 'x');
      expect('abc'.between('[', ']'), isNull);
      expect('a-b-a'.replaceLast('a', 'x'), 'a-b-x');
    });

    test('counting and checks', () {
      expect('banana'.countOccurrences('an'), 2);
      expect('abc123'.isAlphanumeric(), isTrue);
      expect('abc'.isAlphanumeric(), isTrue);
      expect('abc!'.containsSpecialCharacter(), isTrue);
      expect('abc1'.containsSpecialCharacter(), isFalse);
      expect('Passw0rd!'.isStrongPassword(), isTrue);
      expect('password'.isStrongPassword(), isFalse);
      expect('{"a":1}'.isJson(), isTrue);
      expect('[1,2]'.isJson(), isTrue);
      expect('hello'.isJson(), isFalse);
    });

    test('transformations', () {
      expect('Hello World!!'.slugify(), 'hello-world');
      expect('  a  b   c  '.collapseWhitespace(), 'a b c');
      expect('a1b2c3'.withoutDigits(), 'abc');
      expect('a1b2c3'.onlyDigits(), '123');
      expect('1234567890123456'.masked(), '************3456');
      expect('1234'.masked(), '1234');
      expect('John Smith'.initials(), 'JS');
      expect('John'.initials(), 'JO');
      expect('hello'.initials(), 'HE');
    });
  });

  group('Number', () {
    test('int predicates', () {
      expect(4.isEven, isTrue);
      expect(3.isOdd, isTrue);
      expect(5.isDivisibleBy(5), isTrue);
      expect(7.isDivisibleBy(2), isFalse);
      expect(0.isDivisibleBy(0), isFalse);
    });

    test('num predicates', () {
      expect(5.isPositive, isTrue);
      expect((-5).isPositive, isFalse);
      expect(0.isZero, isTrue);
      expect(25.percentageOf(100), 25);
      expect(50.percentageOf(0), 0);
    });

    test('ordinal', () {
      expect(1.ordinal(), '1st');
      expect(2.ordinal(), '2nd');
      expect(3.ordinal(), '3rd');
      expect(11.ordinal(), '11th');
      expect(12.ordinal(), '12th');
      expect(13.ordinal(), '13th');
      expect(21.ordinal(), '21st');
      expect(102.ordinal(), '102nd');
    });

    test('radix and formatBytes', () {
      expect(5.toBinary(), '101');
      expect(8.toOctal(), '10');
      expect(255.toHex(), 'FF');
      expect(1024.formatBytes(), '1.00 KB');
      expect(1536.formatBytes(decimals: 1), '1.5 KB');
      expect(0.formatBytes(), '0.00 B');
    });
  });

  group('DateTime', () {
    test('same checks', () {
      final now = DateTime(2025, 6, 15, 10, 30);
      expect(now.isSameDay(DateTime(2025, 6, 15, 23, 59)), isTrue);
      expect(now.isSameDay(DateTime(2025, 6, 16)), isFalse);
      expect(now.isSameMonth(DateTime(2025, 6, 1)), isTrue);
      expect(now.isSameYear(DateTime(2025, 12, 31)), isTrue);
      expect(DateTime(2025, 6, 15, 12).isBetween(now, DateTime(2025, 6, 16)),
          isTrue);
      expect(
          DateTime(2025, 6, 17).isBetween(now, DateTime(2025, 6, 16)), isFalse);
    });

    test('weekday/leap/quarter', () {
      // 2025-06-15 was a Sunday.
      expect(DateTime(2025, 6, 15).isWeekend, isTrue);
      expect(DateTime(2025, 6, 16).isWeekday, isTrue);
      expect(DateTime(2024).isLeapYear, isTrue);
      expect(DateTime(2025).isLeapYear, isFalse);
      expect(DateTime(2025, 6, 15).quarter, 2);
      expect(DateTime(2025, 10, 1).quarter, 4);
    });

    test('boundaries', () {
      final d = DateTime(2025, 6, 15, 14, 30, 45);
      expect(d.startOfDay, DateTime(2025, 6, 15));
      expect(d.endOfDay, DateTime(2025, 6, 15, 23, 59, 59, 999));
      expect(d.startOfMonth, DateTime(2025, 6, 1));
      expect(d.endOfMonth, DateTime(2025, 6, 30, 23, 59, 59, 999));
      expect(d.startOfYear, DateTime(2025, 1, 1));
      expect(d.endOfYear, DateTime(2025, 12, 31, 23, 59, 59, 999));
      // 2025-06-15 was a Sunday -> week starts Monday 2025-06-09.
      expect(d.startOfWeek, DateTime(2025, 6, 9));
      expect(d.endOfWeek, DateTime(2025, 6, 15, 23, 59, 59, 999));
    });

    test('copyWith/age/tomorrow', () {
      final d = DateTime(2025, 6, 15, 10);
      expect(d.copyWith(day: 20, hour: 9), DateTime(2025, 6, 20, 9));
      expect(d.copyWith(), d);
      expect(d.tomorrow, DateTime(2025, 6, 16, 10));
      expect(d.yesterday, DateTime(2025, 6, 14, 10));
      expect(DateTime(2020, 6, 15).ageInYears(DateTime(2025, 6, 14)), 4);
      expect(DateTime(2020, 6, 15).ageInYears(DateTime(2025, 6, 15)), 5);
    });

    test('isToday/isYesterday/isTomorrow', () {
      final now = DateTime.now();
      expect(now.isToday(), isTrue);
      expect(now.add(const Duration(days: 1)).isToday(), isFalse);
      expect(now.subtract(const Duration(days: 1)).isYesterday(), isTrue);
      expect(now.add(const Duration(days: 1)).isYesterday(), isFalse);
      expect(now.add(const Duration(days: 1)).isTomorrow(), isTrue);
      expect(now.subtract(const Duration(days: 2)).isTomorrow(), isFalse);
    });

    test('isInFuture/isInPast', () {
      final now = DateTime.now();
      expect(now.add(const Duration(hours: 1)).isInFuture(), isTrue);
      expect(now.subtract(const Duration(hours: 1)).isInFuture(), isFalse);
      expect(now.subtract(const Duration(hours: 1)).isInPast(), isTrue);
      expect(now.add(const Duration(hours: 1)).isInPast(), isFalse);
    });

    test('format and ageInYears default', () {
      expect(DateTime(2025, 6, 15).format('yyyy/MM/dd'), '2025/06/15');
      expect(DateTime(2025, 6, 15).format('MMM'), 'Jun');
      expect(DateTime(2000, 1, 1).ageInYears(), greaterThanOrEqualTo(25));
    });

    test('names and daysInMonth', () {
      final d = DateTime(2025, 6, 15);
      expect(d.weekdayName, 'Sunday');
      expect(d.weekdayShortName, 'Sun');
      expect(d.monthName, 'June');
      expect(d.monthShortName, 'Jun');
      expect(d.daysInMonth, 30);
      expect(DateTime(2024, 2, 1).daysInMonth, 29);
      expect(DateTime(2025, 2, 1).daysInMonth, 28);
      expect(DateTime(2025, 12, 1).daysInMonth, 31);
    });
  });

  group('Duration', () {
    test('inWeeks/format', () {
      expect(const Duration(days: 14).inWeeks, 2);
      expect(const Duration(hours: 2, minutes: 3, seconds: 45).format(),
          '2:03:45');
    });

    test('isLongerThan/isShorterThan', () {
      const a = Duration(seconds: 5);
      const b = Duration(seconds: 10);
      expect(b.isLongerThan(a), isTrue);
      expect(a.isLongerThan(b), isFalse);
      expect(a.isShorterThan(b), isTrue);
      expect(b.isShorterThan(a), isFalse);
      expect(a.isLongerThan(a), isFalse);
    });
  });

  group('Controllers', () {
    test('TextEditingController selectAll/cursorToEnd', () {
      final c = TextEditingController(text: 'hello world');
      c.selectAll();
      expect(c.selection, const TextSelection(baseOffset: 0, extentOffset: 11));
      c.cursorToEnd();
      expect(c.selection, const TextSelection.collapsed(offset: 11));
      c.clear();
      c.cursorToEnd();
      expect(c.selection, const TextSelection.collapsed(offset: 0));
    });

    testWidgets('ScrollController top/bottom', (tester) async {
      final controller = ScrollController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ListView.builder(
            controller: controller,
            itemCount: 100,
            itemBuilder: (_, i) => SizedBox(height: 50, child: Text('item $i')),
          ),
        ),
      ));
      expect(controller.position.maxScrollExtent, greaterThan(0));
      controller.jumpToBottom();
      await tester.pump();
      expect(controller.offset, controller.position.maxScrollExtent);
      controller.jumpToTop();
      await tester.pump();
      expect(controller.offset, 0);
      controller.scrollToBottom();
      await tester.pumpAndSettle();
      expect(controller.offset, controller.position.maxScrollExtent);
      controller.scrollToTop();
      await tester.pumpAndSettle();
      expect(controller.offset, 0);
    });
  });

  group('Iterable', () {
    test('num iterable', () {
      expect([1, 2, 3, 4].sum, 10);
      expect([1, 2, 3, 4].min, 1);
      expect([1, 2, 3, 4].max, 4);
      expect([1, 2, 3, 4].average, 2.5);
      expect(<int>[].sum, 0);
      expect(<int>[].average, 0.0);
    });

    test('distinctBy/countWhere/contains', () {
      expect(
        [
          {'id': 1},
          {'id': 1},
          {'id': 2}
        ].distinctBy((e) => e['id']).length,
        2,
      );
      expect([1, 2, 3, 4].countWhere((x) => x.isEven), 2);
      expect([1, 2, 3].containsAll([1, 3]), isTrue);
      expect([1, 2, 3].containsAll([1, 9]), isFalse);
      expect([1, 2, 3].containsAny([3, 9]), isTrue);
    });

    test('zip/unzip/flatten/insertBetween', () {
      expect([1, 2, 3].zip(['a', 'b']), [(1, 'a'), (2, 'b')]);
      final (left, right) = [(1, 'a'), (2, 'b')].unzip();
      expect(left, [1, 2]);
      expect(right, ['a', 'b']);
      expect(
          [
            [1, 2],
            [3],
            <int>[]
          ].flatten(),
          [1, 2, 3]);
      expect([1, 2, 3].insertBetween(0), [1, 0, 2, 0, 3]);
    });
  });

  group('List', () {
    test('rotate', () {
      expect([1, 2, 3, 4, 5].rotate(2), [4, 5, 1, 2, 3]);
      expect([1, 2, 3, 4, 5].rotate(-1), [2, 3, 4, 5, 1]);
      expect([1, 2, 3].rotate(3), [1, 2, 3]);
      expect(<int>[].rotate(2), isEmpty);
    });
  });

  group('Map', () {
    test('invert/getOrPut/pick/omit', () {
      expect({'a': 1, 'b': 2}.invert(), {1: 'a', 2: 'b'});
      final m = <String, int>{'a': 1};
      expect(m.getOrPut('b', () => 2), 2);
      expect(m['b'], 2);
      expect(m.getOrPut('a', () => 99), 1);
      expect({'a': 1, 'b': 2, 'c': 3}.pick(['a', 'c', 'z']), {'a': 1, 'c': 3});
      expect({'a': 1, 'b': 2, 'c': 3}.omit(['b']), {'a': 1, 'c': 3});
    });

    test('filters/keysOf/merge', () {
      expect({'a': 1, 'b': 2}.filterKeys((k) => k == 'a'), {'a': 1});
      expect({'a': 1, 'b': 2}.filterValues((v) => v > 1), {'b': 2});
      expect({'a': 1, 'b': 1}.keysOf(1), ['a', 'b']);
      expect({'a': 1}.merge({'b': 2}), {'a': 1, 'b': 2});
    });
  });

  group('Color', () {
    test('colorFromHex', () {
      expect(colorFromHex('#ff2196f3'), const Color(0xFF2196F3));
      expect(colorFromHex('2196f3'), const Color(0xFF2196F3));
      expect(colorFromHex('#f00'), const Color(0xFFFF0000));
      expect(colorFromHex('#8f00'), const Color(0x88FF0000));
      expect(() => colorFromHex('zzz'), throwsFormatException);
    });

    test('darken/lighten/inverse/complementary', () {
      const c = Color(0xFF808080);
      expect(c.darken(1.0), Colors.black);
      expect(c.lighten(1.0), Colors.white);
      expect(const Color(0xFFFF0000).inverse, const Color(0xFF00FFFF));
      // complementary of pure red (hue 0) is cyan (hue 180).
      final comp = const Color(0xFFFF0000).complementary;
      expect(comp.r, closeTo(0.0, 0.01));
      expect(comp.g, closeTo(1.0, 0.01));
      expect(comp.b, closeTo(1.0, 0.01));
    });

    test('hsv getters/toMaterialColor/isTransparent', () {
      final hsv = HSVColor.fromColor(Colors.red);
      expect(Colors.red.hue, closeTo(hsv.hue, 0.001));
      expect(Colors.red.saturation, closeTo(hsv.saturation, 0.001));
      expect(Colors.red.brightness, closeTo(hsv.value, 0.001));
      expect(Colors.red.withBrightness(0.5).brightness, closeTo(0.5, 0.01));
      expect(Colors.red.toMaterialColor(), isA<MaterialColor>());
      expect(Colors.red.toMaterialColor()[500], Colors.red);
      expect(const Color(0x00FFFFFF).isTransparent, isTrue);
    });
  });

  group('File', () {
    test('size helpers', () {
      final dir = Directory.systemTemp.createTempSync('fx_test');
      final f = File('${dir.path}/photo.PNG')
        ..writeAsBytesSync(List.filled(1024, 1));
      expect(f.isImage, isTrue);
      expect(f.isVideo, isFalse);
      expect(f.isAudio, isFalse);
      expect(f.sizeInMB, closeTo(1024 / (1024 * 1024), 0.001));
      final noExt = File('${dir.path}/noext')..writeAsBytesSync([]);
      expect(noExt.isImage, isFalse);
      expect(noExt.readAsStringSafe(), completes);
      dir.deleteSync(recursive: true);
    });
  });

  group('Validators', () {
    test('requiredField', () {
      expect(requiredField(''), isNotNull);
      expect(requiredField('  '), isNotNull);
      expect(requiredField(null), isNotNull);
      expect(requiredField('x'), isNull);
    });

    test('email/phone/length', () {
      expect(emailValidator('test@test.com'), isNull);
      expect(emailValidator('nope'), isNotNull);
      expect(emailValidator(''), isNull);
      expect(phoneValidator('+1234567890'), isNull);
      expect(phoneValidator('abc'), isNotNull);
      expect(minLengthValidator('abc', 5), isNotNull);
      expect(minLengthValidator('abcdef', 5), isNull);
      expect(maxLengthValidator('abcdef', 3), isNotNull);
      expect(maxLengthValidator('abc', 3), isNull);
    });
  });

  group('Widget', () {
    testWidgets('wrappers', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Text('x').margin().background(Colors.red).tooltip('t'),
      ));
      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(ColoredBox), findsAtLeastNWidgets(1));
      expect(find.byType(Tooltip), findsOneWidget);
    });

    testWidgets('visible', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Text('x').visible(false),
      ));
      expect(find.byType(Visibility), findsOneWidget);
      expect(find.text('x'), findsNothing);
    });

    testWidgets('blur/rotated/scaled/size', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('x')
                .visible(true)
                .blur(2)
                .rotated(0.25)
                .scaled(1.5)
                .width(10)
                .height(20),
          ),
        ),
      ));
      expect(find.byType(ImageFiltered), findsOneWidget);
      expect(find.byType(Transform), findsAtLeastNWidgets(2));
      expect(tester.getSize(find.byType(Text)), const Size(10, 20));
    });

    testWidgets('constrained/aspectRatio', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Text('x').constrained(maxWidth: 50).aspectRatio(1),
      ));
      expect(find.byType(ConstrainedBox), findsWidgets);
      expect(find.byType(AspectRatio), findsOneWidget);
    });

    testWidgets('modifiers: padding/border/align/size/opacity/...',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Text('f').flexible(),
              Expanded(
                child: Text('mod')
                    .padding()
                    .border(borderRadius: BorderRadius.circular(4))
                    .center
                    .safeArea()
                    .align()
                    .size(width: 30, height: 30)
                    .opacity(0.5)
                    .circular()
                    .elevated(),
              ),
              Text('e').expanded,
            ],
          ),
        ),
      ));
      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(DecoratedBox), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Expanded), findsNWidgets(2));
      expect(find.byType(Flexible), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Align), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(Opacity), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(Material), findsWidgets);
    });

    testWidgets('gestures and inkWell', (tester) async {
      var taps = 0, lps = 0, dts = 0, inks = 0;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Text('t').onTap(() => taps++),
              Text('l').onLongPress(() => lps++),
              Text('d').onDoubleTap(() => dts++),
              Text('i').inkWell(() => inks++),
            ],
          ),
        ),
      ));
      await tester.tap(find.text('t'));
      await tester.pumpAndSettle();
      expect(taps, 1);
      await tester.longPress(find.text('l'));
      await tester.pumpAndSettle();
      expect(lps, 1);
      await tester.tap(find.text('d'));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(find.text('d'));
      await tester.pumpAndSettle();
      expect(dts, 1);
      await tester.tap(find.text('i'));
      await tester.pumpAndSettle();
      expect(inks, 1);
    });

    testWidgets('onHover/onFocusChange/disabled', (tester) async {
      var hovered = false;
      var focused = false;
      var tapped = 0;
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Text('h').onHover((h) => hovered = h),
              Text('f').onFocusChange((f) => focused = f, focusNode: focusNode),
              TextButton(
                onPressed: () => tapped++,
                child: const Text('b'),
              ).disabled(true),
            ],
          ),
        ),
      ));

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: const Offset(-10, -10));
      await gesture.moveTo(tester.getCenter(find.text('h')));
      await tester.pump();
      expect(hovered, isTrue);
      await gesture.moveTo(const Offset(600, 600));
      await tester.pump();
      expect(hovered, isFalse);

      focusNode.requestFocus();
      await tester.pump();
      expect(focused, isTrue);
      focusNode.unfocus();
      await tester.pump();
      expect(focused, isFalse);

      await tester.tap(find.text('b'));
      await tester.pump();
      expect(tapped, 0);
    });
  });

  group('Navigation', () {
    testWidgets('pushWithSlide and canPop', (tester) async {
      await tester
          .pumpWidget(MaterialApp(home: const Scaffold(body: SizedBox())));
      final context = tester.element(find.byType(Scaffold));
      expect(context.canPop, isFalse);
      context.pushWithSlide(const Scaffold(body: Text('next')));
      await tester.pumpAndSettle();
      expect(find.text('next'), findsOneWidget);
      expect(context.canPop, isTrue);
    });

    testWidgets('showSheet', (tester) async {
      await tester
          .pumpWidget(MaterialApp(home: const Scaffold(body: SizedBox())));
      tester.element(find.byType(Scaffold)).showSheet(const Text('sheet'));
      await tester.pumpAndSettle();
      expect(find.text('sheet'), findsOneWidget);
    });

    testWidgets('navigateAndRestore fires onBack', (tester) async {
      await tester
          .pumpWidget(MaterialApp(home: const Scaffold(body: SizedBox())));
      final context = tester.element(find.byType(Scaffold));
      var back = false;
      context.navigateAndRestore(
        screen: const Scaffold(body: Text('restore')),
        onBack: () => back = true,
      );
      await tester.pumpAndSettle();
      expect(find.text('restore'), findsOneWidget);
      context.navigateBack();
      await tester.pumpAndSettle();
      expect(back, isTrue);
    });

    testWidgets('navigateTo plain and fade', (tester) async {
      await tester
          .pumpWidget(MaterialApp(home: const Scaffold(body: SizedBox())));
      final context = tester.element(find.byType(Scaffold));
      context.navigateTo(screen: const Scaffold(body: Text('plain')));
      await tester.pumpAndSettle();
      expect(find.text('plain'), findsOneWidget);
      context.navigateBack();
      await tester.pumpAndSettle();
      context.navigateTo(
          screen: const Scaffold(body: Text('faded')), fade: true);
      await tester.pumpAndSettle();
      expect(find.text('faded'), findsOneWidget);
    });

    testWidgets('pushWithFade', (tester) async {
      await tester
          .pumpWidget(MaterialApp(home: const Scaffold(body: SizedBox())));
      tester
          .element(find.byType(Scaffold))
          .pushWithFade(const Scaffold(body: Text('pf')));
      await tester.pumpAndSettle();
      expect(find.text('pf'), findsOneWidget);
    });

    testWidgets('replace/removeUntil/clearStack', (tester) async {
      await tester
          .pumpWidget(MaterialApp(home: const Scaffold(body: Text('home'))));
      tester
          .element(find.byType(Scaffold))
          .pushScreen(const Scaffold(body: Text('push1')));
      await tester.pumpAndSettle();
      tester
          .element(find.text('push1'))
          .navigateToReplace(screen: const Scaffold(body: Text('replaced')));
      await tester.pumpAndSettle();
      tester
          .element(find.text('replaced'))
          .replaceScreen(const Scaffold(body: Text('replace2')));
      await tester.pumpAndSettle();
      tester.element(find.text('replace2')).navigateAndRemoveUntil(
          screen: const Scaffold(body: Text('clean')), fade: true);
      await tester.pumpAndSettle();
      expect(find.text('clean'), findsOneWidget);
      tester
          .element(find.text('clean'))
          .clearStackAndShow(const Scaffold(body: Text('cleared')));
      await tester.pumpAndSettle();
      expect(find.text('cleared'), findsOneWidget);
      tester.element(find.text('cleared')).navigateBack();
      await tester.pumpAndSettle();
      expect(find.text('cleared'), findsNothing);
    });

    testWidgets('pop helpers, maybePop, route name', (tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/home',
        routes: {
          '/home': (_) => const Scaffold(body: Text('home')),
          '/a': (_) => const Scaffold(body: Text('a')),
          '/b': (_) => const Scaffold(body: Text('b')),
        },
      ));
      final context = tester.element(find.text('home'));
      expect(context.currentRouteName, '/home');
      Navigator.of(context).pushNamed('/a');
      await tester.pumpAndSettle();
      Navigator.of(context).pushNamed('/b');
      await tester.pumpAndSettle();
      context.popUntilRoute('/a');
      await tester.pumpAndSettle();
      expect(find.text('a'), findsOneWidget);
      context.navigateBack();
      await tester.pumpAndSettle();
      Navigator.of(context).pushNamed('/b');
      await tester.pumpAndSettle();
      context.popToFirst();
      await tester.pumpAndSettle();
      expect(find.text('home'), findsOneWidget);
      context.maybePop();
      await tester.pumpAndSettle();
      expect(find.text('home'), findsOneWidget);
    });

    testWidgets('popWithResult', (tester) async {
      await tester
          .pumpWidget(MaterialApp(home: const Scaffold(body: Text('home'))));
      final context = tester.element(find.byType(Scaffold));
      final future =
          context.pushScreen<int>(const Scaffold(body: Text('pick')));
      await tester.pumpAndSettle();
      tester.element(find.text('pick')).popWithResult(42);
      await tester.pumpAndSettle();
      expect(await future, 42);
      expect(find.text('home'), findsOneWidget);
    });
  });

  group('Number formatting', () {
    test('toPercentage', () {
      expect(100.toPercentage(), '100%');
      expect(0.toPercentage(), '0%');
      expect(10.toPercentage(), '10%');
      expect(55.5.toPercentage(decimals: 1), '55.5%');
      expect(12.34.toPercentage(decimals: 2), '12.34%');
    });

    test('toDecimal', () {
      expect(1.5.toDecimal(decimals: 3), '1.500');
      expect(1234.567.toDecimal(decimals: 3), '1,234.567');
      expect(2.toDecimal(decimals: 0), '2');
    });

    test('toCurrency/toCompact', () {
      expect(1234.5.toCurrency(), '\$1,234.50');
      expect(9800000.toCompact(), '9.8M');
    });

    test('duration getters', () {
      expect(5.seconds, const Duration(seconds: 5));
      expect(2.minutes, const Duration(minutes: 2));
      expect(3.hours, const Duration(hours: 3));
      expect(1.days, const Duration(days: 1));
      expect(100.milliseconds, const Duration(milliseconds: 100));
    });

    test('radians/degrees/isBetween', () {
      expect(180.toRadians, closeTo(pi, 1e-9));
      expect(pi.toDegrees, closeTo(180, 1e-9));
      expect(5.isBetween(1, 10), isTrue);
      expect(0.isBetween(1, 10), isFalse);
    });
  });

  group('Double', () {
    test('toFixed/lerp', () {
      expect(3.14159.toFixed(2), 3.14);
      expect(0.0.lerp(10.0, 0.25), 2.5);
    });
  });

  group('String extras', () {
    test('truncate', () {
      expect('abcdef'.truncate(3), 'abc...');
      expect('ab'.truncate(5), 'ab');
      expect('abcdef'.truncate(0), '...');
    });

    test('toTitleCase collapses whitespace', () {
      expect('  hello   world '.toTitleCase(), 'Hello World');
    });

    test('isStrongPassword options', () {
      expect(
        'Abcdefgh'.isStrongPassword(requireDigit: false, requireSpecial: false),
        isTrue,
      );
      expect('abcdefgh'.isStrongPassword(), isFalse);
    });
  });

  group('Iterable extras', () {
    test('sumBy/averageBy/groupBy', () {
      expect([1, 2, 3].sumBy((n) => n * 2), 12);
      expect([1, 2, 3].averageBy((n) => n), 2.0);
      expect(<int>[].averageBy((n) => n), 0);
      expect(
        ['a', 'bb', 'c'].groupBy((s) => s.length),
        {
          1: ['a', 'c'],
          2: ['bb'],
        },
      );
    });

    test('containsAny/flatten empty', () {
      expect([1, 2].containsAny([5, 2]), isTrue);
      expect(<List<int>>[].flatten(), isEmpty);
    });

    test('minBy/maxBy throw on empty', () {
      expect(['bb', 'a', 'ccc'].minBy((s) => s.length), 'a');
      expect(['bb', 'a', 'ccc'].maxBy((s) => s.length), 'ccc');
      expect(() => <int>[].minBy((n) => n), throwsStateError);
      expect(() => <int>[].maxBy((n) => n), throwsStateError);
    });

    test('frequency/none/union/intersection/difference', () {
      expect(['a', 'b', 'a'].frequency(), {'a': 2, 'b': 1});
      expect(<int>[].frequency(), isEmpty);
      expect([1, 2, 3].none((n) => n > 5), isTrue);
      expect([1, 2, 3].none((n) => n < 0), isTrue);
      expect([1, 2].none((n) => n == 2), isFalse);
      expect([1, 2].union([2, 3]), [1, 2, 3]);
      expect([1, 2, 2].intersection([2, 3]), [2]);
      expect([1, 2].difference([2, 3]), [1]);
    });
  });

  group('List extras', () {
    test('takeFirst/takeLast/chunked', () {
      final list = [1, 2, 3, 4, 5];
      expect(list.takeFirst(2), [1, 2]);
      expect(list.takeLast(2), [4, 5]);
      expect(list.takeFirst(99), list);
      expect(list.chunked(2), [
        [1, 2],
        [3, 4],
        [5],
      ]);
      expect(list.chunked(0), isEmpty);
    });

    test('whereNotNull narrows to non-null type', () {
      final List<int> result = [1, null, 2].whereNotNull();
      expect(result, [1, 2]);
    });

    test('isNullOrEmpty on nullable iterable', () {
      List<int>? list;
      expect(list.isNullOrEmpty, isTrue);
      expect(<int>[].isNullOrEmpty, isTrue);
      expect([1].isNullOrEmpty, isFalse);
    });

    test('safeGet/hasUnique/distinct/mapToList/reversedList', () {
      expect([1, 2].safeGet(5), isNull);
      expect([1, 2].safeGet(-1), isNull);
      expect([1, 1, 2].hasUniqueElements(), isFalse);
      expect([1, 1, 2].distinct(), [1, 2]);
      expect([1, 2].mapToList((n) => n + 1), [2, 3]);
      expect([1, 2].reversedList(), [2, 1]);
    });
  });

  group('Map extras', () {
    test('getOrElse distinguishes null values', () {
      final map = <String, int?>{'a': null};
      expect(map.getOrElse('a', 1), isNull);
      expect(map.getOrElse('b', 1), 1);
    });

    test('deepMerge nested maps', () {
      final a = <String, dynamic>{
        'x': {'a': 1, 'b': 2},
      };
      final b = <String, dynamic>{
        'x': {'b': 9, 'c': 3},
        'y': 1,
      };
      expect(a.deepMerge(b), {
        'x': {'a': 1, 'b': 9, 'c': 3},
        'y': 1,
      });
    });

    test('pick/omit/where filters', () {
      final map = {'a': 1, 'b': 2, 'c': 3};
      expect(map.pick(['a', 'c', 'z']), {'a': 1, 'c': 3});
      expect(map.omit(['b']), {'a': 1, 'c': 3});
      expect(map.where((k, v) => v.isEven), {'b': 2});
      expect(map.filterKeys((k) => k != 'a'), {'b': 2, 'c': 3});
      expect(map.filterValues((v) => v > 1), {'b': 2, 'c': 3});
    });

    test('mapKeys/mapValues/invert/merge/getOrPut/keysOf', () {
      final map = {'a': 1, 'b': 2};
      expect(map.mapKeys((k) => k.toUpperCase()), {'A': 1, 'B': 2});
      expect(map.mapValues((v) => v * 10), {'a': 10, 'b': 20});
      expect(map.invert(), {1: 'a', 2: 'b'});
      expect(map.merge({'b': 9, 'c': 3}), {'a': 1, 'b': 9, 'c': 3});
      expect(map.keysOf(2), ['b']);
      final mutable = <String, int>{};
      expect(mutable.getOrPut('k', () => 5), 5);
      expect(mutable.getOrPut('k', () => 9), 5);
    });
  });

  group('Color extras', () {
    test('toMaterialColor light/dark direction', () {
      const base = Color(0xFF2196F3);
      final swatch = base.toMaterialColor();
      expect(swatch[500], base);
      expect(
        swatch[50]!.computeLuminance(),
        greaterThan(swatch[500]!.computeLuminance()),
      );
      expect(
        swatch[900]!.computeLuminance(),
        lessThan(swatch[500]!.computeLuminance()),
      );
    });
  });

  group('Icon', () {
    test('withColor/withSize', () {
      const icon = Icon(Icons.star, size: 20, color: Colors.black);
      expect(icon.withColor(Colors.red).color, Colors.red);
      expect(icon.withSize(48).size, 48);
      expect(icon.withSize(48).color, Colors.black);
    });
  });

  group('TextStyle', () {
    test('chainable modifiers', () {
      expect(const TextStyle().size(20).fontSize, 20);
      expect(const TextStyle().bold.fontWeight, FontWeight.bold);
      expect(const TextStyle().italic.fontStyle, FontStyle.italic);
      expect(const TextStyle().underline.decoration, TextDecoration.underline);
      expect(const TextStyle(fontSize: 10).scaleSize(2).fontSize, 20);
      expect(const TextStyle().withShadow().shadows, hasLength(1));
      expect(const TextStyle().glow(spread: 2).shadows, hasLength(2));
      expect(const TextStyle().outlined().foreground, isNotNull);
      expect(const TextStyle().lineHeight(1.5).height, 1.5);
    });

    test('weight/decoration/merge/shadow extras', () {
      expect(const TextStyle().weight(FontWeight.w700).fontWeight,
          FontWeight.w700);
      expect(const TextStyle().semiBold.fontWeight, FontWeight.w600);
      expect(const TextStyle().light.fontWeight, FontWeight.w300);
      expect(const TextStyle().medium.fontWeight, FontWeight.w500);
      expect(
          const TextStyle().lineThrough.decoration, TextDecoration.lineThrough);
      expect(const TextStyle().overline.decoration, TextDecoration.overline);
      expect(const TextStyle().noDecoration.decoration, TextDecoration.none);
      expect(
        const TextStyle(fontSize: 10).mergeWith(const TextStyle(fontSize: 12)),
        isA<TextStyle>(),
      );
      expect(const TextStyle().mergeWith(null), isA<TextStyle>());
      expect(const TextStyle().withShadows(const [Shadow()]).shadows,
          hasLength(1));
    });

    testWidgets('responsiveSize uses screen width', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (c) {
          context = c;
          return const SizedBox();
        }),
      ));
      expect(
          const TextStyle(fontSize: 10).responsiveSize(context, 0.01).fontSize,
          8.0);
    });
  });

  group('BuildContext', () {
    testWidgets('media/theme/device', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (c) {
          context = c;
          return const SizedBox();
        }),
      ));
      expect(context.screenSize, const Size(800, 600));
      expect(context.isLandscape, isTrue);
      expect(context.isTablet, isTrue);
      expect(context.isMobile, isFalse);
      expect(context.textDirection, TextDirection.ltr);
      expect(context.locale.languageCode, 'en');
      expect(context.isDarkMode, isFalse);
      expect(context.isLightMode, isTrue);
      expect(context.mediaQuery, isA<MediaQueryData>());
      expect(context.safePadding, isA<EdgeInsets>());
      expect(context.textScaler.scale(10), 10);
      expect(context.devicePixelRatio, greaterThan(0));
    });

    testWidgets('additional getters and breakpoints', (tester) async {
      late BuildContext context;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetDevicePixelRatio);
      Future<void> pump(Size size) async {
        tester.view.physicalSize = size;
        await tester.pumpWidget(MaterialApp(
          home: Builder(builder: (c) {
            context = c;
            return const SizedBox();
          }),
        ));
      }

      await pump(const Size(1280, 900));
      expect(context.isDesktop, isTrue);
      expect(context.screenHeight, 900);
      expect(context.orientation, Orientation.landscape);
      expect(context.isPortrait, isFalse);
      expect(context.theme, isA<ThemeData>());
      expect(context.textTheme, isA<TextTheme>());
      expect(context.colorScheme, isA<ColorScheme>());
      expect(context.primaryColor, isA<Color>());
      expect(context.accentColor, isA<Color>());
      expect(context.scaffoldBackgroundColor, isA<Color>());
      expect(context.iconTheme, isA<IconThemeData>());
      expect(context.viewInsets, isA<EdgeInsets>());
      expect(context.viewPadding, isA<EdgeInsets>());
      context.hideKeyboard();

      await pump(const Size(400, 800));
      expect(context.isMobile, isTrue);
      expect(context.isPortrait, isTrue);
      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('Platform', () {
    testWidgets('runtime and target flags', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (c) {
          context = c;
          return const SizedBox();
        }),
      ));
      final runtime = context.platform;
      expect(runtime, isA<PlatformInfo>());
      final runtimeFlags = [
        runtime.isWeb,
        runtime.isAndroid,
        runtime.isIOS,
        runtime.isMacOS,
        runtime.isWindows,
        runtime.isLinux,
        runtime.isFuchsia,
      ];
      expect(runtimeFlags.where((flag) => flag), hasLength(1));

      final target = context.targetPlatform;
      expect(target, isA<TargetPlatformInfo>());
      final targetFlags = [
        target.isAndroid,
        target.isFuchsia,
        target.isIOS,
        target.isLinux,
        target.isMacOS,
        target.isWindows,
      ];
      expect(targetFlags.where((flag) => flag), hasLength(1));
    });
  });

  group('State', () {
    testWidgets('safeSetState', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: _Counter()));
      expect(find.text('count: 0'), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('count: 1'), findsOneWidget);
    });
  });

  group('Snackbar & Dialog', () {
    testWidgets('showSnackBar/removeSnackBar', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (c) {
          context = c;
          return const Scaffold(body: SizedBox());
        }),
      ));
      context.showSnackBar('hello');
      await tester.pump();
      expect(find.text('hello'), findsOneWidget);
      context.removeSnackBar();
      await tester.pumpAndSettle();
      expect(find.text('hello'), findsNothing);
    });

    testWidgets('showCusDialog/showAppDialog', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (c) {
          context = c;
          return const Scaffold(body: SizedBox());
        }),
      ));
      context.showCusDialog(const AlertDialog(content: Text('custom')));
      await tester.pumpAndSettle();
      expect(find.text('custom'), findsOneWidget);
      context.navigateBack();
      await tester.pumpAndSettle();
      context.showAppDialog(title: 'T', content: const Text('body'));
      await tester.pumpAndSettle();
      expect(find.text('T'), findsOneWidget);
      expect(find.text('body'), findsOneWidget);
    });
  });

  group('Image', () {
    testWidgets('toBase64', (tester) async {
      final bytes = base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJ'
        'AAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
      );
      final image = Image(image: MemoryImage(bytes));
      await tester.pumpWidget(MaterialApp(home: image));
      final encoded = await tester.runAsync(() => image.toBase64());
      expect(encoded, isNotEmpty);
    });

    testWidgets('toBase64 error path and withFilter', (tester) async {
      final bad = Image(image: MemoryImage(base64Decode('')));
      final result = await tester.runAsync(() => bad.toBase64().then(
            (_) => 'ok',
            onError: (Object e) => 'err',
          ));
      expect(result, 'err');
      tester.takeException();

      final bytes = base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJ'
        'AAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
      );
      final filtered = Image(image: MemoryImage(bytes))
          .withFilter(const ColorFilter.mode(Colors.red, BlendMode.srcIn));
      await tester.pumpWidget(MaterialApp(home: filtered));
      expect(find.byType(ColorFiltered), findsOneWidget);
    });
  });

  group('DateTime relative', () {
    testWidgets('timeAgo/formattedDate', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (c) {
          context = c;
          return const SizedBox();
        }),
      ));
      expect(
        DateTime.now().subtract(const Duration(minutes: 5)).timeAgo(context),
        '5 minutes ago',
      );
      expect(
        DateTime.now().subtract(const Duration(days: 3)).timeAgo(context),
        '3 days ago',
      );
      expect(
        DateTime.now().subtract(const Duration(hours: 3)).timeAgo(context),
        '3 hours ago',
      );
      expect(
        DateTime.now().subtract(const Duration(days: 10)).timeAgo(context),
        startsWith('20'),
      );
      expect(DateTime.now().timeAgo(context), 'Just now');
      expect(
        DateTime(2025, 1, 2).formattedDate(context, pattern: 'yyyy-MM-dd'),
        '2025-01-02',
      );
    });
  });
}

class _Counter extends StatefulWidget {
  const _Counter();

  @override
  State<_Counter> createState() => _CounterState();
}

class _CounterState extends State<_Counter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('count: $_count'),
            ElevatedButton(
              onPressed: () => safeSetState(() => _count++),
              child: const Text('inc'),
            ),
          ],
        ),
      ),
    );
  }
}
