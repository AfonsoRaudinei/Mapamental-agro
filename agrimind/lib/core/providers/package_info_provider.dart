import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Versão e build do app lidos de `pubspec.yaml` / plataforma nativa.
final packageInfoProvider = FutureProvider<PackageInfo>((ref) async {
  return PackageInfo.fromPlatform();
});

extension PackageInfoLabels on PackageInfo {
  /// Ex.: `1.0.0 (129)`
  String get displayLabel => '$version ($buildNumber)';

  /// Ex.: `1.0.0+129`
  String get compactLabel => '$version+$buildNumber';
}
