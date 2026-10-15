import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Expansão do accordion por estádio (UI efêmera, não persiste).
final stageAccordionExpandedProvider =
    StateProvider.autoDispose.family<bool, String>((ref, stageId) => false);
