import 'package:flutter/material.dart';
import '../models/ingredient.dart';

/// Page showing personalized alerts based on unsafe ingredients
class PersonalizedAlertsPageWithData extends StatelessWidget {
  final List<Ingredient> ingredients;

  const PersonalizedAlertsPageWithData({Key? key, required this.ingredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter only unsafe ingredients
    final unsafeIngredients =
        ingredients.where((ingredient) => !ingredient.safe).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalized Alerts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: unsafeIngredients.isEmpty
            ? const Center(
                child: Text(
                  'No unsafe ingredients detected 🎉',
                  style: TextStyle(fontSize: 18, color: Colors.green),
                ),
              )
            : ListView.builder(
                itemCount: unsafeIngredients.length,
                itemBuilder: (context, index) {
                  final ingredient = unsafeIngredients[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.warning, color: Colors.red),
                      title: Text(
                        ingredient.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      subtitle: Text(ingredient.description),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

/// Page displaying overall product safety rating based on ingredients
class ProductSafetyRatingPageWithData extends StatelessWidget {
  final List<Ingredient> ingredients;

  const ProductSafetyRatingPageWithData({Key? key, required this.ingredients})
      : super(key: key);

  double _calculateSafetyScore() {
    if (ingredients.isEmpty) return 0.0;
    final safeCount = ingredients.where((i) => i.safe).length;
    return (safeCount / ingredients.length) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final score = _calculateSafetyScore();
    final color = score >= 80
        ? Colors.green
        : score >= 50
            ? Colors.orange
            : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Safety Rating'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              score >= 80
                  ? Icons.check_circle
                  : score >= 50
                      ? Icons.warning
                      : Icons.dangerous,
              color: color,
              size: 80,
            ),
            const SizedBox(height: 16),
            Text(
              'Safety Score: ${score.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _getSafetyMessage(score),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  String _getSafetyMessage(double score) {
    if (score >= 80) return 'This product appears safe for baby use.';
    if (score >= 50) return 'Some ingredients may require caution.';
    return 'Unsafe ingredients detected. Avoid using this product.';
  }
}
// -----------------------------------------------------------------------------
// 10. History Page (Saved Scans)
// -----------------------------------------------------------------------------
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  // mock data – replace with real storage later if needed
  final List<Map<String, dynamic>> _mockHistory = const [
    {
      'product': 'Baby Lotion',
      'date': '2025-10-25',
      'safety': 'Safe',
    },
    {
      'product': 'Baby Powder',
      'date': '2025-10-27',
      'safety': 'Unsafe',
    },
    {
      'product': 'Baby Soap',
      'date': '2025-10-28',
      'safety': 'Moderate',
    },
  ];

  Color _colorForSafety(String safety) {
    switch (safety) {
      case 'Safe':
        return Colors.green;
      case 'Unsafe':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan History')),
      body: ListView.builder(
        itemCount: _mockHistory.length,
        itemBuilder: (context, index) {
          final item = _mockHistory[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Icon(Icons.inventory, color: _colorForSafety(item['safety'])),
              title: Text(item['product']),
              subtitle: Text('Date: ${item['date']}'),
              trailing: Text(
                item['safety'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _colorForSafety(item['safety']),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 11. Alternative Products Page
// -----------------------------------------------------------------------------
class AlternativeProductsPage extends StatelessWidget {
  const AlternativeProductsPage({super.key});

  final List<Map<String, String>> _alternatives = const [
    {
      'name': 'Organic Baby Lotion',
      'brand': 'PureSkin',
      'rating': '4.7/5',
    },
    {
      'name': 'Natural Baby Cream',
      'brand': 'GreenMama',
      'rating': '4.6/5',
    },
    {
      'name': 'Hypoallergenic Baby Oil',
      'brand': 'GentleTouch',
      'rating': '4.5/5',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alternative Products')),
      body: ListView.builder(
        itemCount: _alternatives.length,
        itemBuilder: (context, index) {
          final alt = _alternatives[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.eco, color: Colors.green),
              title: Text(alt['name']!),
              subtitle: Text('Brand: ${alt['brand']}'),
              trailing: Text(
                alt['rating']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
