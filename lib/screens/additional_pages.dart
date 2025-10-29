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
// -----------------------------------------------------------------------------
// 12. Ingredient Education Page
// -----------------------------------------------------------------------------
class IngredientEducationPage extends StatelessWidget {
  const IngredientEducationPage({super.key});

  final List<Map<String, String>> _ingredientInfo = const [
    {
      'name': 'Paraben',
      'description':
          'A preservative that can cause skin irritation. Avoid in baby products.',
    },
    {
      'name': 'Fragrance',
      'description':
          'Synthetic fragrances can trigger allergies in sensitive skin.',
    },
    {
      'name': 'Aloe Vera',
      'description':
          'Natural moisturizer that soothes and hydrates baby skin safely.',
    },
    {
      'name': 'Zinc Oxide',
      'description':
          'Commonly used in diaper creams, provides a protective barrier.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingredient Education')),
      body: ListView.builder(
        itemCount: _ingredientInfo.length,
        itemBuilder: (context, index) {
          final info = _ingredientInfo[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.science, color: Colors.blue),
              title: Text(info['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(info['description']!),
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 13. My Profile Page
// -----------------------------------------------------------------------------
class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text('Name: Harshini Prabhakaran',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Email: harshini@example.com',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Preferred Mode: Baby Product Scanner',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Account Type: Standard User',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 14. App Feedback Page
// -----------------------------------------------------------------------------
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _controller = TextEditingController();
  double _rating = 0;

  void _submitFeedback() {
    final feedback = _controller.text;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          _rating == 0 && feedback.isEmpty
              ? 'Please provide feedback before submitting!'
              : 'Thank you for your feedback!'),
    ));
    _controller.clear();
    setState(() => _rating = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rate your experience:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: List.generate(5, (index) {
                final starIndex = index + 1;
                return IconButton(
                  icon: Icon(
                    _rating >= starIndex ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 30,
                  ),
                  onPressed: () => setState(() => _rating = starIndex.toDouble()),
                );
              }),
            ),
            const SizedBox(height: 16),
            const Text('Share your thoughts:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type your feedback here...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _submitFeedback,
                child: const Text('Submit Feedback'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
