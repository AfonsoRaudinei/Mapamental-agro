import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agrimind/core/constants/app_colors.dart';
import 'package:agrimind/features/plans/domain/entities/produto_aplicacao_entity.dart';
import 'package:agrimind/features/plans/domain/usecases/calcular_total_usecase.dart';

void main() {
  test('AppColors - primary é iOS Blue', () {
    expect(AppColors.primary, const Color(0xFF007AFF));
  });

  test('AppColors - verde apenas sucesso', () {
    expect(AppColors.success, const Color(0xFF34C759));
    expect(AppColors.catFisiologia, const Color(0xFF34C759));
  });

  group('CalcularTotalUseCase', () {
    const usecase = CalcularTotalUseCase();

    test('calcula dose × área corretamente', () {
      final total = usecase(dose: 0.4, areaHa: 80.0);
      expect(total, closeTo(32.0, 0.001));
    });

    test('retorna override quando definido', () {
      final total = usecase(dose: 0.4, areaHa: 80.0, totalOverride: 28.0);
      expect(total, 28.0);
    });

    test('calcula custo total com preço', () {
      const t = 32.0;
      final custo = usecase.calcularCusto(totalFinal: t, precoUnitario: 50.0);
      expect(custo, closeTo(1600.0, 0.001));
    });

    test('custo nulo quando preço não informado', () {
      final custo = usecase.calcularCusto(totalFinal: 32.0);
      expect(custo, isNull);
    });
  });

  group('ProdutoAplicacaoEntity - getters computados', () {
    final produto = ProdutoAplicacaoEntity(
      id: 'test-id',
      estadioId: 'estadio-id',
      produtoNome: 'Fox Xpro',
      produtoCategoria: 'Fungicida',
      dose: 0.4,
      doseUnidade: 'L/ha',
      areaHa: 80.0,
      ordem: 0,
      createdAt: DateTime(2025),
    );

    test('totalCalculado = dose × areaHa', () {
      expect(produto.totalCalculado, closeTo(32.0, 0.001));
    });

    test('totalFinal = totalCalculado sem override', () {
      expect(produto.totalFinal, closeTo(32.0, 0.001));
      expect(produto.isOverride, isFalse);
    });

    test('totalFinal = totalOverride quando definido', () {
      final comOverride = produto.copyWith(totalOverride: 28.0);
      expect(comOverride.totalFinal, 28.0);
      expect(comOverride.isOverride, isTrue);
    });

    test('custoTotal = totalFinal × precoUnitario', () {
      final comPreco = produto.copyWith(precoUnitario: 50.0);
      expect(comPreco.custoTotal, closeTo(1600.0, 0.001));
    });

    test('custoTotal nulo sem preço', () {
      expect(produto.custoTotal, isNull);
    });
  });
}
