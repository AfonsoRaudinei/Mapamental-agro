# AgriMind Visual Model

## Product Shape
- AgriMind is a PT-BR, iOS-first Flutter app for agronomic planning.
- The visual system is operational, not editorial.
- The main experience is the phenological canvas: plan header, stages, product rows, references, consolidation, and export.
- The app should feel native on iOS and Android, but its visual language is intentionally closer to iOS.

## Visual Identity
- Use `AppColors`, `AppTypography`, and `AppSpacing` as the only source of truth for UI tokens.
- Prefer SF Pro-like hierarchy, compact cards, soft borders, and low elevation.
- Keep the interface dense, clear, and scannable.
- Avoid marketing layouts, large hero sections, decorative blobs, and ornamental gradients.
- Use `AppColors.primary` for actions, active tabs, and links.
- Use category colors only for agronomic meaning:
  - `catDoencas`
  - `catInsetos`
  - `catNutricao`
  - `catFisiologia`
  - `catCESB`

## Black Style
- `dark` mode is the app's black style.
- Black style uses near-black surfaces, high-contrast text, and restrained borders.
- Do not introduce purple-heavy dark palettes.
- Do not create a second dark visual language per feature.
- Use these defaults in black mode:
  - background: `AppColors.backgroundDark`
  - surface: `AppColors.surfaceDark`
  - border: `AppColors.borderDark`
  - primary text: `AppColors.textPrimaryDark`
  - secondary text: `AppColors.textSecondaryDark`
- Black style must remain calm, functional, and flat.
- No bright neon accents except the existing primary blue and semantic feedback.

## Bottom Sheets
- All bottom sheets must follow one shell pattern.
- The shared shell is:
  - rounded top corners, radius `20`
  - drag handle at the top
  - surface background from theme
  - thin border using the active theme border token
  - zero elevation or near-zero elevation
  - `isScrollControlled: true`
  - content padding that respects `AppSpacing`
- Bottom sheets are not full-screen pages.
- Use a bottom sheet for contextual editing, selection, and reference browsing.
- Keep primary actions inside the sheet footer, not floating outside the shell.
- Use the same spacing, border radius, and handle on every sheet.
- Do not invent a one-off bottom sheet layout in a feature unless the shared shell truly cannot fit.

## Layout Rules
- Prefer full-width bands and compact cards over stacked marketing cards.
- Keep cards at `16` radius or less unless a widget already uses a stricter standard.
- Use icon buttons for actions whenever an icon exists.
- Use text buttons only for explicit text commands.
- Do not scale typography with viewport width.
- Prevent overlap at all breakpoints.

## App Flow
- The plan canvas is the primary screen after plan creation.
- Creation opens the canvas directly after save.
- Consolidation is part of the plan workflow, not a separate product.
- Export is a user action, not a background process.

## UX Flows / Screen Responsibilities

Positioning: **Simples. Poderoso. Teu.** — inspired by Apple + Microsoft (see `Instrucao/🍎 APPLE — - cópia.md` at workspace root).

- The user should never wonder "where do I go next?" — one tap, one purpose per screen.
- Fewer steps beat intermediate forms. Do not reintroduce inline add/edit flows when a bottom sheet already covers the task.

### Canvas / ProdutoPanel (`ProdutoPanel`)

Opened directly from **"+ Adicionar produto"** or by tapping an existing product row.

Fields only:
- Product name (via **catalog search dropdown** — `ProdutoSearchDropdown`; prefills category, unit, suggested dose)
- Dose + unit
- Application area (farm / custom)
- Calculated total (+ manual override)
- Observation (optional)

**Not in ProdutoPanel:**
- Unit price → consolidation tab only
- Scheduled application date → not used in planning (agronomy cannot be pinned to a calendar date in this workflow)

When editing a product, preserve `precoUnitario` and `dataPrevista` already stored — do not clear them from the panel save path.

### Consolidation tab (`_ConsolidationView`)

Financial layer of the same plan:
- Unit prices per consolidated product (inline table row, columns aligned to header)
- Plan-level financial params: grain price (R$/sc 60 kg) and due date

Table rows must follow the header grid (`Produto | Qtd. | R$ Unit. | R$ Total`) — no expand/collapse that breaks column alignment.

### References

- **Always visible** on each stage card header (compact book icon + badge next to the phenological badge, e.g. V5).
- Selecting a reference opens `ProdutoPanel` with the name pre-filled — same agronomic fields only.

### Canvas layout (`_PlanningView`)

- **Scrollable canvas** (header + stages) in the upper area.
- **Fixed bottom dock**: Investimento + Consultor cards pinned to the lower edge (not floating mid-screen when few stages).
- Stage collapsed summary shows `{nome} · {dose} · {total}` — no "N produtos" prefix.
- Consultor collapsed: logo + name only (no subtitle); eye toggle hides name (logo-only export/resumo).

### Future direction (Miro / Freeform)

Progressive disclosure today; future evolution: zoomable canvas with positioned nodes, refs linked to actives/diseases per product.

## Non-Negotiables
- Do not bypass the shared theme tokens.
- Do not hardcode a new visual system inside a single feature.
- Do not make a page look like a landing page.
- Do not embed web-style chrome where the app should feel native.
- When adding new UI, follow the existing canvas and bottom sheet language first.
