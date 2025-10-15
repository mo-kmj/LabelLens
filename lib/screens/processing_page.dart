// lib/screens/processing_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/scan_result.dart';
import '../services/ocr_service.dart';
import '../services/ingredient_service.dart';
import 'result_page.dart';

class ProcessingPage extends StatefulWidget {
  final File imageFile;

  const ProcessingPage({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<ProcessingPage> createState() => _ProcessingPageState();
}

class _ProcessingPageState extends State<ProcessingPage> {
  @override
  void initState() {
    super.initState();
    _processImage();
  }

  Future<void> _processImage() async {
    try {
      final extractedText = await OCRService.extractTextFromImage(widget.imageFile.path);
      final ingredientService = Provider.of<IngredientService>(context, listen: false);
      final result = await ingredientService.analyzeIngredients(extractedText);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(scanResult: result),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error processing image: $e')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SpinKitFadingCircle(
              color: Colors.blue,
              size: 80.0,
            ),
            SizedBox(height: 24),
            Text(
              'Processing label...',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Extracting and analyzing ingredients',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}