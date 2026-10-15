import 'package:agrimind/core/constants/app_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Operacional fica fora da lista fenológica', () {
    expect(AppConstants.estadiosCodigos, isNot(contains('Operacional')));
    expect(AppConstants.estadioLabels['Operacional'], 'Operacional');
  });
}
