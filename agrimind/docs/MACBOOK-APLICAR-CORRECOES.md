# Aplicar correções no MacBook (Cursor Alberto)

Guia para puxar widgets base do repo e corrigir telas locais de laboratório e análise de solo.

## 1. Atualizar repo

### ⚠️ `refusing to merge unrelated histories`

O Cultiva Mind (Mac) e o GitHub **não compartilham histórico Git**. Use cópia de arquivos:

```sh
git clone -b cursor/macbook-lab-dark-fixes-7428 --depth 1 \
  https://github.com/AfonsoRaudinei/Mapamental-agro.git /tmp/mapamental-agro

bash /tmp/mapamental-agro/scripts/apply-fixes-to-local.sh "$HOME/Cultiva Mind"
```

Guia completo: `docs/MACBOOK-INTEGRACAO-GIT.md`

### Git — branches divergentes (se históricos forem relacionados)

```sh
cd ~/Cultiva\ Mind
git fetch origin cursor/macbook-lab-dark-fixes-7428
git merge origin/cursor/macbook-lab-dark-fixes-7428 --no-edit
```

### Flutter no Mac (obrigatório)

Seu Flutter está em `~/dev/flutter` (confirmado pelo `which flutter`):

```sh
export PATH="$HOME/dev/flutter/bin:$PATH"
flutter doctor
```

**Não cole linhas com `#`** no terminal — são só comentários.

Validação (rode na **raiz** do repo, não dentro de agrimind/):

```sh
cd ~/Cultiva\ Mind
bash scripts/validate-ui.sh
```

Ou, se já estiver em agrimind/:

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
