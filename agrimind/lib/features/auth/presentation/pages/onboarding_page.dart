import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/extensions.dart';

/// Onboarding de boas-vindas — 3 slides.
/// Sprint 1: substituído com animações flutter_animate.
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const _slides = [
    (
      icon: Icons.map_outlined,
      title: 'Planejamento por Estádio',
      subtitle:
          'Organize as aplicações de insumos por estádio fenológico, de VE a R8.',
    ),
    (
      icon: Icons.science_outlined,
      title: 'Base Técnica Integrada',
      subtitle:
          'Doenças, insetos, nutrição, fisiologia e dicas CESB em um só lugar.',
    ),
    (
      icon: Icons.picture_as_pdf_outlined,
      title: 'Exporte em Segundos',
      subtitle: 'Gere o pedido de compra em PDF, Excel ou HTML com um toque.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => context.go(AppRoutes.login),
                child: const Text('Pular'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _slides.length,
                itemBuilder: (_, i) => _SlidePage(
                  icon: _slides[i].icon,
                  title: _slides[i].title,
                  subtitle: _slides[i].subtitle,
                ),
              ),
            ),
            // Indicadores de página
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _currentPage ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _currentPage
                        ? AppColors.primary
                        : context.appBorder,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _currentPage < _slides.length - 1
                  ? ElevatedButton(
                      onPressed: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: const Text('Próximo'),
                    )
                  : ElevatedButton(
                      onPressed: () => context.go(AppRoutes.login),
                      child: const Text('Começar'),
                    ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _SlidePage extends StatelessWidget {
  const _SlidePage({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(icon, size: 48, color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(title, style: AppTypography.h2, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.md),
          Text(subtitle,
              style: AppTypography.body.copyWith(
                color: context.appTextSecondary,
              ),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
