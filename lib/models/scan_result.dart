import '../services/ingredient_service.dart';

enum SafetyLevel {
  safe,
  unsafe,
  unknown,
}

class ScanResult {
  final List<IngredientMatch> ingredients;
  final SafetyLevel overallSafety;
  final int safeCount;
  final int unsafeCount;
  final int unknownCount;
  final String extractedText;

  ScanResult({
    required this.ingredients,
    required this.overallSafety,
    required this.safeCount,
    required this.unsafeCount,
    required this.unknownCount,
    required this.extractedText,
  });

  String get safetyMessage {
    switch (overallSafety) {
      case SafetyLevel.safe:
        return 'All detected ingredients are safe for skin';
      case SafetyLevel.unsafe:
        return 'WARNING: Contains unsafe ingredients for skin';
      case SafetyLevel.unknown:
        return 'No known ingredients detected. Please try again or check manually.';
    }
  }
}