import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

class OCRService {
  static Future<String> extractTextFromImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();

    try {
      final RecognizedText recognizedText = 
          await textRecognizer.processImage(inputImage);
      
      String extractedText = recognizedText.text;
      
      // Clean up the text
      extractedText = extractedText
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
      
      await textRecognizer.close();
      
      return extractedText;
    } catch (e) {
      await textRecognizer.close();
      throw Exception('Failed to extract text: $e');
    }
  }
}