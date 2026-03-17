import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/button.dart';
import 'package:job_tracker/features/ai_tools/widgets/Ai_output.dart';
import '../../../core/constants/app_colors.dart';
import '../view_models/ai_view_model.dart';

class JobDescriptionAnalyzerView extends ConsumerWidget {
  const JobDescriptionAnalyzerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiResponse = ref.watch(jobAnalyzerProvider);
    final controller = TextEditingController();
    final w=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Job Description Analyzer")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "Paste job description...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            AppButton(
              width: w*0.52,
              text: 'Analyze Job',
                onPressed: () {
                  final prompt =
                      "Extract the required skills from this job description:\n${controller.text}";

                  ref.read(jobAnalyzerProvider.notifier).generateAIResponse(prompt);
                },
              icon: Icons.document_scanner,
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

                    // // Markdown Content
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
            //
            // const SizedBox(height: 20),
            //
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Text(aiResponse ?? "AI result will appear here"),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}