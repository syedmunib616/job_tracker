import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/constants/app_colors.dart';
import 'package:job_tracker/core/widget/button.dart';
import 'package:job_tracker/features/ai_tools/utils/extract_data.dart';
import 'package:job_tracker/features/ai_tools/widgets/Ai_output.dart';
import '../utils/pdf_text_extractor.dart';
import '../view_models/ai_view_model.dart';

class ResumeMatchView extends ConsumerStatefulWidget {
  const ResumeMatchView({super.key});

  @override
  ConsumerState<ResumeMatchView> createState() => _ResumeMatchViewState();
}

class _ResumeMatchViewState extends ConsumerState<ResumeMatchView> {
  String resumeText = "";
  final jobController = TextEditingController();
  final PdfTextExtractorService _pdfService = PdfTextExtractorService();
  final extractor = ExtractData();
  String pathpdf='';
  Future<void> uploadResume(WidgetRef ref) async {
    // 1. Pick file
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return;
    // 2. Get file path
    final path = result.files.single.path!;
    // 3. Convert PDF → Text
    final text = await _pdfService.extractText(path);

    pathpdf=path;
    resumeText=text.toString();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(resumeMatchAnalyzerProvider);
    final w=MediaQuery.of(context).size.width;
    final h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text("Resume Match Analyzer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [
                // Upload Resume Button
                AppButton(
                  width: w*0.4,
                  text: 'Upload Resume',
                  onPressed:() => uploadResume(ref),
                  //icon: Icons.upload_file,
                ),
                Spacer(),
                // Analyze Button
                AppButton(
                  width: w*0.4,
                  text: 'Analyze match',
                  onPressed: () {
                    ref
                        .read(resumeMatchAnalyzerProvider.notifier)
                        .analyzeMatch(resumeText, jobController.text);
                  },
                  //icon: Icons.upload_file,
                ),
              ],
            ),
            SizedBox(height: 5,),
            Text(
              "File path: $pathpdf",
              maxLines: 1,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Job Description Input
            TextField(
              controller: jobController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Paste Job Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: result == null
                      ? const Center(child: Text("No result yet"))
                      : Builder(
                    builder: (_) {
                      final data = extractor.parseAIResponse(result);
                      final score = data["score"];
                      final matching = data["matching"];
                      final missing = data["missing"];

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // MATCH SCORE
                            Text(
                              "Match Score: $score%",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),

                            LinearProgressIndicator(
                              value: score / 100,
                              minHeight: 10,
                            ),

                            const SizedBox(height: 20),

                            // MATCHING SKILLS
                            const Text("Matching Skills",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),

                            Wrap(
                              spacing: 4,
                              children: matching.map<Widget>((skill) {
                                return Chip(

                                  label:  Text(skill,style: Theme.of(context).textTheme.bodySmall?.copyWith(color:  Colors.black

                                  ),),
                                  backgroundColor: Colors.green.shade100,
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 20),

                            // MISSING SKILLS
                            const Text("Missing Skills",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),

                            Wrap(
                              spacing: 8,
                              children: missing.map<Widget>((skill) {
                                return Chip(
                                  label: Text(skill,style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black

                                  ),),
                                  backgroundColor: Colors.red.shade100,
                                );
                              }).toList(),
                            ),
                            Container(
                              height: h*0.6,
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
                                        if (result != null) // Only show if text exists
                                          IconButton(
                                            tooltip: "Copy all text",
                                            icon: const Icon(Icons.copy_all_rounded, size: 20, color: AppColors.textSecondary),
                                            onPressed: () {
                                              Clipboard.setData(ClipboardData(text: result.toString()));
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text("Copied to clipboard!")),
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                  const Divider(height: 1),
                                  AiOutput(aiResult: result),

                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}