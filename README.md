# Circle of Light

A Flutter starter scaffold for **Circle of Light**, a social accountability platform for Quran engagement.

## Project Goal

This repository starts with a clean, scalable Flutter structure designed for a hackathon build that can later grow into a production-ready app.

## Recommended Flutter Structure

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

## Next Suggested Steps

1. Add state management for check-ins and reflections.
2. Connect authentication and realtime backend services.
3. Replace sample data with repositories backed by Supabase or Firebase.
