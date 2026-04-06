import 'package:flutter/material.dart';
import 'package:job_tracker/core/widget/drawer.dart';
import 'package:job_tracker/features/ai_tools/widgets/build_tool_card.dart';

class AIToolsView extends StatelessWidget {
  const AIToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Tools"),
      ),
      drawer:  Drawer(child: AppDrawer()),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            const SizedBox(height: 30),
            BuildToolCardAI(context: context, title: "Resume vs Job Match Score", icon: Icons.score_rounded, route: "/resume-match"),

            const SizedBox(height: 16),
            BuildToolCardAI(context: context, title: "Resume Analyzer", icon: Icons.description, route: "/resume-analyzer"),

            const SizedBox(height: 16),

            BuildToolCardAI(context: context, title: "Job Description Analyzer", icon: Icons.search, route: "/job-analyzer"),

            const SizedBox(height: 16),

            BuildToolCardAI(context: context, title: "Cover Letter Generator", icon: Icons.mail, route: "/cover-letter"),

            const SizedBox(height: 16),

            BuildToolCardAI(context: context, title: "Interview Questions", icon: Icons.question_answer, route: "/interview-questions"),
          ],
        ),
      ),
    );
  }
}

