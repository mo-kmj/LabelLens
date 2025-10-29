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
