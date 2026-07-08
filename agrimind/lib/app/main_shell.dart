import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../features/plan/presentation/plan_screen.dart';
import '../features/references/presentation/references_screen.dart';
import '../features/shared/placeholder_tab_screen.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _index = 0;

  static const _tabs = [
    _Tab('Plano', Icons.event_note_outlined, Icons.event_note),
    _Tab('Clientes', Icons.people_outline, Icons.people),
    _Tab('Catálogo', Icons.inventory_2_outlined, Icons.inventory_2),
    _Tab('Refs', Icons.menu_book_outlined, Icons.menu_book),
    _Tab('Config', Icons.settings_outlined, Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      const PlanScreen(),
      const PlaceholderTabScreen(title: 'Clientes'),
      const PlaceholderTabScreen(title: 'Catálogo'),
      const ReferencesScreen(),
      _SettingsTab(),
    ];

    final showSearch = _index != 3;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const SizedBox.shrink(),
        bottom: showSearch
            ? PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      prefixIcon: const Icon(Icons.search, color: AppColors.onSurfaceMuted),
                      filled: true,
                      fillColor: AppColors.surfaceElevated,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    style: const TextStyle(color: AppColors.onSurface),
                  ),
                ),
              )
            : null,
        actions: [
          IconButton(icon: const Icon(Icons.shield_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.pause_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.upload_outlined), onPressed: () {}),
          const SizedBox(width: 4),
        ],
      ),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          for (final tab in _tabs)
            BottomNavigationBarItem(
              icon: Icon(tab.outlined),
              activeIcon: Icon(tab.filled),
              label: tab.label,
            ),
        ],
      ),
    );
  }
}

class _SettingsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Aparência',
          style: TextStyle(
            color: AppColors.onSurfaceMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Modo escuro (Black)', style: TextStyle(color: AppColors.onSurface)),
          subtitle: const Text(
            'Tema padrão do sistema',
            style: TextStyle(color: AppColors.onSurfaceMuted),
          ),
          value: theme.isDark,
          activeColor: AppColors.primary,
          onChanged: (v) => ref
              .read(themeProvider.notifier)
              .setTheme(v ? AppTheme.darkBlack : AppTheme.light),
        ),
      ],
    );
  }
}

class _Tab {
  const _Tab(this.label, this.outlined, this.filled);
  final String label;
  final IconData outlined;
  final IconData filled;
}
