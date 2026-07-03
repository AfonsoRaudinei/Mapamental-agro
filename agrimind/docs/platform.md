# Platform IDs — AgriMind

| Plataforma | Bundle / Package | Notas |
|------------|------------------|-------|
| iOS | `com.cultivamind.agrimind` | Runner target |
| Android | `com.cultivamind.agrimind` | `MainActivity.kt` |
| macOS | `com.cultivamind.agrimind` | Runner |
| Web | — | `agrimind` project name |

## Tema padrão

- **Dark Black** — ver `.agents/dark-mode-designer.md`
- SharedPreferences key: `app_theme`
- Valores: `darkBlack` (default) | `light`
- Legado SoloForte: `dark` → `darkBlack`, `blue`/`green` → `light`

## Banco local

- Arquivo: `agrimind.db` (SQLite via sqflite)
- Path: platform default (`getDatabasesPath()`)
