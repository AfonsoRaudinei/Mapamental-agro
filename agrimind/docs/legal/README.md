# Páginas legais — AgriMind

Arquivos estáticos para App Store e Google Play:

| Arquivo | URL de produção |
|---------|-----------------|
| `privacidade.html` | `https://cultivamind.com/privacidade` |
| `termos.html` | `https://cultivamind.com/termos` |

## Publicar no domínio

Faça upload dos HTML para o host de `cultivamind.com`, mantendo os caminhos acima.

Exemplo com SCP (ajuste usuário/host):

```sh
scp docs/legal/privacidade.html user@cultivamind.com:/var/www/cultivamind/privacidade/index.html
scp docs/legal/termos.html user@cultivamind.com:/var/www/cultivamind/termos/index.html
```

## Preview local

```sh
cd agrimind/docs/legal
python3 -m http.server 8080
# http://localhost:8080/privacidade.html
```

## Build com URL alternativa (staging)

```sh
flutter run \
  --dart-define=PRIVACY_POLICY_URL=http://localhost:8080/privacidade.html \
  --dart-define=TERMS_URL=http://localhost:8080/termos.html
```

## Verificação

1. Abra Configurações → Termos / Privacidade no app.
2. Toque em **Abrir versão online** — deve abrir o navegador na URL configurada.
3. Confirme HTTP 200 nas URLs de produção antes de submeter às lojas.
