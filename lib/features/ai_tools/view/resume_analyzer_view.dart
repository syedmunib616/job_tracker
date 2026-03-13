import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/ai_view_model.dart';

class ResumeAnalyzerView extends ConsumerWidget {
  const ResumeAnalyzerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiResponse = ref.watch(aiProvider);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Resume Analyzer")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "Paste your resume here...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final prompt =
                    "Analyze this resume and suggest improvements for a Flutter developer job in the USA:\n${controller.text}";

                ref.read(aiProvider.notifier).generateAIResponse(prompt);
              },
              child: const Text("Analyze Resume"),
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