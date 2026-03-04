import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/app_loader.dart';
import 'package:job_tracker/features/jobs/view_models/job_view_model.dart';

// class KpiCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color color;
//
//   const KpiCard({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.icon,
//     required this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final w=MediaQuery.sizeOf(context).width;
//     final h=MediaQuery.sizeOf(context).height;
//     return Container(
//       // height: 200,
//       // width: 500,
//        //color: Colors.grey,
//       padding:  EdgeInsets.all(13),
//       // decoration: BoxDecoration(
//       //   color: color.withOpacity(0.1),
//       //   borderRadius: BorderRadius.circular(16),
//       // ),
//
//       child:Expanded(
//         flex: 1,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min, // Added to keep it compact
//           children: [
//             Expanded(
//               flex: 1,
//               child: CircleAvatar(
//                 // radius: ,
//                 backgroundColor: color.withOpacity(0.2),
//                 child: Icon(icon, color: color,size: h*0.025,),
//               ),
//             ),
//             SizedBox(width: w*0.01),
//             // Wrap the Column in Expanded
//             Expanded(
//               flex: 2,
//               child: SizedBox(
//                 //color: Colors.blue,
//                 // width: w*0.1,
//                 height: h*0.07,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min, // Added to keep it compact
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       title,
//                       style: Theme.of(context).textTheme.bodySmall,
//                       maxLines: 1,
//
//                       overflow: TextOverflow.ellipsis, // Prevents horizontal overflow
//                     ),
//                      SizedBox(height: h*0.003),
//                     Text(
//                       value,
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis, // Prevents horizontal overflow
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//
//       // child: Row(
//       //   children: [
//       //     CircleAvatar(
//       //       backgroundColor: color.withOpacity(0.2),
//       //       child: Icon(icon, color: color),
//       //     ),
//       //     const SizedBox(width: 12),
//       //     Column(
//       //       crossAxisAlignment: CrossAxisAlignment.start,
//       //       mainAxisSize: MainAxisSize.min,
//       //       children: [
//       //         Text(
//       //           title,
//       //           style: Theme.of(context).textTheme.bodySmall,
//       //         ),
//       //         const SizedBox(height: 4),
//       //         Text(
//       //           value,
//       //           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//       //             fontWeight: FontWeight.bold,
//       //           ),
//       //           overflow: TextOverflow.ellipsis,
//       //         ),
//       //       ],
//       //     )
//       //   ],
//       // ),
//     );
//   }
// }
class KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const KpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: h * 0.025),
          ),

          SizedBox(width: w * 0.02),

          Expanded( // ✅ Expanded ONLY here (inside Row)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: h * 0.005),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class KpiSection extends ConsumerWidget {
  const KpiSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(jobsProvider);

    return jobsAsync.when(
      data: (jobs) {
        final total = jobs.length;

        final interviews =
            jobs.where((job) => job.status == 'Interview').length;

        final offers =
            jobs.where((job) => job.status == 'Offer').length;

        final rejections =
            jobs.where((job) => job.status == 'Rejected').length;

        final interviewRate =
        total == 0 ? 0 : (interviews / total) * 100;

        final offerRate =
        interviews == 0 ? 0 : (offers / interviews) * 100;


        return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            KpiCard(
              title: "Total Applications",
              value: total.toString(),
              icon: Icons.work_outline,
              color: Colors.blue,
            ),
            KpiCard(
              title: "Interviews",
              value: interviews.toString(),
              icon: Icons.record_voice_over,
              color: Colors.orange,
            ),
            KpiCard(
              title: "Offers",
              value: offers.toString(),
              icon: Icons.check_circle_outline,
              color: Colors.green,
            ),
            KpiCard(
              title: "Rejections",
              value: rejections.toString(),
              icon: Icons.cancel_outlined,
              color: Colors.red,
            ),
            KpiCard(
              title: "Interview Rate",
              value: "${interviewRate.toStringAsFixed(1)}%",
              icon: Icons.bar_chart,
              color: Colors.purple,
            ),
            KpiCard(
              title: "Offer Rate",
              value: "${offerRate.toStringAsFixed(1)}%",
              icon: Icons.trending_up,
              color: Colors.teal,
            ),
          ],
        );
      },
      loading: () => SizedBox(
          height: 100,
          width: 100,
          child: const Center(child: AppLoader())),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}