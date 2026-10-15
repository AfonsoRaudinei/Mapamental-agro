# Integração Git — Cultiva Mind (Mac) + Mapamental-agro (GitHub)

## Problema: `refusing to merge unrelated histories`

Isso significa que o **Cultiva Mind no Mac** e o **Mapamental-agro no GitHub** foram criados separadamente — não compartilham o mesmo histórico Git. O `git merge` normal **não funciona**.

**Solução recomendada:** copiar os arquivos de correção sem merge (mais seguro — preserva seu app completo local).

---

## Método A — Copiar correções (recomendado)

No Mac, rode **linha por linha**:

```sh
cd ~
git clone -b cursor/macbook-lab-dark-fixes-7428 --depth 1 \
  https://github.com/AfonsoRaudinei/Mapamental-agro.git /tmp/mapamental-agro

bash /tmp/mapamental-agro/scripts/apply-fixes-to-local.sh "$HOME/Cultiva Mind"
```

Ajuste o caminho se sua pasta não for `~/Cultiva Mind`.

Depois:

```sh
export PATH="$HOME/dev/flutter/bin:$PATH"
cd ~/Cultiva\ Mind
bash scripts/check-integration.sh
bash scripts/validate-ui.sh
```

---

## Método B — Merge forçado (só se quiser unificar históricos)

⚠️ Pode gerar muitos conflitos.

```sh
cd ~/Cultiva\ Mind
git fetch origin cursor/macbook-lab-dark-fixes-7428
git merge origin/cursor/macbook-lab-dark-fixes-7428 --allow-unrelated-histories --no-edit
```

Resolva conflitos manualmente, depois `git add -A && git commit`.

---

## Método C — Novo clone + trazer código local

Se o Cultiva Mind local estiver muito diferente:

```sh
git clone -b cursor/macbook-lab-dark-fixes-7428 \
  https://github.com/AfonsoRaudinei/Mapamental-agro.git ~/Mapamental-agro-novo

# Copie SEU lib/ completo para dentro do clone novo:
rsync -av ~/Cultiva\ Mind/agrimind/lib/ ~/Mapamental-agro-novo/agrimind/lib/

# Depois aplique widgets (Método A) ou mescle manualmente
```

---

## Checklist pós-integração

```sh
bash scripts/check-integration.sh   # deve mostrar ✅ em tudo
bash scripts/validate-ui.sh         # 22 testes passando
```

No app, conferir manualmente:
- [ ] Config → Modelos de Laboratório (cards #1E1E1E, não preto puro)
- [ ] Novo Template (dropdowns legíveis)
- [ ] Análise de Solo → "Voltar para plantio" azul (#3B82F6)

---

## Seu Flutter

```sh
export PATH="$HOME/dev/flutter/bin:$PATH"
```

Adicione ao `~/.zshrc` para não repetir:

```sh
echo 'export PATH="$HOME/dev/flutter/bin:$PATH"' >> ~/.zshrc
```
