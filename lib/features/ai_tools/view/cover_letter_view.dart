import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/ai_view_model.dart';

class CoverLetterView extends ConsumerWidget {
  const CoverLetterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiResponse = ref.watch(aiProvider);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Cover Letter Generator")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: controller,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Enter job title, company, experience...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                final prompt =
                    "Write a professional cover letter for this job:\n${controller.text}";

                ref.read(aiProvider.notifier).generateAIResponse(prompt);
              },
              child: const Text("Generate Cover Letter"),
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