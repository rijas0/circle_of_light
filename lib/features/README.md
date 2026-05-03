# Feature Organization

Each feature should keep its own layers close together:

- `data/` for models, APIs, and repository implementations
- `domain/` for entities and contracts
- `presentation/` for pages, widgets, and state handling

Suggested growth path for Circle of Light:

- `auth/` for onboarding, sign-in, and member access control
- `circles/` for group management and invitations
- `check_ins/` for daily participation flows
- `reflections/` for verse reflections and reactions
- `settings/` for preferences, notifications, and privacy
