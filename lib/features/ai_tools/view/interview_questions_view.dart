import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/ai_view_model.dart';

class InterviewQuestionsView extends ConsumerWidget {
  const InterviewQuestionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiResponse = ref.watch(aiProvider);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Interview Questions")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter job role (e.g. Flutter Developer)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {

                final prompt =
                    "Generate 10 interview questions with answers for ${controller.text}.";

                ref.read(aiProvider.notifier).generateAIResponse(prompt);
              },
              child: const Text("Generate Questions"),
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