import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PlaceholderTabScreen extends StatelessWidget {
  const PlaceholderTabScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.onSurfaceMuted,
            ),
      ),
    );
  }
}
