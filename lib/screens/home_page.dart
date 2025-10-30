import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart' as app_auth; // Alias to avoid potential Firebase conflict
import 'login_page.dart';
import 'scan_page.dart';
import 'cart_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'additional_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<app_auth.AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'LabelLens',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Scan. Decode. Stay Safe.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanPage()));
                  },
                  child: const Text('Get Started'),
                ),
                const SizedBox(height: 12),

                // ---- New feature navigation buttons ----
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PersonalizedAlertsPage()),
                    );
                  },
                  child: const Text('Personalized Alerts'),
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductSafetyRatingPage()),
                    );
                  },
                  child: const Text('Product Safety Rating'),
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HistoryPage()),
                    );
                  },
                  child: const Text('History'),
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AlternativeProductsPage()),
                    );
                  },
                  child: const Text('Alternative Products'),
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePageNew()),
                    );
                  },
                  child: const Text('Profile'),
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage()),
                    );
                  },
                  child: const Text('Settings'),
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpSupportPage()),
                    );
                  },
                  child: const Text('Help & Support'),
                ),
                const SizedBox(height: 30),
                // ---- End of new buttons ----
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (!auth.isLoggedIn) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
            return;
          }
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsPage()));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
              break;
          }
        },
      ),
    );
  }
}
