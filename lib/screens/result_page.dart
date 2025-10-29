// lib/screens/result_page.dart
import 'package:flutter/material.dart';
import '../models/scan_result.dart';
import '../services/ingredient_service.dart';
import 'scan_page.dart';
import 'additional_pages.dart';

class ResultPage extends StatelessWidget {
  final ScanResult scanResult;

  const ResultPage({Key? key, required this.scanResult}) : super(key: key);

  Color _getColor(SafetyLevel level) {
    switch (level) {
      case SafetyLevel.safe:
        return Colors.green;
      case SafetyLevel.unsafe:
        return Colors.red;
      case SafetyLevel.unknown:
        return Colors.orange;
    }
  }

  // Get major contributing ingredients (unsafe ones or top 3 if all safe)
  List<IngredientMatch> _getMajorIngredients() {
    if (scanResult.ingredients.isEmpty) return [];

    // First, get all unsafe ingredients
    var unsafeIngredients =
        scanResult.ingredients.where((match) => !match.ingredient.safe).toList();

    // If there are unsafe ingredients, return up to 3
    if (unsafeIngredients.isNotEmpty) {
      return unsafeIngredients.take(3).toList();
    }

    // If all ingredients are safe, return top 3
    return scanResult.ingredients.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    final majorIngredients = _getMajorIngredients();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Results'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Safety Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getColor(scanResult.overallSafety).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _getColor(scanResult.overallSafety)),
              ),
              child: Column(
                children: [
                  Icon(
                    scanResult.overallSafety == SafetyLevel.safe
                        ? Icons.check_circle
                        : scanResult.overallSafety == SafetyLevel.unsafe
                            ? Icons.warning
                            : Icons.help,
                    size: 60,
                    color: _getColor(scanResult.overallSafety),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    scanResult.overallSafety.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getColor(scanResult.overallSafety),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getSafetyMessage(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Major Contributing Ingredients (limited to 3)
            if (majorIngredients.isNotEmpty) ...[
              Text(
                scanResult.overallSafety == SafetyLevel.unsafe
                    ? 'Harmful Contributing Ingredients:'
                    : 'Major Contributing Ingredients:',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...majorIngredients.map(
                (match) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color:
                            match.ingredient.safe ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        match.ingredient.safe ? Icons.check : Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    title: Text(
                      match.ingredient.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: match.ingredient.safe
                            ? Colors.green[700]
                            : Colors.red[700],
                      ),
                    ),
                    subtitle: Text(
                      match.ingredient.description,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color:
                            match.ingredient.safe ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        match.ingredient.safe ? 'SAFE' : 'AVOID',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ] else ...[
              const Text(
                'No major ingredients detected.',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScanPage()),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Rescan'),
                ),
                OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  icon: const Icon(Icons.home),
                  label: const Text('Back to Home'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // --- Buttons to view scan-based info ---
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalizedAlertsPageWithData(
                      ingredients: scanResult.ingredients
                          .map((e) => e.ingredient)
                          .toList(),
                    ),
                  ),
                );
              },
              child: const Text('View Personalized Alerts'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductSafetyRatingPageWithData(
                      ingredients: scanResult.ingredients
                          .map((e) => e.ingredient)
                          .toList(),
                    ),
                  ),
                );
              },
              child: const Text('View Product Safety Rating'),
            ),
            // --- End of new buttons ---
          ],
        ),
      ),
    );
  }

  String _getSafetyMessage() {
    switch (scanResult.overallSafety) {
      case SafetyLevel.safe:
        return 'All detected ingredients appear safe for babies.';
      case SafetyLevel.unsafe:
        return 'Contains potentially harmful ingredients. Review the list below.';
      case SafetyLevel.unknown:
        return 'No known ingredients detected. Please try again or check manually.';
    }
  }
}
