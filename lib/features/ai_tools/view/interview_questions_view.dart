import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/button.dart';
import '../../../core/constants/app_colors.dart';
import '../view_models/ai_view_model.dart';
class InterviewQuestionsView extends ConsumerWidget {
  const InterviewQuestionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiResponse = ref.watch(interviewQuestionsProvider);
    final controller = TextEditingController();
    final w=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Interview Questions")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter job role.",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            AppButton(
              width: w*0.62,
              text: 'Generate Questions',
              onPressed: () {

                final prompt =
                    "Generate 10 interview questions with answers for ${controller.text}.";

                ref.read(interviewQuestionsProvider.notifier).generateAIResponse(prompt);
              },
              icon: Icons.question_answer_rounded,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //
            //     final prompt =
            //         "Generate 10 interview questions with answers for ${controller.text}.";
            //
            //     ref.read(interviewQuestionsProvider.notifier).generateAIResponse(prompt);
            //   },
            //   child: const Text("Generate Questions"),
            // ),

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
                    // Markdown Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: MarkdownBody(
                          data: aiResponse ?? "AI result will appear here...",
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