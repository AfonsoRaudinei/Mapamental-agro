iOS  
  
Estilo visual do IOS, Profissional   
🍎 APPLE — “Menos é mais, e mais é mágico.”  
  
Por que a Apple domina?  
	1.	Experiência integrada e fluida — hardware + software = sinfonia.  
	2.	Design minimalista, emocional e premium — tudo parece “limpo e poderoso”.  
	3.	Narrativa forte de marca — não vendem produtos, vendem estilo de vida.  
	4.	Controle absoluto da experiência — loja, suporte, atualizações, tudo no ecossistema.  
	5.	Posicionamento aspiracional — quem usa, se sente parte de uma elite tecnológica.  
  
⸻  
  
🪟 MICROSOFT — “Ferramenta do mundo real.”  
  
Por que a Microsoft está em todos os lugares?  
	1.	Familiaridade e ubiquidade — Word, Excel e PowerPoint estão em toda mesa de trabalho há décadas.  
	2.	Foco em produtividade — eles vendem “fazer as coisas acontecerem”.  
	3.	Compatibilidade e escalabilidade — serve do agro ao hospital, da escola à NASA.  
	4.	Domínio corporativo — Active Directory, Azure, Teams, Office = ecossistema empresarial.  
	5.	Confiabilidade — estabilidade, documentação e suporte global.  
  
Criado mudo dedica a criação de minha página estilo Linkren  
Sempre deixe o visual compacto,  em tarefas de muitas seleções de preferências pra dropdawn.  
  
Caso necessário use Sidecar.  
  
Caixas de edição de números deve ter o tamanho máximo de 7 dígitos  
  
# 🎯 DESIGN SYSTEM — SoloForte (iOS + Samsung Blue)  
  
## 📌 Objetivo  
Padronizar o visual do aplicativo para um estilo **iOS (Apple Human Interface)** com identidade moderna baseada em **azul Samsung**, substituindo o uso excessivo de verde como cor principal.  
  
---  
  
# 🎨 PALETA DE CORES  
  
## 🔵 Cores Primárias (Identidade)  
  
- Primary Blue → #007AFF    
- Primary Dark (Pressed) → #0051D5    
- Primary Light (Hover / Background leve) → #EAF2FF    
  
📌 Uso:  
- Botões principais (CTA)  
- Links e ações  
- Estados ativos (tabs, seleção, foco)  
  
---  
  
## ⚪ Cores Neutras (Base iOS)  
  
- Background Principal → #FFFFFF    
- Background Secundário → #F5F5F7    
- Divider / Border → #E5E7EB    
- Texto Primário → #1D1D1F    
- Texto Secundário → #6B7280    
- Texto Desabilitado → #9CA3AF    
  
📌 Uso:  
- Estrutura geral do app  
- Cards  
- Hierarquia de informação  
  
---  
  
## 🟢 Feedback e Estados  
  
- Sucesso → #34C759    
- Sucesso Light → #D1FAE5    
- Erro → #FF3B30    
- Alerta → #FFCC00    
  
📌 Regra:  
- Verde NÃO é identidade  
- Verde = apenas sucesso  
- Vermelho = erro  
- Amarelo = alerta  
  
---  
  
## 🌈 Gradientes  
  
### Gradiente Principal  
#007AFF → #0051D5    
  
### Gradiente Suave  
#EAF2FF → #FFFFFF    
  
📌 Uso:  
- Cards premium  
- Destaques de saldo  
- Elementos de destaque visual  
  
---  
  
# ✍️ TIPOGRAFIA  
  
## Família  
- SF Pro (ou equivalente no Flutter)  
  
---  
  
## Hierarquia  
  
| Tipo | Tamanho | Peso | Cor |  
|------|--------|------|-----|  
| Título Página | 24–28px | Bold | #1D1D1F |  
| Título Card | 18–20px | Semibold | #1D1D1F |  
| Valor Monetário | 20–32px | Bold | #1D1D1F |  
| Texto padrão | 16px | Regular | #6B7280 |  
| Label | 12–14px | Regular | #9CA3AF |  
  
📌 Regras:  
- Valores sempre em destaque  
- Textos explicativos em cinza  
- Nunca usar cores fortes em texto longo  
  
---  
  
# 🧩 COMPONENTES UI  
  
## 🔘 Botões  
  
### Primário (CTA)  
- Background: #007AFF    
- Texto: branco    
- Border radius: 12–16px    
- Altura mínima: 48px    
  
