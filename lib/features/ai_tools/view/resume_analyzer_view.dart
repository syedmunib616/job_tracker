import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/button.dart';
import 'package:job_tracker/features/ai_tools/widgets/Ai_output.dart';
import '../../../core/constants/app_colors.dart';
import '../view_models/ai_view_model.dart';

class ResumeAnalyzerView extends ConsumerWidget {
  const ResumeAnalyzerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiResponse = ref.watch(resumeAnalyzerProvider);
    final controller = TextEditingController();
    final w=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Resume Analyzer")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Row(
              children: [
                AppButton(
                  width: w*0.41,
                  text: 'Analyze Resume',
                  onPressed: () {
                    final prompt =
                        "Analyze this resume and suggest improvements for job in the USA:\n${controller.text}";

                    ref.read(resumeAnalyzerProvider.notifier)
                        .generateAIResponse(prompt);
                  },
                  //icon: Icons.upload_file,
                ),
                Spacer(),
                Text(
                  "or",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),

                AppButton(
                  width: w*0.41,
                  text: 'Upload Resume',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/resume-button");
                  },
                  //icon: Icons.upload_file,
                ),

              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "Paste your resume here...",
                border: OutlineInputBorder(),
              ),
            ),



            const SizedBox(height: 10),

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
                          if (aiResponse != null) // Only show if text exists
                            IconButton(
                              tooltip: "Copy all text",
                              icon: const Icon(Icons.copy_all_rounded, size: 20, color: AppColors.textSecondary),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: aiResponse.toString()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Copied to clipboard!")),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),

                    AiOutput(aiResult: aiResponse),

                    // Markdown Content
                    // Expanded(
                    //   child: SingleChildScrollView(
                    //     padding: const EdgeInsets.all(16),
                    //     child: MarkdownBody(
                    //       data: aiResponse ?? "AI result will appear here...",
                    //       selectable: true,
                    //       styleSheet: MarkdownStyleSheet(
                    //         h3: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold, height: 2),
                    //         p: const TextStyle(fontSize: 15, height: 1.5),
                    //         blockSpacing: 12,
                    //       ),
                    //     ),
                    //   ),
                    // ),
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