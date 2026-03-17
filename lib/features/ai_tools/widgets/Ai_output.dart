import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:job_tracker/core/constants/app_colors.dart';

class AiOutput extends StatelessWidget {
  const AiOutput({
    super.key,
    required this.aiResult,
  });

  final String? aiResult;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}