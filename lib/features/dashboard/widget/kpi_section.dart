import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/app_loader.dart';
import 'package:job_tracker/features/dashboard/widget/kpi_card.dart';
import 'package:job_tracker/features/jobs/view_models/job_view_model.dart';

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