---  
  
### Secundário  
- Background: #F5F5F7    
- Texto: #1D1D1F    
  
---  
  
### Ghost  
- Background: transparente    
- Texto: #007AFF    
  
---  
  
## 🧱 Cards  
  
### Card padrão  
- Background: branco    
- Border: 1px #E5E7EB    
- Radius: 12–16px    
- Shadow: 0 2px 8px rgba(0,0,0,0.06)  
  
---  
  
### Card premium  
- Background: gradiente azul    
- Texto: branco    
- Shadow: 0 4px 16px rgba(0,122,255,0.15)  
  
---  
  
### Card lista  
- Título (bold)  
- Descrição (cinza)  
- Valor alinhado à direita  
  
---  
  
# 📱 NAVEGAÇÃO  
  
## Bottom Tab Bar  
- Fundo: branco    
- Ativo: #007AFF    
- Inativo: #6B7280    
- Ícones: 24px outline    
  
---  
  
## Top Navigation  
- Sem AppBar fixa    
- Título inline    
- Ações à direita    
  
---  
  
# 🔹 ÍCONES  
  
- Estilo: line-art (outline)  
- Stroke: 2px  
- Cor padrão: #1D1D1F  
- Cor ativa: #007AFF  
  
### Tamanhos  
- 16px → inline    
- 24px → navegação    
- 48px → cards    
  
---  
  
# ⚙️ ESTADOS INTERATIVOS  
  
## Badges  
  
- Border radius: 99px    
  
| Tipo | Fundo | Texto |  
|------|------|------|  
| Novo | #EAF2FF | #007AFF |  
| Sucesso | #D1FAE5 | #34C759 |  
| Erro | #FFE5E5 | #FF3B30 |  
  
---  
  
## Tabs / Switch  
- Ativo: azul    
- Inativo: cinza    
- Indicador: underline ou pill    
  
---  
  
## Loading  
- Skeleton: #F3F4F6    
- Animação: shimmer leve    
  
---  
  
# 📐 PRINCÍPIOS DE DESIGN  
  
## Espaçamento  
- 8px → elementos relacionados    
- 16px → padrão    
- 24px → separação de blocos    
  
---  
  
## Border Radius  
- Cards / Botões → 12–16px    
- Badges → 99px    
  
---  
  
## Sombras  
  
- Cards:  
0 2px 8px rgba(0,0,0,0.06)  
  
- Modais:  
0 -4px 16px rgba(0,0,0,0.12)  
  
---  
  
# 📊 GRÁFICOS  
  
- Linha principal: #007AFF    
- Preenchimento: gradiente leve    
- Grid: discreto    
  
---  
  
# ♿ ACESSIBILIDADE  
  
## Contraste  
- Preto / Branco → AAA    
- Azul / Branco → OK    
  
---  
  
## Touch Targets  
- Mínimo: 44x44px    
  
---  
  
## Legibilidade  
- Texto mínimo: 12px    
- Texto padrão: 16px    
  
---  
  
# 🧠 REGRAS DE OURO  
  
1. Azul é a identidade principal    
2. Verde é apenas feedback    
3. Branco domina o layout    
4. Evitar excesso de sombra    
5. Evitar excesso de cores    
6. Priorizar clareza sobre estética    
  
---  
  
# 🚀 RESULTADO ESPERADO  
  
- Interface com padrão iOS real    
- Visual moderno e tecnológico    
- Menos poluição visual    
- Mais foco em ação e leitura    
- Sensação de produto premium    
  
---  
  
# ⚠️ RESTRIÇÕES (IMPORTANTE)  
  
- NÃO usar verde como botão principal    
- NÃO criar novas cores fora dessa paleta    
- NÃO alterar estrutura de navegação    
- NÃO adicionar efeitos desnecessários    
- NÃO quebrar padrão visual existente    
  
---  
  
# ✅ APLICAÇÃO  
  
Este design system deve ser aplicado em:  
- Dashboard    
- Cards    
- Botões    
- Navegação    
- Ícones    
- Estados visuais    
  
Sem alterar:  
- Arquitetura do app    
- Rotas    
- Lógica de negócio    
  
---  
  
# 📌 CONCLUSÃO  
  
Este padrão substitui o modelo anterior baseado em verde e estabelece uma identidade:  
  
👉 iOS + Samsung Blue    
👉 Visual premium    
👉 Alta legibilidade    
👉 Consistência total    
