// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart' as app_auth;  // Alias to avoid potential Firebase conflict
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('LabelLens', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Text('Scan. Decode. Stay Safe.', style: TextStyle(fontSize: 18)),
            ElevatedButton(
              onPressed: () {
                // Since HomePage is only shown when logged in, always navigate to ScanPage
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanPage()));
              },
              child: const Text('Get Started'),
            ),
                        // ---- New feature navigation buttons ----
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PersonalizedAlertsPage()));
              },
              child: const Text('Personalized Alerts'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProductSafetyRatingPage()));
              },
              child: const Text('Product Safety Rating'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()));
              },
              child: const Text('History'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AlternativeProductsPage()));
              },
              child: const Text('Alternative Products'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePageNew()));
              },
              child: const Text('Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()));
              },
              child: const Text('Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HelpSupportPage()));
              },
              child: const Text('Help & Support'),
            ),
            // ---- End of new buttons ----

          ],
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
          // Redundant check since HomePage is for logged-in users, but kept for safety
          if (!auth.isLoggedIn) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
            return;
          }
          switch (index) {
            case 0:
              // Stay on home
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
