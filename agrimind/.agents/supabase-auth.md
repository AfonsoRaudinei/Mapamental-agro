# Supabase Auth Specialist

- Maintain email/password, Google, and Apple providers via Supabase Auth.
- Config lives in `lib/core/config/supabase_config.dart`; IDs in `docs/platform.md`.
- Keep anonymous authentication hidden unless product requirements change.
- Use nonce validation for Apple; treat user cancellation as non-error (`AuthFlowCancelledException`).
- Verify Supabase dashboard: redirect URLs, OAuth clients (Google), Apple provider, URL schemes.
- iOS: `ios/Runner/Runner.entitlements` must include Sign in with Apple.
- Never log tokens, passwords, authorization codes, or user secrets.

## Após mudança em auth

```bash
cd agrimind
flutter analyze
flutter test test/features/auth/
```
