import 'dart:io';

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
      expect(DateTime(2025, 6, 15, 12).isBetween(now, DateTime(2025, 6, 16)), isTrue);
      expect(DateTime(2025, 6, 17).isBetween(now, DateTime(2025, 6, 16)), isFalse);
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
  });

  group('Duration', () {
    test('inWeeks/format', () {
      expect(const Duration(days: 14).inWeeks, 2);
      expect(const Duration(hours: 2, minutes: 3, seconds: 45).format(), '2:03:45');
      expect(const Duration(seconds: 5).format(), '0:00:05');
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
        [{'id': 1}, {'id': 1}, {'id': 2}].distinctBy((e) => e['id']).length,
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
      expect([
        [1, 2],
        [3],
        <int>[]
      ].flatten(), [1, 2, 3]);
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

  group('EdgeInsets', () {
    test('copyWith', () {
      const e = EdgeInsets.fromLTRB(1, 2, 3, 4);
      expect(e.copyWith(left: 10), const EdgeInsets.fromLTRB(10, 2, 3, 4));
      expect(e.copyWith(top: 20, bottom: 30), const EdgeInsets.fromLTRB(1, 20, 3, 30));
      expect(e.copyWith(), e);
    });
  });

  group('File', () {
    test('size helpers', () {
      final dir = Directory.systemTemp.createTempSync('fx_test');
      final f = File('${dir.path}/photo.PNG')..writeAsBytesSync(List.filled(1024, 1));
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
            child: Text('x').visible(true).blur(2).rotated(0.25).scaled(1.5).width(10).height(20),
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
  });

  group('Navigation', () {
    testWidgets('pushWithSlide and canPop', (tester) async {
      await tester.pumpWidget(MaterialApp(home: const Scaffold(body: SizedBox())));
      final context = tester.element(find.byType(Scaffold));
      expect(context.canPop, isFalse);
      context.pushWithSlide(const Scaffold(body: Text('next')));
      await tester.pumpAndSettle();
      expect(find.text('next'), findsOneWidget);
      expect(context.canPop, isTrue);
    });

    testWidgets('showSheet', (tester) async {
      await tester.pumpWidget(MaterialApp(home: const Scaffold(body: SizedBox())));
      tester.element(find.byType(Scaffold)).showSheet(const Text('sheet'));
      await tester.pumpAndSettle();
      expect(find.text('sheet'), findsOneWidget);
    });
  });
}
