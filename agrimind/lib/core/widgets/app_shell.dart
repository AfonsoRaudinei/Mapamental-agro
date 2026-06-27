import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../constants/app_colors.dart';
import '../router/app_routes.dart';
import '../utils/extensions.dart';

/// Shell de navegação com 5 tabs — Sprint 2.
///
/// Usa [Scaffold] com [extendBody] + [BackdropFilter] para
/// o efeito frosted-glass iOS. Phosphor icons outline-style.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _indexForLocation(location);

    return Scaffold(
      // extendBody permite o conteúdo ir atrás da tab bar (blur transparente)
      extendBody: true,
      backgroundColor: context.appBackground,
      body: child,
      bottomNavigationBar: _AgriMindTabBar(
        currentIndex: currentIndex,
        onTap: (i) => _navigateTo(context, i),
      ),
    );
  }

  /// Mapeia a rota atual para o índice do tab selecionado.
  static int _indexForLocation(String loc) {
    if (loc.startsWith('/clients')) return 1;
    if (loc.startsWith('/catalog')) return 2;
    if (loc.startsWith('/references')) return 3;
    if (loc.startsWith('/settings')) return 4;
    return 0; // /plans (default)
  }

  /// Navega para a rota raiz do tab tocado.
  static void _navigateTo(BuildContext context, int index) {
    const routes = [
      AppRoutes.plans,
      AppRoutes.clients,
      AppRoutes.catalog,
      AppRoutes.references,
      AppRoutes.settings,
    ];
    context.go(routes[index]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab Bar — iOS Frosted Glass Style
// ─────────────────────────────────────────────────────────────────────────────

/// Definição de um item de tab.
class _TabData {
  const _TabData({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Tabs do AgriMind com ícones Phosphor outline.
const List<_TabData> _kTabs = [
  _TabData(icon: PhosphorIconsRegular.mapTrifold, label: 'Planos'),
  _TabData(icon: PhosphorIconsRegular.usersThree, label: 'Clientes'),
  _TabData(icon: PhosphorIconsRegular.package, label: 'Catálogo'),
  _TabData(icon: PhosphorIconsRegular.bookOpen, label: 'Refs'),
  _TabData(icon: PhosphorIconsRegular.gear, label: 'Config'),
];

/// Tab bar com blur branco fosco, ativa #007AFF, inativa #8E8E93.
/// Altura total: 56px de conteúdo + safe area inferior.
class _AgriMindTabBar extends StatelessWidget {
  const _AgriMindTabBar({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  // Cor ativa: iOS Blue · Inativa: iOS Gray
  static const _activeColor = AppColors.primary;
  static const _inactiveColor = Color(0xFF8E8E93);

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          // 56px de conteúdo + safe area inferior do iPhone
          height: 56 + bottomPad,
          decoration: BoxDecoration(
            color: context.appTabBarBackground,
            border: Border(
              top: BorderSide(color: context.appBorder, width: 0.5),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPad),
            child: Row(
              children: List.generate(
                _kTabs.length,
                (i) => Expanded(
                  child: _TabItem(
                    data: _kTabs[i],
                    isActive: currentIndex == i,
                    activeColor: _activeColor,
                    inactiveColor: _inactiveColor,
                    onTap: () => onTap(i),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Item individual do tab bar com animação de cor suave.
class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.data,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  final _TabData data;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : inactiveColor;

    return GestureDetector(
      onTap: onTap,
      // opaque garante que toda a área de toque seja detectada
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 56,
        // Touch target mínimo 44×44 (Apple HIG)
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: Icon(
                data.icon,
                key: ValueKey('${data.label}_$isActive'),
                size: 24,
                color: color,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
              child: Text(data.label),
            ),
          ],
        ),
      ),
    );
  }
}
