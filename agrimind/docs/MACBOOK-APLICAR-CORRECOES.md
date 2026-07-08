# Aplicar correções no MacBook (Cursor Alberto)

Guia para puxar widgets base do repo e corrigir telas locais de laboratório e análise de solo.

## 1. Atualizar repo

```sh
cd ~/Projects/Mapamental-agro   # ajuste o caminho
git pull origin cursor/macbook-lab-dark-fixes-7428   # ou main após merge
cd agrimind
```

### Flutter no Mac (obrigatório)

Se `flutter: command not found`:

```sh
# Verifique onde está o Flutter:
ls ~/flutter/bin/flutter 2>/dev/null
ls .fvm/flutter_sdk/bin/flutter 2>/dev/null
which flutter 2>/dev/null

# Adicione ao PATH (escolha o que existir no seu Mac):
export PATH="$HOME/flutter/bin:$PATH"
# ou FVM:
export PATH="$PWD/.fvm/flutter_sdk/bin:$PATH"
# ou Homebrew:
export PATH="/opt/homebrew/bin:$PATH"

flutter doctor
```

Validação automática (detecta Flutter sozinho):

```sh
bash ../scripts/validate-ui.sh
```

## 2. Substituir padrões bugados

### Botão "Voltar para plantio" (Análise de Solo)

**Buscar no Mac:**
```sh
grep -r "Voltar para plantio" lib/
```

**Substituir** o `TextButton`/`GestureDetector` local por:

```dart
import 'package:agrimind/core/widgets/primary_back_link.dart';

// ...
PrimaryBackLink(label: 'Voltar para plantio')
```

### AppBar com chevron ilegível (Novo Template, Modelos de Lab, Sellar)

**Buscar:**
```sh
grep -r "Novo Template\|Modelos de Laboratório" lib/
```

**Substituir** `AppBar(` por:

```dart
import 'package:agrimind/core/widgets/dark_app_bar.dart';

// ...
appBar: DarkAppBar(title: 'Novo Template'),
```

### Cards pretos (#000) na lista de templates

**Buscar:**
```sh
grep -rn "Color(0xFF000000)\|Colors.black" lib/features/
```

**Substituir** cards manuais por:

```dart
import 'package:agrimind/core/widgets/lab_template_card.dart';

LabTemplateCard(
  title: 'K, Ca, Mg: cmolc/dm³ · M.O.: g/dm³',
  badgeLabel: 'Padrão',
  onTap: () => ...,
)
```

### Dropdowns ilegíveis (Unidades Padrão)

**Substituir** `DropdownButtonFormField` local por:

```dart
import 'package:agrimind/core/widgets/dark_dropdown_field.dart';

DarkDropdownField<String>(
  value: selectedUnit,
  items: units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
  onChanged: (v) => setState(() => selectedUnit = v),
)
```

## 3. Validar no Mac

```sh
flutter analyze
flutter test
```

Abrir simulador iOS e conferir:

- [ ] "Voltar para plantio" legível (azul #3B82F6)
- [ ] Cards de template em #1E1E1E, não preto puro
- [ ] Dropdowns com texto branco/azul sobre fundo #2D2D2D
- [ ] Chevron voltar azul e clicável

## 4. Commit no Mac

```sh
git add lib/
git commit -m "fix(ui): corrige modo black em templates de lab e botão voltar"
git push origin main
```

## Referências

- Agente designer: `.agents/dark-mode-designer.md`
- Workflow MacBook: `.agents/macbook-first-workflow.md`
