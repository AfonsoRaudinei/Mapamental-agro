import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../features/analysis/presentation/soil_analysis_screen.dart';
import '../features/lab/presentation/lab_templates_screen.dart';
import '../features/plan/presentation/plan_screen.dart';
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
    _Tab('Safra', Icons.agriculture_outlined, Icons.agriculture),
    _Tab('Config', Icons.settings_outlined, Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      const PlanScreen(),
      const PlaceholderTabScreen(title: 'Clientes'),
      const PlaceholderTabScreen(title: 'Catálogo'),
      const PlaceholderTabScreen(title: 'Safra'),
      _SettingsTab(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const SizedBox.shrink(),
        bottom: PreferredSize(
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
        ),
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
          'IDENTIDADE VISUAL',
          style: TextStyle(
            color: AppColors.onSurfaceMuted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 8),
        _SettingsTile(
          title: 'Logomarca',
          subtitle: 'Aparece no cabeçalho das recomendações',
          trailing: TextButton(onPressed: () {}, child: const Text('Adicionar')),
        ),
        const SizedBox(height: 16),
        const Text(
          'GERENCIAMENTO',
          style: TextStyle(
            color: AppColors.onSurfaceMuted,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Modo Black', style: TextStyle(color: AppColors.onSurface)),
          subtitle: const Text(
            'Tema escuro padrão do sistema',
            style: TextStyle(color: AppColors.onSurfaceMuted),
          ),
          value: theme.isDark,
          activeThumbColor: AppColors.onPrimary,
          activeTrackColor: AppColors.primary,
          onChanged: (v) => ref
              .read(themeProvider.notifier)
              .setTheme(v ? AppTheme.darkBlack : AppTheme.light),
        ),
        _SettingsTile(
          title: 'Modelos de Laboratório',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const LabTemplatesScreen()),
          ),
        ),
        _SettingsTile(
          title: 'Análise de Solo',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const SoilAnalysisScreen()),
          ),
        ),
        _SettingsTile(title: 'Enviar Feedback', onTap: () {}),
        _SettingsTile(title: 'Limpar Dados Locais', onTap: () {}),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: AppColors.onSurface)),
      subtitle: subtitle != null
          ? Text(subtitle!, style: const TextStyle(color: AppColors.onSurfaceMuted))
          : null,
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right, color: AppColors.onSurfaceMuted) : null),
      onTap: onTap,
    );
  }
}

class _Tab {
  const _Tab(this.label, this.outlined, this.filled);
  final String label;
  final IconData outlined;
  final IconData filled;
}
