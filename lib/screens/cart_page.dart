// lib/screens/cart_page.dart
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: const Center(
        child: Text(
          'Your cart is empty',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }
}