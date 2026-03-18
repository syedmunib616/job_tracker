import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfTextExtractorService {
  Future<String> extractText(String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();

    final document = PdfDocument(inputBytes: bytes);
    final text = PdfTextExtractor(document).extractText();

    document.dispose();

    return text;
  }
}