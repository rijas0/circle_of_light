# AGENTS.md

## Project

Flutter app (SDK ^3.11.0) — "Circle of Light", a social Quran accountability platform.

## Commands

```bash
flutter pub get           # install deps
dart run build_runner build -d  # generate Riverpod providers (required after adding/changing providers)
flutter run               # run on connected device/emulator
flutter test              # run all tests
flutter analyze           # lint (uses flutter_lints)
```

**Always run `build_runner` before `flutter run` if you touch any `@riverpod` annotations.**

## Architecture

**Entry point:** `lib/main.dart` → `lib/app/app.dart` (bootstraps `MaterialApp`, home = `LoginScreen`)

**Navigation:** Currently uses `AppShell` (`lib/app/app_shell.dart`) with `IndexedStack` + bottom `NavigationBar`. 4 tabs: Dashboard, Circles, Reflections, Profile. `go_router` is in `pubspec.yaml` but not yet wired in.

**State management:** Riverpod with `riverpod_generator`. Generated files live alongside sources as `.g.dart` (e.g., `foo.g.dart`). Never edit `.g.dart` files manually.

**Feature structure** (feature-first, not layer-first):
```
lib/features/{feature}/
  data/          # models, API calls, repos
  domain/        # entities, contracts
  presentation/  # pages, widgets, state
```

**Current features:** `auth/`, `check_ins/`, `circles/`, `dashboard/`, `profile/`, `reflections/`, `settings/`

**Backend:** Supabase (`supabase` package). HTTP via `dio`.

**Theme:** `lib/core/theme/app_theme.dart` — light theme only currently. Font: Noto Sans Arabic.

## Testing

Single test file: `test/widget_test.dart` — smoke test for app shell rendering.
Run: `flutter test`

## Conventions

- Feature-first organization; keep layers within each feature.
- Use `go_router` for any new routing (it's already a dependency).
- Reusable UI goes in `lib/shared/widgets/`.
- App-level constants in `lib/core/constants/`.
