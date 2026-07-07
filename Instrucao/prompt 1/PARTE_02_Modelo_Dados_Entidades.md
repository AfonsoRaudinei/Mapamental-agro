# 🌱 AgriMind — PARTE 02
## Modelo de Dados · Entidades · Relacionamentos

---

## 🗃️ Diagrama Completo de Entidades

```
Usuario
  └── Perfil

Cliente
  └── Fazenda[]
        └── Talhao[] (referência de área, Opção A)

Plano
  ├── vinculado a: Cliente + Fazenda + Cultura + Safra
  └── Estadio[]
        ├── codigo (VE, VC, V1...R8, Operacional)
        └── ProdutoAplicacao[]
              ├── Produto (FK → Catalogo)
              ├── dose + unidade
              ├── areaHa (editável por linha)
              ├── totalCalculado (dose × area)
              └── totalOverride? (manual)

Catalogo (Produto)
  ├── seed pré-populado
  └── editável pelo técnico

ReferenciaTecnica
  ├── seed fixo (não editável)
  ├── categorias: Doencas, Insetos, Nutricao, Fisiologia
  └── categoria CESB (PDF correlação)

Consolidacao
  └── gerada do Plano (somente leitura)
        └── Itens agrupados por produto
              └── soma de todos os estádios
```

---

## 👤 Entidade: Usuario / Perfil

```dart
@Collection()
class UsuarioModel {
  Id id = Isar.autoIncrement;

  late String firebaseUid;      // Firebase Auth UID
  late String nome;             // obrigatório
  late String email;            // obrigatório, somente leitura
  String? telefone;             // opcional, com máscara
  String? empresa;              // opcional
  String? craRegistro;          // CRA ou registro técnico
  String? avatarUrl;            // foto de perfil
  late bool darkMode;           // padrão: false
  late String appIconKey;       // 'principal' | 'classico'
  late DateTime createdAt;
  late DateTime updatedAt;
}
```

---

## 👥 Entidade: Cliente

```dart
@Collection()
class ClienteModel {
  Id id = Isar.autoIncrement;

  late String uid;              // UUID gerado localmente
  late String nome;             // obrigatório
  String? cpfCnpj;              // opcional, máscara automática
  String? telefone;             // opcional
  String? email;                // opcional
  String? cidade;               // opcional
  String? uf;                   // UF (2 chars)
  late bool ativo;              // soft delete
  late DateTime createdAt;
  late DateTime updatedAt;

  // Relacionamento
  @Backlink(to: 'cliente')
  final fazendas = IsarLinks<FazendaModel>();
}
```

---

## 🌾 Entidade: Fazenda

```dart
@Collection()
class FazendaModel {
  Id id = Isar.autoIncrement;

  late String uid;
  late String nome;             // obrigatório
  late double areaHa;           // obrigatório, max 7 dígitos
  late String cultura;          // enum seed: Soja, Milho, Café, Algodão, Trigo...
  late String safra;            // ex: "2025/26"
  String? municipio;
  String? uf;
  late bool ativo;
  late DateTime createdAt;
  late DateTime updatedAt;

  // Relacionamentos
  final cliente = IsarLink<ClienteModel>();

  @Backlink(to: 'fazenda')
  final talhoes = IsarLinks<TalhaoModel>();

  @Backlink(to: 'fazenda')
  final planos = IsarLinks<PlanoModel>();
}
```

---

## 🗺️ Entidade: Talhao

```dart
// Opção A confirmada: talhão = referência de área
// Não é nó no mapa, é apenas seletor de área por produto

@Collection()
class TalhaoModel {
  Id id = Isar.autoIncrement;

  late String uid;
  late String nome;             // ex: "Talhão A", "Gleba Norte"
  late double areaHa;           // área deste talhão
  String? observacao;
  late bool ativo;
  late DateTime createdAt;

  // Relacionamento
  final fazenda = IsarLink<FazendaModel>();
}
```

**Regra de uso do talhão:**
Ao adicionar um produto a um estádio, o técnico pode selecionar:
- `Fazenda inteira` → usa `fazenda.areaHa`
- `Talhão A` → usa `talhao.areaHa`
- `Personalizado` → digita área manualmente

---

## 📋 Entidade: Plano

```dart
@Collection()
class PlanoModel {
  Id id = Isar.autoIncrement;

  late String uid;
  late String nome;             // ex: "Soja - Boa Vista - 25/26"
  late String cultura;          // snapshot da fazenda
  late String safra;            // snapshot da fazenda
  late double areaHaTotal;      // snapshot da fazenda.areaHa
  late String status;           // enum: rascunho, ativo, consolidado
  late DateTime createdAt;
  late DateTime updatedAt;

  // Relacionamentos
  final fazenda  = IsarLink<FazendaModel>();
  final cliente  = IsarLink<ClienteModel>();

  @Backlink(to: 'plano')
  final estadios = IsarLinks<EstadioModel>();
}
```

