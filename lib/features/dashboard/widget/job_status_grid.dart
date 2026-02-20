import 'package:flutter/material.dart';
import 'package:job_tracker/features/dashboard/widget/job_stats_chart.dart' show JobStageCard; // or rename to StatusCard

class JobStatusGrid extends StatelessWidget {
  const JobStatusGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.395,
      child: GridView.custom(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.0,
        ),
        childrenDelegate: SliverChildListDelegate([
          JobStageCard(
            title: 'Applied',
            assetPath: 'assets/tick.jpg',
            colorOverlay: const Color(0xFF014801),
            icon: Icons.description,
            description: 'Application Submitted',
          ),
          JobStageCard(
            title: 'Interview',
            assetPath: 'assets/interview.jpg',
            colorOverlay: const Color(0xFF00135B),
            icon: Icons.people,
            description: 'Scheduled / In Progress',
          ),
          JobStageCard(
            title: 'Offer',
            assetPath: 'assets/offer.jpg',
            colorOverlay: const Color(0xFF4F2701),
            icon: Icons.workspace_premium,
            description: 'Job Offer Received',
          ),
          JobStageCard(
            title: 'Rejected',
            assetPath: 'assets/rejected.jpg',
            colorOverlay: const Color(0xFF5B0303),
            icon: Icons.cancel,
            description: 'Not Selected',
          ),
        ]),
      ),
    );
  }
}