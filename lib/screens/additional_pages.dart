import 'package:flutter/material.dart';

class SimplePage extends StatelessWidget {
  final String title;
  const SimplePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title Page Content Here',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

// Named widgets for clarity
class PersonalizedAlertsPage extends SimplePage {
  const PersonalizedAlertsPage({super.key}) : super(title: 'Personalized Alerts');
}

class ProductSafetyRatingPage extends SimplePage {
  const ProductSafetyRatingPage({super.key}) : super(title: 'Product Safety Rating');
}

class HistoryPage extends SimplePage {
  const HistoryPage({super.key}) : super(title: 'History');
}

class AlternativeProductsPage extends SimplePage {
  const AlternativeProductsPage({super.key}) : super(title: 'Alternative Products');
}

class ProfilePageNew extends SimplePage {
  const ProfilePageNew({super.key}) : super(title: 'Profile');
}

class SettingsPage extends SimplePage {
  const SettingsPage({super.key}) : super(title: 'Settings');
}

class HelpSupportPage extends SimplePage {
  const HelpSupportPage({super.key}) : super(title: 'Help & Support');
}

// ===============================================
// Pages that use scanned ingredient data
// ===============================================

class PersonalizedAlertsPageWithData extends StatelessWidget {
  final List ingredients;
  const PersonalizedAlertsPageWithData({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final alerts = ingredients
        .where((ing) =>
            ing.toString().toLowerCase().contains('paraben') ||
            ing.toString().toLowerCase().contains('sulfate') ||
            ing.toString().toLowerCase().contains('alcohol'))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Personalized Alerts')),
      body: alerts.isEmpty
          ? const Center(child: Text('No harmful ingredients found!'))
          : ListView(
              children: alerts
                  .map((a) => ListTile(
                        title: Text(a),
                        leading: const Icon(Icons.warning, color: Colors.red),
                      ))
                  .toList(),
            ),
    );
  }
}

class ProductSafetyRatingPageWithData extends StatelessWidget {
  final List ingredients;
  const ProductSafetyRatingPageWithData({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final risky = ingredients
        .where((ing) =>
            ing.toString().toLowerCase().contains('paraben') ||
            ing.toString().toLowerCase().contains('sulfate') ||
            ing.toString().toLowerCase().contains('alcohol'))
        .length;
    final rating = (10 - risky).clamp(1, 10);

    return Scaffold(
      appBar: AppBar(title: const Text('Product Safety Rating')),
      body: Center(
        child: Text(
          'Safety Score: $rating / 10',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
