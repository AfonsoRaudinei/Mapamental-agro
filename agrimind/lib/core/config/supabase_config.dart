abstract final class SupabaseConfig {
  static const url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://wugqcowsujyrspkbupxq.supabase.co',
  );

  static const publishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  static void validate() {
    if (publishableKey.isEmpty) {
      throw StateError(
        'SUPABASE_PUBLISHABLE_KEY não informada. Use '
        '--dart-define=SUPABASE_PUBLISHABLE_KEY=<chave-publica>.',
      );
    }
  }
}
