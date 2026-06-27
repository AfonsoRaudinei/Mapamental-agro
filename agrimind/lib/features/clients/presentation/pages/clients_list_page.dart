import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../providers/clients_provider.dart';
import '../widgets/client_list_tile.dart';

class ClientsListPage extends ConsumerStatefulWidget {
  const ClientsListPage({super.key});

  @override
  ConsumerState<ClientsListPage> createState() => _ClientsListPageState();
}

class _ClientsListPageState extends ConsumerState<ClientsListPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientesAsync = ref.watch(clientsNotifierProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Clientes'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.85),
            border: Border.all(color: Colors.transparent),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => context.push('/clients/new'),
              child: const PhosphorIcon(
                PhosphorIconsRegular.plus,
                size: 22,
                color: AppColors.primary,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Buscar cliente...',
                onChanged: (v) =>
                    setState(() => _searchQuery = v.toLowerCase()),
              ),
            ),
          ),
          clientesAsync.when(
            data: (clientes) {
              final filtrados = _searchQuery.isEmpty
                  ? clientes
                  : clientes
                      .where((c) =>
                          c.nome.toLowerCase().contains(_searchQuery) ||
                          (c.cidade?.toLowerCase().contains(_searchQuery) ??
                              false))
                      .toList();

              if (filtrados.isEmpty) {
                return SliverFillRemaining(
                  child: EmptyStateWidget(
                    icon: PhosphorIconsRegular.usersThree,
                    title: _searchQuery.isEmpty
                        ? 'Nenhum cliente ainda'
                        : 'Nenhum cliente encontrado',
                    subtitle: _searchQuery.isEmpty
                        ? 'Toque em + para adicionar seu primeiro cliente'
                        : 'Tente buscar por outro nome ou cidade',
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) {
                    final c = filtrados[i];
                    return ClientListTile(
                      cliente: c,
                      onTap: () => context.push('/clients/${c.id}'),
                      onEdit: () => context.push('/clients/${c.id}/edit'),
                      onDelete: () => _confirmDelete(context, c.id, c.nome),
                    );
                  },
                  childCount: filtrados.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: LoadingSkeleton(),
            ),
            error: (e, _) => SliverFillRemaining(
              child: ErrorStateWidget(
                onRetry: () => ref.invalidate(clientsNotifierProvider),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.xxl),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, String id, String nome) async {
    final ok = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Excluir cliente'),
        content:
            Text('Deseja excluir "$nome"? Esta ação não pode ser desfeita.'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
    if (ok == true && mounted) {
      await ref.read(clientsNotifierProvider.notifier).deleteCliente(id);
    }
  }
}
