# Contributing

Thanks for helping improve `extensions_core`. This package is published to
pub.dev, so the public API and docs are part of the product.

## Setup

```sh
flutter pub get
```

## Before every commit

These are the only gate (there is no other CI locally):

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

Optionally, check the pub.dev score locally:

```sh
dart pub publish --dry-run
```

## Adding an extension

1. Add it to the focused file for its type in `lib/extensions/` (one file per
   type, e.g. `strings.dart`, `number.dart`).
2. Export the file from `lib/extensions.dart` (new files are **not** exported
   automatically).
3. Add tests in `test/extensions_test.dart` — one `group` per type, `test()`
   for pure logic and `testWidgets()` for widget/context/navigation code.
4. Update `README.md` and `CHANGELOG.md` for user-visible changes.
5. Doc-comment every public member (`///`); `dart pub publish --dry-run`
   warns on undocumented API.

## Conventions

- Keep pure-Dart extensions (strings, numbers, dates, collections) free of
  Flutter imports so the library stays usable outside widgets.
- Color math must use the `a`/`r`/`g`/`b` accessors (Flutter >= 3.27
  wide-gamut API), never the deprecated `alpha`/`red`/`green`/`blue`.
- Keep `dart:io` behind conditional imports and guard platform-specific code
  with `kIsWeb`.
- Do not add runtime dependencies casually; `intl` is the only one.

See `AGENTS.md` for the full project brief.

## Releasing (maintainers)

1. Bump `version:` in `pubspec.yaml` and add a `CHANGELOG.md` entry
   (Added/Changed/Fixed/Tests).
2. Commit as `vX.Y.Z - summary`.
3. Run `dart pub publish --dry-run`, then publish.
