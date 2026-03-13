import 'package:flutter/material.dart';
import 'package:job_tracker/core/widget/drawer.dart';

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
            //
            // const Text(
            //   "AI Tools",
            //   style: TextStyle(
            //     fontSize: 22,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),

            // const SizedBox(height: 8),
            //
            // Container(
            //   height: 2,
            //   width: 120,
            //   color: Colors.grey,
            // ),

            const SizedBox(height: 30),

            _buildToolCard(
              context,
              title: "Resume Analyzer",
              icon: Icons.description,
              route: "/resume-analyzer",
            ),

            const SizedBox(height: 16),

            _buildToolCard(
              context,
              title: "Job Description Analyzer",
              icon: Icons.search,
              route: "/job-analyzer",
            ),

            const SizedBox(height: 16),

            _buildToolCard(
              context,
              title: "Cover Letter Generator",
              icon: Icons.mail,
              route: "/cover-letter",
            ),

            const SizedBox(height: 16),

            _buildToolCard(
              context,
              title: "Interview Questions",
              icon: Icons.question_answer,
              route: "/interview-questions",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required String route,
      }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16)
          ],
        ),
      ),
    );
  }
}