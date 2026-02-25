// import 'package:flutter/material.dart';
// import 'package:job_tracker/features/opt/opt_model/opt_model.dart';
//
// class OptCountdownCard extends StatelessWidget {
//   final int daysLeft;
//
//   const OptCountdownCard({required this.daysLeft});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Text("OPT Days Remaining", style: TextStyle(fontSize: 16)),
//             const SizedBox(height: 10),
//             Text(
//               "$daysLeft Days",
//               style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class UnemploymentCard extends StatelessWidget {
//   final int daysUsed;
//
//   const UnemploymentCard({required this.daysUsed});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.red.shade50,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text("Unemployment Days Used"),
//             Text(
//               "$daysUsed / 90",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class OptTimelineCard extends StatelessWidget {
//   final OptModel opt;
//
//   const OptTimelineCard({required this.opt});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: ListTile(
//         title: Text("OPT Timeline"),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Start: ${opt.optStartDate.toLocal()}"),
//             Text("End: ${opt.optEndDate.toLocal()}"),
//             Text("STEM Eligible: ${opt.stemOptEligible ? "Yes" : "No"}"),
//           ],
//         ),
//       ),
//     );
//   }
// }