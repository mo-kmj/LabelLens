// lib/screens/notifications_page.dart
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: const Center(
        child: Text(
          'No notifications yet',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }
}