---

## 🌱 Entidade: Estadio

```dart
// Representa um estádio fenológico dentro de um Plano

@Collection()
class EstadioModel {
  Id id = Isar.autoIncrement;

  late String uid;
  late String codigo;           // enum: 'VE','VC','V1'...'R8','Operacional'
  late String label;            // editável pelo técnico (padrão = codigo)
  int ordem = 0;                // ordem de exibição no plano
  DateTime? dataAplicacao;      // data planejada do estádio
  String? observacao;
  late DateTime createdAt;

  // Relacionamentos
  final plano = IsarLink<PlanoModel>();

  @Backlink(to: 'estadio')
  final produtos = IsarLinks<ProdutoAplicacaoModel>();
}
```

**Estádios disponíveis (enum seed):**
```
Operacional, VE, VC, V1, V2, V3, V4, V5, V6,
R1, R2, R3, R4, R5.1, R5.3, R5.5, R6, R7, R8
```

---

## 🧪 Entidade: ProdutoAplicacao

```dart
// Produto dentro de um estádio — núcleo do cálculo

@Collection()
class ProdutoAplicacaoModel {
  Id id = Isar.autoIncrement;

  late String uid;
  late String produtoNome;      // snapshot do catálogo
  late String produtoCategoria; // snapshot (Fungicida, Inseticida...)
  late double dose;             // max 7 dígitos
  late String doseUnidade;      // enum: L/ha, mL/ha, kg/ha, g/ha, unid/ha
  late double areaHa;           // editável por linha — padrão = fazenda.areaHa
  String? talhaoRef;            // nome do talhão referenciado (se aplicável)

  // Cálculo automático
  // totalCalculado = dose × areaHa (computed, não persistido)

  double? totalOverride;        // sobrescreve o cálculo — digitado manualmente
  String? overrideMotivo;       // ex: "Estoque limitado", "Área parcial"

  // Custo (opcional)
  double? precoUnitario;        // snapshot do catálogo
  // custoTotal = (totalOverride ?? dose×areaHa) × precoUnitario (computed)

  String? observacao;
  DateTime? dataPrevista;
  int ordem = 0;
  late DateTime createdAt;

  // Relacionamentos
  final estadio = IsarLink<EstadioModel>();
  final produto = IsarLink<ProdutoCatalogoModel>();
}
```

### 🧮 Lógica de Cálculo (Domain Layer)

```dart
class ProdutoAplicacaoEntity {
  // ...

  double get totalCalculado => dose * areaHa;

  double get totalFinal => totalOverride ?? totalCalculado;

  bool get isOverride => totalOverride != null;

  double? get custoTotal {
    if (precoUnitario == null) return null;
    return totalFinal * precoUnitario!;
  }

  String get totalFormatado {
    // ex: "32,0 L" ou "400,0 mL"
    final valor = totalFinal;
    return '${valor.toStringAsFixed(1)} ${_normalizeUnit(doseUnidade)}';
  }
}
```

### ⚠️ Regra de Unidade Mista (Consolidação)

```
Fox Xpro: 400 mL/ha em VE  → converte para L → 0,4 L/ha
Fox Xpro: 0,4 L/ha em R1   → já em L
─────────────────────────────────────────
Consolidação normaliza para a maior unidade
e exibe badge ⚠️ "Unidades mescladas — verifique"
```

---

## 📦 Entidade: ProdutoCatalogo

```dart
@Collection()
class ProdutoCatalogoModel {
  Id id = Isar.autoIncrement;

  late String uid;
  late String nomeComercial;    // "Fox Xpro" — busca no dropdown
  String? ingredienteAtivo;     // "Trifloxistrobina + Protioconazol"
  late String categoria;        // enum: Fungicida, Inseticida, Herbicida,
                                //       Fertilizante, Bioestimulante, Adjuvante
  late String unidadePadrao;    // sugerida ao adicionar produto
  double? doseMin;              // referência técnica
  double? doseMax;              // referência técnica
  double? precoUnitario;        // R$ por unidade (L, kg, etc.)
  String? fabricante;
  String? observacoes;
  late bool ativo;              // false = soft delete (some do dropdown)
  late bool isSeed;             // true = veio do seed de fábrica
  late DateTime createdAt;
  late DateTime updatedAt;
}
```

### Seed Inicial — Categorias e exemplos
```
FUNGICIDAS:    Fox Xpro, Elatus, Orkestra, Priori Xtra, Opera...
INSETICIDAS:   Engeo Pleno, Karate Zeon, Intrepid, Ampligo...
HERBICIDAS:    Roundup, Verdict R, Poast, Spider...
FERTILIZANTES: Nutriplant, Booster, KaliPhos...
BIOESTIMULANTES: Stimulate, Locus, Acadian, Rize...
ADJUVANTES:    Nimbus, Joint, Aureo...
```

