import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/ai_view_model.dart';

class JobDescriptionAnalyzerView extends ConsumerWidget {
  const JobDescriptionAnalyzerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiResponse = ref.watch(aiProvider);
    final controller = TextEditingController();

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

            ElevatedButton(
              onPressed: () {
                final prompt =
                    "Extract the required skills from this job description:\n${controller.text}";

                ref.read(aiProvider.notifier).generateAIResponse(prompt);
              },
              child: const Text("Analyze Job"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Text(aiResponse ?? "AI result will appear here"),
              ),
            )
          ],
        ),
      ),
    );
  }
}