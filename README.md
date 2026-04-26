# Circle of Light

Circle of Light is a private, community-driven mobile application designed to help individuals build a consistent relationship with the Quran through shared accountability and reflection.
Instead of approaching Quran engagement as a solitary activity, the platform transforms it into a collective daily habit, where small groups support, motivate, and grow together.

## Project Structure

```text
lib/
  app/                  # App entry, shell, routing bootstrap
  core/                 # Theme, constants, shared app-level concerns
  shared/               # Reusable widgets used across features
  features/
    auth/               # Sign in, onboarding, access control
    circles/            # Group creation, invites, circle management
    check_ins/          # Daily read / reflect flows
    reflections/        # Reflection feed and reactions
    profile/            # User profile and progress summary
    settings/           # Preferences, privacy, notifications
```

## Why This Structure

- Keeps business logic grouped by feature instead of by technical type alone
- Makes it easier to scale with teams during a hackathon or after submission
- Supports adding `data`, `domain`, and `presentation` layers gradually
- Prevents `lib/` from becoming a flat collection of unrelated files

## Getting Started

```bash
flutter pub get
flutter run
```
