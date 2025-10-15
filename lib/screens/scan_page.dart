// lib/screens/scan_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/ingredient.dart';
import '../models/scan_result.dart';
import '../services/ingredient_service.dart';
import 'processing_page.dart';
import 'result_page.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProcessingPage(imageFile: File(pickedFile.path)),
        ),
      );
    }
  }

  void _navigateToSampleResult(BuildContext context) {
    // Sample data for testing the ResultPage with major ingredients (limited to 3 unsafe + safe)
    final sampleResult = ScanResult(
      overallSafety: SafetyLevel.unsafe,
      extractedText: 'Sample extracted text: Water, Parabens, Fragrance, Glycerin, Alcohol',
      ingredients: [
        IngredientMatch(
          ingredient: Ingredient(
            name: 'Water',
            description: 'Safe hydrating base ingredient.',
            safe: true,
          ),
          matched: true,
        ),
        IngredientMatch(
          ingredient: Ingredient(
            name: 'Parabens',
            description: 'Preservative that may cause skin irritation or allergic reactions.',
            safe: false,
          ),
          matched: true,
        ),
        IngredientMatch(
          ingredient: Ingredient(
            name: 'Fragrance',
            description: 'Synthetic scent; common allergen and potential irritant.',
            safe: false,
          ),
          matched: true,
        ),
        IngredientMatch(
          ingredient: Ingredient(
            name: 'Glycerin',
            description: 'Humectant that helps retain moisture; generally safe.',
            safe: true,
          ),
          matched: true,
        ),
        IngredientMatch(
          ingredient: Ingredient(
            name: 'Alcohol',
            description: 'Drying agent; can be irritating for sensitive skin.',
            safe: false,
          ),
          matched: true,
        ),
      ],
      safeCount: 2,
      unsafeCount: 3,
      unknownCount: 0,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(scanResult: sampleResult),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Product'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 32),
              const Text(
                'Scan or upload a product label',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Capture the ingredients list for safety analysis',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: () => _pickImage(context, ImageSource.camera),
                icon: const Icon(Icons.camera),
                label: const Text('Capture with Camera'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _pickImage(context, ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text('Upload from Gallery'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => _navigateToSampleResult(context),
                icon: const Icon(Icons.bug_report),
                label: const Text('Test with Sample Data'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}