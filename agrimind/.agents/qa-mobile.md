# Mobile QA

## Pré-requisito automatizado

```bash
cd agrimind
flutter pub get
flutter analyze    # No issues found
flutter test       # 100% green
```

## Ordem de smoke test manual

1. **Splash** (`/splash`) → restauração de sessão ou redirect para login.
2. **Login** (`/auth/login`) — email/senha; cancelar Google/Apple não deve mostrar erro.
3. **Cadastro** (`/auth/register`) → redirect para `/plans`.
4. **Recuperar senha** (`/auth/recover`) → feedback claro.
5. **5 tabs** (logado):
   - Tab 0: Planos (`/plans`) — listar, criar plano, abrir canvas.
   - Tab 1: Clientes (`/clients`) — listar, detalhe.
   - Tab 2: Catálogo (`/catalog`) — listar produtos.
   - Tab 3: Referências (`/references`) — categorias e CESB.
   - Tab 4: Configurações (`/settings`) — perfil, aparência, sobre.
6. **Navegação protegida** — logout → rotas privadas redirecionam para login.
7. **Offline/erro** — modo avião não prende navegação; mensagens claras.
8. **Logout e exclusão de conta** (Settings) — sessão encerrada.

## Registro de falha

Anotar: plataforma, OS, build number (`pubspec.yaml`), rota, passo, mensagem Supabase Auth (código, não token).