---

## 📚 Entidade: ReferenciaTecnica

```dart
// Seed fixo — não editável pelo usuário

@Collection()
class ReferenciaTecnicaModel {
  Id id = Isar.autoIncrement;

  late String categoria;    // enum: doencas, insetos, nutricao, fisiologia, cesb
  late String estadio;      // VE, VC, V1...R8, Operacional
  late String titulo;       // nome principal
  String? descricao;        // texto descritivo (especialmente CESB)
  String? focoManejo;       // CESB: "Fixação de Flores"
  String? praticas;         // CESB: texto das práticas dos campeões
  String? padrao;           // CESB: "Nutrologia", "Hormonal", "Biológico"
  String? destaque;         // CESB: "Agro Mallon — 135,49 sc/ha"
}
```

### Ícones dos 5 categorias (sempre presentes em todos os estádios)

```dart
enum CategoriaReferencia {
  doencas    (label: 'Doenças',    cor: 0xFFFF3B30, icone: PhosphorIcons.virus),
  insetos    (label: 'Insetos',    cor: 0xFF007AFF, icone: PhosphorIcons.bug),
  nutricao   (label: 'Nutrição',   cor: 0xFFAF52DE, icone: PhosphorIcons.leaf),
  fisiologia (label: 'Fisiologia', cor: 0xFF34C759, icone: PhosphorIcons.dna),
  cesb       (label: 'Campeões',   cor: 0xFFFF9500, icone: PhosphorIcons.trophy);
}
```

**Regra de opacidade:**
```dart
// Sem conteúdo → ícone opacidade 40% (disabled visual)
// Com conteúdo → ícone 100% + shadow
final opacity = hasContent ? 1.0 : 0.4;
```

---

## 📊 Entidade: Consolidacao (gerada)

```dart
// Não é persistida — gerada em memória a partir do Plano
// Pode ser exportada como PDF, Excel ou HTML

class ConsolidacaoEntity {
  final PlanoEntity plano;
  final DateTime geradoEm;
  final List<ConsolidacaoItemEntity> itens;

  double get totalGeral => itens.fold(0, (s, i) => s + i.quantidadeTotal);
  double? get custoGeral => itens.every((i) => i.custoTotal != null)
      ? itens.fold(0.0, (s, i) => s + i.custoTotal!)
      : null;
}

class ConsolidacaoItemEntity {
  final String produtoNome;
  final String categoria;
  final double quantidadeTotal;   // soma de todos os estádios
  final String unidade;           // normalizada
  final double? precoUnitario;
  final double? custoTotal;       // quantidadeTotal × precoUnitario
  final List<DetalheEstadio> detalhe; // breakdown por estádio
  final bool temUnidadeMista;     // badge ⚠️
}

class DetalheEstadio {
  final String estadioCodigo;
  final double dose;
  final String doseUnidade;
  final double areaHa;
  final double total;             // dose × area ou override
  final bool isOverride;
  final String? overrideMotivo;
}
```

### Exemplo visual da Consolidação
```
┌──────────────────────────────────────────────────────┐
│ 📋 PEDIDO — Fazenda Boa Vista                        │
│ João Silva · Soja · 80 ha · Safra 2025/26            │
│ Gerado em: 05/06/2026                                │
├──────────────────────────────────────────────────────┤
│ FUNGICIDAS                                           │
│  Fox Xpro      96,0 L    R$ 45,00/L   R$ 4.320,00  │
│  Elatus        48,0 L    R$ 62,00/L   R$ 2.976,00  │
├──────────────────────────────────────────────────────┤
│ INSETICIDAS                                          │
│  Engeo Pleno   12,0 L    R$ 38,00/L   R$   456,00  │
├──────────────────────────────────────────────────────┤
│                         TOTAL        R$ 7.752,00    │
├──────────────────────────────────────────────────────┤
│  [📄 PDF]     [📊 Excel]    [🌐 HTML]    [📤 Share] │
└──────────────────────────────────────────────────────┘
```

**Detalhamento ao tocar em Fox Xpro:**
```
Fox Xpro — 96,0 L total
────────────────────────────────────
VE  │ 0,4 L/ha × 80 ha = 32,0 L
V3  │ 0,4 L/ha × 80 ha = 32,0 L
R1  │ 0,4 L/ha × 80 ha = 32,0 L
────────────────────────────────────
R$ 45,00/L × 96,0 L = R$ 4.320,00
```

---

*Próxima parte → PARTE 03: Estrutura de Features & Arquitetura de Pastas*
