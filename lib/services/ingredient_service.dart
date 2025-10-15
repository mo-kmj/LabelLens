// lib/services/ingredient_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/ingredient.dart';
import '../models/scan_result.dart';

class IngredientService extends ChangeNotifier {
  List<Ingredient> _ingredients = [];
  bool _isLoaded = false;

  Future<void> loadIngredients() async {
    if (_isLoaded) return;

    try {
      final String response = await rootBundle.loadString('assets/ingredients.json');
      final data = json.decode(response);
      
      // Fix: JSON is a direct list, not wrapped in 'ingredients'
      _ingredients = (data as List)
          .map((json) => Ingredient.fromJson(json))
          .toList();
      
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading ingredients: $e');
    }
  }

  Future<ScanResult> analyzeIngredients(String extractedText) async {
    if (!_isLoaded) {
      await loadIngredients();
    }

    final text = extractedText.toLowerCase();
    final List<IngredientMatch> detectedIngredients = [];
    
    for (final ingredient in _ingredients) {
      if (text.contains(ingredient.name.toLowerCase())) {
        detectedIngredients.add(IngredientMatch(
          ingredient: ingredient,
          matched: true,
        ));
      }
    }

    if (detectedIngredients.isEmpty) {
      return ScanResult(
        ingredients: [],
        overallSafety: SafetyLevel.unknown,
        safeCount: 0,
        unsafeCount: 0,
        unknownCount: 1,
        extractedText: extractedText,
      );
    }

    final safeCount = detectedIngredients
        .where((i) => i.ingredient.safe)
        .length;
    final unsafeCount = detectedIngredients
        .where((i) => !i.ingredient.safe)
        .length;

    SafetyLevel overallSafety;
    if (unsafeCount > 0) {
      overallSafety = SafetyLevel.unsafe;
    } else if (safeCount > 0) {
      overallSafety = SafetyLevel.safe;
    } else {
      overallSafety = SafetyLevel.unknown;
    }

    return ScanResult(
      ingredients: detectedIngredients,
      overallSafety: overallSafety,
      safeCount: safeCount,
      unsafeCount: unsafeCount,
      unknownCount: 0,
      extractedText: extractedText,
    );
  }
}

class IngredientMatch {
  final Ingredient ingredient;
  final bool matched;

  IngredientMatch({
    required this.ingredient,
    required this.matched,
  });
}