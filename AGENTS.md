# AGENTS.md

## What this is

`extensions_core` — a dependency-light collection of Dart & Flutter extensions (strings, numbers, dates, collections, colors, widgets, navigation, validators, ...). Dart `^3.6.0`, Flutter `>=3.27.0`. Only runtime dep: `intl`. Lint baseline: `flutter_lints` (via `analysis_options.yaml`).

## Commands (run from this dir)

```sh
flutter pub get
flutter analyze
dart format --output=none --set-exit-if-changed .
flutter test
```

## Layout conventions

- New extensions go in a **focused file per type** in `lib/extensions/<type>.dart` (e.g. `lib/extensions/strings.dart`, `lib/extensions/color.dart`), then must be **added as an `export` in `lib/extensions.dart`** — that barrel file is the public API and currently lists every extension file explicitly. New files are not exported automatically.
- Tests live in `test/extensions_test.dart` (single file). Add tests there when adding extensions.
- README + `CHANGELOG.md` document every user-visible extension; keep them updated for new additions.
- Follow the Dart style guide and keep the package lint-clean (`flutter analyze` + format check pass).

## Gotchas

- Extensions extending `BuildContext`/`Widget`/`State` are Flutter-only; keep pure Dart extensions (strings, numbers, dates, collections) free of Flutter imports so the library stays usable outside widgets.
- `state.dart` (`safeSetState`) and `theme.dart` depend on Flutter widget lifecycle; don't assume `context` availability in pure-Dart helpers.
