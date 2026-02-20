import 'package:flutter/material.dart';
import 'package:job_tracker/core/widget/drawer.dart';
import 'package:job_tracker/features/dashboard/widget/job_status_grid.dart';
import 'package:job_tracker/features/dashboard/widget/opt_countdown_card.dart';
import 'package:job_tracker/features/dashboard/widget/recent_application_card.dart' show RecentApplicationsCard;
// import '../../widgets/job_status_grid.dart';
// import '../../widgets/opt_countdown_card.dart';
// import '../../widgets/recent_applications_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Munib Syed"),
        centerTitle: true,
      ),
      drawer: const Drawer(child: AppDrawer()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header + grid
            _SectionHeader(title: 'Application Status'),
            const SizedBox(height: 16),
            const JobStatusGrid(),

            const SizedBox(height: 32),

            // OPT section
            _SectionHeader(title: 'OPT Countdown'),
            const SizedBox(height: 12),
            const OptCountdownCard(),

            const SizedBox(height: 32),

            // Recent applications
            _SectionHeader(title: 'Recent Applications'),
            const SizedBox(height: 12),
            const RecentApplicationsCard(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// Tiny private helper widget (can stay here or move to widgets/ if reused)
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:job_tracker/core/widget/drawer.dart';
// import 'package:job_tracker/features/dashboard/widget/job_stats_chart.dart' show JobStageCard;
//
//
// class Dashbord extends StatelessWidget {
//   const Dashbord({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(title: Text("Munib Syed"),),
//       drawer: Drawer(child: AppDrawer(),),
//       body: SingleChildScrollView(
//         padding:  EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // ── Job Status Grid ────────────────────────────────
//             Text(
//               'Application Status',
//               style: theme.textTheme.titleLarge?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               height: MediaQuery.of(context).size.height*0.395,
//               child: GridView.custom(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 12,
//                   crossAxisSpacing: 12,
//                   childAspectRatio: 1.0, // square by default
//                 ),
//                 childrenDelegate: SliverChildListDelegate([
//                   JobStageCard(
//                     title: 'Applied',
//                     assetPath: 'assets/tick.jpg',
//                     colorOverlay: Color(0xFF014801),
//                     icon: Icons.description,
//                     description: 'Application Submitted',
//                   ),
//                   JobStageCard(
//                     title: 'Interview',
//                     assetPath: 'assets/interview.jpg',
//                     colorOverlay: Color(0xFF00135B),
//                     icon: Icons.people,
//                     description: 'Scheduled / In Progress',
//                   ),
//                   JobStageCard(
//                     title: 'Offer',
//                     assetPath: 'assets/offer.jpg',
//                     colorOverlay: Color(0xFF4F2701),
//                     icon: Icons.workspace_premium,
//                     description: 'Job Offer Received',
//                   ),
//                   JobStageCard(
//                     title: 'Rejected',
//                     assetPath: 'assets/rejected.jpg',
//                     colorOverlay: Color(0xFF5B0303),
//                     icon: Icons.cancel,
//                     description: 'Not Selected',
//                   ),
//                 ]),
//               ),
//             ),
//             const SizedBox(height: 32),
//             // ── OPT Countdown ──────────────────────────────────
//             Text(
//               'OPT Countdown',
//               style: theme.textTheme.titleLarge?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             Card(
//               elevation: theme.brightness == Brightness.dark ? 2 : 4,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '90 Days Rule Tracker',
//                           style: theme.textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Chip(
//                           label: const Text('Active'),
//                           backgroundColor: Colors.green.withOpacity(0.15),
//                           labelStyle: const TextStyle(color: Colors.green),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     _InfoRow(
//                       label: 'Start Date',
//                       value: 'May 20, 2026',
//                     ),
//                     const SizedBox(height: 12),
//                     _InfoRow(
//                       label: 'Days Left',
//                       value: '65',
//                       valueStyle: TextStyle(
//                         color: Colors.green.shade700,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     _InfoRow(
//                       label: 'Unemployment Used',
//                       value: '15 days',
//                     ),
//                     const SizedBox(height: 16),
//
//                     // Optional: simple progress bar
//                     LinearProgressIndicator(
//                       value: 15 / 90, // unemployment / total allowed
//                       backgroundColor: Colors.grey[300],
//                       minHeight: 8,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '15 / 90 days used',
//                       style: theme.textTheme.bodySmall,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 32),
// // ── Recent Applications ────────────────────────────
//             Text(
//               'Recent Applications',
//               style: theme.textTheme.titleLarge?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             Card(
//               elevation: theme.brightness == Brightness.dark ? 2 : 4,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               child: Column(
//                 children: const [
//                   _ApplicationTile(
//                     company: 'Google',
//                     status: 'Applied',
//                     statusColor: Colors.blue,
//                   ),
//                   Divider(height: 1),
//                   _ApplicationTile(
//                     company: 'Amazon',
//                     status: 'Interview',
//                     statusColor: Colors.orange,
//                   ),
//                   Divider(height: 1),
//                   _ApplicationTile(
//                     company: 'Meta',
//                     status: 'Rejected',
//                     statusColor: Colors.red,
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;
//   final TextStyle? valueStyle;
//
//   const _InfoRow({
//     required this.label,
//     required this.value,
//     this.valueStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//             color: Theme.of(context).colorScheme.onSurfaceVariant,
//           ),
//         ),
//         Text(
//           value,
//           style: valueStyle ?? Theme.of(context).textTheme.bodyLarge?.copyWith(
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _ApplicationTile extends StatelessWidget {
//   final String company;
//   final String status;
//   final Color statusColor;
//
//   const _ApplicationTile({
//     required this.company,
//     required this.status,
//     required this.statusColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: statusColor.withOpacity(0.15),
//         child: Icon(Icons.work_outline, color: statusColor),
//       ),
//       title: Text(
//         company,
//         style: const TextStyle(fontWeight: FontWeight.w600),
//       ),
//       trailing: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: statusColor.withOpacity(0.15),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           status,
//           style: TextStyle(
//             color: statusColor,
//             fontWeight: FontWeight.w600,
//             fontSize: 13,
//           ),
//         ),
//       ),
//     );
//   }
// }
