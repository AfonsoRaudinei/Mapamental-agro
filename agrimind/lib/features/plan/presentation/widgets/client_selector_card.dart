import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/plan_models.dart';

class ClientSelectorCard extends StatelessWidget {
  const ClientSelectorCard({
    super.key,
    required this.client,
    required this.clients,
    required this.onChanged,
  });

  final ClientModel client;
  final List<ClientModel> clients;
  final ValueChanged<ClientModel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surfaceContainer,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showPicker(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      client.subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.onSurfaceMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showPicker(BuildContext context) async {
    final picked = await showModalBottomSheet<ClientModel>(
      context: context,
      backgroundColor: AppColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Selecionar cliente',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
            ),
            ...clients.map(
              (c) => ListTile(
                title: Text(c.name, style: const TextStyle(color: AppColors.onSurface)),
                subtitle: Text(
                  c.subtitle,
                  style: const TextStyle(color: AppColors.onSurfaceMuted),
                ),
                trailing: c.id == client.id
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () => Navigator.pop(ctx, c),
              ),
            ),
          ],
        ),
      ),
    );
    if (picked != null) onChanged(picked);
  }
}
