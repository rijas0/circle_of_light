# Circle of Light

Flutter mobile app for Quran accountability circles.

## Commands

- `flutter run` - Run on device/emulator
- `flutter test` - Run widget tests
- `flutter pub get` - Install dependencies

## Structure

```
lib/
  app/           # App entry
  core/          # Theme, colors, constants
  shared/        # Reusable widgets
  features/      # Feature modules (auth, circles, check_ins, reflections, profile, dashboard, settings)
```

## Notes

- Single-package Flutter (no monorepo)
- Bundled assets: Noto Sans Arabic fonts in `assets/fonts/`
- Entry: `lib/main.dart` → `lib/app/app.dart`
- Test: `test/widget_test.dart` verifies shell renders