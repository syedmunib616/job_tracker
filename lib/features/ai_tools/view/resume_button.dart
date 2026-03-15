import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/button.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../core/constants/app_colors.dart';
import '../view_models/ai_view_model.dart';

class ResumeButton extends ConsumerWidget {
  const ResumeButton({super.key});


  Future<String> extractTextFromPDF(PlatformFile file) async {
    final bytes = file.bytes!;
    final PdfDocument document = PdfDocument(inputBytes: bytes);

    String text = PdfTextExtractor(document).extractText();

    document.dispose();

    return text;
  }

  Future<void> uploadResume(WidgetRef ref) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result == null) return;

    final file = result.files.first;

    final text = await extractTextFromPDF(file);

    ref.read(resumeAnalyzerProvider.notifier).analyzeResume(text);
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiResult = ref.watch(resumeAnalyzerProvider);
    final w=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Resume Analyzer")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // Upload Button
            // ElevatedButton(
            //   onPressed: () => uploadResume(ref),
            //   child: const Text("Upload Resume"),
            // ),

            AppButton(
              width: w*0.41,
              text: 'Upload Resume',
              onPressed:() => uploadResume(ref),
              //icon: Icons.upload_file,
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    // Header with Copy Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("AI Generated Content",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                          if (aiResult != null) // Only show if text exists
                            IconButton(
                              tooltip: "Copy all text",
                              icon: const Icon(Icons.copy_all_rounded, size: 20, color: AppColors.textSecondary),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: aiResult.toString()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Copied to clipboard!")),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Markdown Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: MarkdownBody(
                          data: aiResult ?? "AI result will appear here...",
                          selectable: true,
                          styleSheet: MarkdownStyleSheet(
                            h3: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold, height: 2),
                            p: const TextStyle(fontSize: 15, height: 1.5),
                            blockSpacing: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}