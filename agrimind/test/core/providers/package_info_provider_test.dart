import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:agrimind/core/providers/package_info_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'AgriMind',
      packageName: 'com.cultivamind.agrimind',
      version: '1.0.0',
      buildNumber: '129',
      buildSignature: '',
    );
  });

  test('displayLabel formata versão e build', () {
    final info = PackageInfo(
      appName: 'AgriMind',
      packageName: 'com.cultivamind.agrimind',
      version: '1.0.0',
      buildNumber: '129',
      buildSignature: '',
    );

    expect(info.displayLabel, '1.0.0 (129)');
    expect(info.compactLabel, '1.0.0+129');
  });
}
