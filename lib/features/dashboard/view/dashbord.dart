import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/providers/auth_providers.dart';
import 'package:job_tracker/core/services/notification_service.dart';
import 'package:job_tracker/core/widget/app_loader.dart';
import 'package:job_tracker/core/widget/button.dart';
import 'package:job_tracker/core/widget/drawer.dart';
import 'package:job_tracker/features/dashboard/widget/kpi_section.dart';
import 'package:job_tracker/features/dashboard/widget/kpi_card.dart';
import 'package:job_tracker/features/dashboard/widget/recent_application_card.dart' show RecentApplicationsCard;
import 'package:job_tracker/features/employment/view/upload_resume_view.dart';
import 'package:job_tracker/features/employment/view_models/employment_view_model.dart';
import 'package:job_tracker/features/jobs/view_models/job_view_model.dart';
import 'package:job_tracker/features/opt/opt_view_model/opt_view_model.dart';
import 'package:job_tracker/features/opt/view/opt_view.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../auth/view_models/auth_view_model.dart';
import '../widget/applications_per_month_chart.dart';

class Dashboard extends ConsumerWidget {

   Dashboard({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final opt = ref.watch(optProvider);
    final userAsync = ref.watch(authStateUserProvider);

    // final employmentAsync = ref.watch(jobsProvider);
    final employmentAsync = ref.watch(employmentStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title:  userAsync.when(
          data: (user) {
            // return
            if (user == null) {
              return const SizedBox(); // or loader
            }

            final name = user.displayName?.isNotEmpty == true
                ? user.displayName!
                : user.email ?? '';

            return Text(
              name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            );
          },
          loading: () => const AppLoader(
           // message: "Loading Email...",
          ),
          error: (e, _) => Text(e.toString()),
        ),

        centerTitle: true,
      ),
      drawer:  Drawer(child: AppDrawer()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GestureDetector(
            //   onTap: (){
            //     NotificationService().testSchedule();
            //   },
            //   child : Container(
            //     height: 100,
            //     width: 100,
            //     child: Text("submit"),
            //   ),
            // ),
            KpiSection(),
            const SizedBox(height: 24),
            _SectionHeader(title: 'Applications per Month'),
            const ApplicationsPerMonthChart(),
            const SizedBox(height: 24),
            // Section header + grid
            // _SectionHeader(title: 'Application Status'),
            // const SizedBox(height: 16),
            // const JobStatusGrid(),

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
                if (opt == null) {
                  return const Text("No OPT Setup Found");
                }
                return employmentAsync.when(
                  data: (jobs) {
                    return OptCountdownCard(
                      opt: opt,
                      employments: jobs,
                    );
                  },
                  loading: () =>
                  AppLoader(),
                  error: (e, _) => Text(e.toString()),
                );
              },
              loading: () => AppLoader(),
              error: (e, _) {
                print(":::::::::::$e");
                return Text("No Data");

              }
            ),

            // opt.when(
            //   data: (opt) {
            //     if (opt == null) return Text("No OPT Setup Found");
            //     return OptCountdownCard(opt: opt);
            //   },
            //   loading: () => CircularProgressIndicator(),
            //   error: (e, _) => Text(e.toString()),
            // ),
            const SizedBox(height: 32),

            // Recent applications
            // _SectionHeader(title: 'Recent Applications'),
            // const SizedBox(height: 12),
            // const RecentApplicationsCard(),

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




