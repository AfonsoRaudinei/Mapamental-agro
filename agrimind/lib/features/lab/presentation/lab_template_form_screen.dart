import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/dark_app_bar.dart';
import '../../../core/widgets/dark_dropdown_field.dart';
import '../../../core/widgets/dark_surface_card.dart';

class LabTemplateFormScreen extends StatefulWidget {
  const LabTemplateFormScreen({super.key, this.initialName});

  final String? initialName;

  @override
  State<LabTemplateFormScreen> createState() => _LabTemplateFormScreenState();
}

class _LabTemplateFormScreenState extends State<LabTemplateFormScreen> {
  static const _kUnits = ['cmolc/dm³', 'g/dm³', 'g/kg', 'dag/kg', '%'];
  static const _moUnits = ['g/dm³', 'g/kg', 'dag/kg', '%'];

  String _kUnit = 'cmolc/dm³';
  String _moUnit = 'g/dm³';
  String _nUnit = 'g/kg';
  bool _labCalculates = true;
  bool _phWater = false;
  bool _phSmp = true;
  bool _micronutrients = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DarkAppBar(title: widget.initialName == null ? 'Novo Template' : 'Editar Template'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        children: [
          _sectionLabel('UNIDADES PADRÃO'),
          DarkSurfaceCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DarkDropdownField<String>(
                  label: 'K, Ca, Mg',
                  value: _kUnit,
                  items: _kUnits
                      .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                      .toList(),
                  onChanged: (v) => setState(() => _kUnit = v ?? _kUnit),
                ),
                const SizedBox(height: 16),
                DarkDropdownField<String>(
                  label: 'Matéria orgânica',
                  value: _moUnit,
                  items: _moUnits
                      .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                      .toList(),
                  onChanged: (v) => setState(() => _moUnit = v ?? _moUnit),
                ),
                const SizedBox(height: 16),
                DarkDropdownField<String>(
                  label: 'N',
                  value: _nUnit,
                  items: _kUnits
                      .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                      .toList(),
                  onChanged: (v) => setState(() => _nUnit = v ?? _nUnit),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _sectionLabel('DERIVADOS CALCULADOS'),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Ative os campos que a lab já entrega calculados no laudo',
              style: TextStyle(color: AppColors.onSurfaceMuted, fontSize: 13),
            ),
          ),
          DarkSurfaceCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _toggleRow('Lab calcula e entrega no laudo', _labCalculates, (v) => setState(() => _labCalculates = v)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _sectionLabel('pH'),
          DarkSurfaceCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _toggleRow('pH Água', _phWater, (v) => setState(() => _phWater = v)),
                const Divider(height: 24, color: AppColors.border),
                _toggleRow('pH SMP', _phSmp, (v) => setState(() => _phSmp = v)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _sectionLabel('MICRONUTRIENTES'),
          DarkSurfaceCard(
            padding: const EdgeInsets.all(16),
            child: _toggleRow('Incluir micronutrientes', _micronutrients, (v) => setState(() => _micronutrients = v)),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Text(widget.initialName == null ? 'Criar Template' : 'Salvar Template'),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.onSurfaceMuted,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _toggleRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: const TextStyle(color: AppColors.onSurface, fontSize: 14)),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
