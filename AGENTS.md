# AGENTS.md

## What this is

`extensions_core` — a dependency-light collection of Dart & Flutter extensions (strings, numbers, dates, collections, colors, widgets, navigation, validators, ...). Dart `^3.6.0`, Flutter `>=3.27.0`. Only runtime dep: `intl`. Lint baseline: `flutter_lints` (via `analysis_options.yaml`). Published to pub.dev, so the public API surface is the product — code style matters as much as behavior.

## Commands (run from this dir — these are your CI, there is no `.github` workflow)

```sh
flutter pub get
flutter analyze      # lints via flutter_lints; currently clean
dart format --output=none --set-exit-if-changed lib test
flutter test         # single file test/extensions_test.dart
flutter test --plain-name 'Map'   # run one group by name
dart pub publish --dry-run        # pre-release sanity check (undocumented-API warnings)
```

Run `flutter analyze` and `flutter test` before every commit; they are the only gate.

## Layout conventions

- New extensions go in a **focused file per type** in `lib/extensions/<type>.dart` (e.g. `lib/extensions/strings.dart`, `lib/extensions/color.dart`; `double.dart` is separate from `number.dart`), then must be **added as an `export` in `lib/extensions.dart`** — that barrel file is the public API and lists every extension file explicitly. New files are not exported automatically.
- Tests live in `test/extensions_test.dart` (single file, one `group` per type; `test()` for pure logic, `testWidgets()` for widget/context/navigation). Add tests there when adding extensions.
- README + `CHANGELOG.md` document every user-visible extension; keep them updated for new additions. Enforced by convention, not automation.
- Follow the Dart style guide and keep the package lint-clean (`flutter analyze` + format check pass).

## Test layout

- `File` group builds temp dirs via `dart:io`; platform behavior stays behind `kIsWeb` checks — don't write platform assumptions not guarded that way.

## Gotchas

- Color math must use the `a`/`r`/`g`/`b` accessors (Flutter >=3.27 wide-gamut API). The old `alpha`/`red`/`green`/`blue` math returns wrong hex (broke in v0.0.4). Verify hex output against the known-good tests.
- Extensions extending `BuildContext`/`Widget`/`State` are Flutter-only; keep pure Dart extensions (strings, numbers, dates, collections) free of Flutter imports so the library stays usable outside widgets.
- `state.dart` (`safeSetState`) and `theme.dart` depend on Flutter widget lifecycle; don't assume `context` availability in pure-Dart helpers.
- `dart:io` imports in `file.dart`/`platform.dart` mean tests run on the VM; keep `kIsWeb` guards on anything platform-specific.
- `flutter analyze` does **not** catch formatting. Keep files formatted — `dart format --output=none --set-exit-if-changed lib test` should exit 0.
- `pubspec.lock` and `build/` are gitignored (Dart library convention) — never commit them. After `pub get`, a dirty lock is expected; don't stage it.
- Do not add runtime dependencies casually; `intl` is the only one and the README markets "dependency-light". Prefer the stdlib/`dart:math`/`intl` before a package.
- Keep public members doc-commented (`///`). `dart pub publish --dry-run` warns on undocumented API, and poor dartdoc hurts pub.dev discoverability.

## Release flow (manual)

1. Bump `version:` in `pubspec.yaml` + add a `CHANGELOG.md` head entry with Added/Changed/Fixed/Tests sections.
2. Commit with the repo's style: `vX.Y.Z - summary` (see `git log`). At `0.1.x`, additions ship as patch bumps; breaking changes as minor.
3. PR → push to `origin` (github.com/LeanQChris/extensions.git). Run `dart pub publish --dry-run` first.
