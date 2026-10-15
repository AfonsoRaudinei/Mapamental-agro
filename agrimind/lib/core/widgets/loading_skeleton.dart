import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../utils/extensions.dart';

/// Skeleton shimmer loading reutilizável.
class LoadingSkeleton extends StatefulWidget {
  const LoadingSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = 8,
  });

  /// Skeleton para lista vertical de cards.
  factory LoadingSkeleton.list({int itemCount = 5}) => _ListSkeleton(
        itemCount: itemCount,
      ) as LoadingSkeleton;

  final double? width;
  final double height;
  final double borderRadius;

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: _animation.value,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: context.appBorder,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
    );
  }
}

// Skeleton compacto para listas
class _ListSkeleton extends StatelessWidget {
  const _ListSkeleton({required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (_, __) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.appBorder),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadingSkeleton(height: 16, width: 180),
            SizedBox(height: AppSpacing.sm),
            LoadingSkeleton(height: 13, width: 120),
          ],
        ),
      ),
    );
  }
}
