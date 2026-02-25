import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/drawer.dart';
import 'package:job_tracker/features/dashboard/widget/job_status_grid.dart';
import 'package:job_tracker/features/dashboard/widget/opt_countdown_card.dart';
import 'package:job_tracker/features/dashboard/widget/recent_application_card.dart' show RecentApplicationsCard;
import 'package:job_tracker/features/opt/opt_view_model/opt_view_model.dart';
import 'package:job_tracker/features/opt/view/opt_view.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final opt = ref.watch(optProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Munib Syed"),
        centerTitle: true,
      ),
      drawer:  Drawer(child: AppDrawer()),
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
            // const OptCountdownCard(),
            //   opt.when(
            //     data: (opt) {
            //       if (opt == null) return Center(child: Text("No OPT Data"));
            //
            //       final daysLeft = opt.optEndDate.difference(DateTime.now()).inDays;
            //
            //       return Padding(
            //         padding: const EdgeInsets.all(16),
            //         child: Column(
            //           children: [
            //             // OptCountdownCard(daysLeft: daysLeft),
            //
            //             const SizedBox(height: 16),
            //             UnemploymentCard(daysUsed: opt.unemploymentDaysUsed),
            //             const SizedBox(height: 16),
            //             OptTimelineCard(opt: opt),
            //           ],
            //         ),
            //       );
            //     },
            //     loading: () => CircularProgressIndicator(),
            //     error: (e, _) => Text(e.toString()),
            //   ),
            opt.when(
              data: (opt) {
                if (opt == null) return Text("No OPT Setup Found");
                return OptCountdownCard(opt: opt);
              },
              loading: () => CircularProgressIndicator(),
              error: (e, _) => Text(e.toString()),
            ),
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


