import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/constants/app_colors.dart';
import 'package:job_tracker/core/widget/app_loader.dart';
import 'package:job_tracker/core/widget/button.dart';
import 'package:job_tracker/core/widget/drawer.dart';
import 'package:job_tracker/features/employment/view/resumes_list_view.dart';
import 'package:job_tracker/features/employment/view/upload_resume_view.dart';
import 'package:job_tracker/features/employment/view_models/employment_view_model.dart';

import 'employment_form_view.dart';

class EmploymentListView extends ConsumerWidget {
  const EmploymentListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employmentAsync = ref.watch(employmentStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Employment History")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EmploymentFormView()),
          );
        },
        child: Icon(Icons.add, color: AppColors.textSecondary),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          //  Two buttons at the top
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButton(
                  width: 160,
                  text: 'Submit',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UploadResumeView(),
                      ),
                    );
                  },
                  icon: Icons.upload_file,
                ),
                AppButton(
                  width: 160,
                  text: 'Submit',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ResumesListView(),
                      ),
                    );
                  },
                  icon: Icons.list,
                ),

                // ElevatedButton.icon(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (_) => const UploadResumeView()),
                //     );
                //   },
                //   icon: const Icon(Icons.upload_file),
                //   label: const Text("Upload Resume"),
                // ),
                // ElevatedButton.icon(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (_) => const ResumesListView()),
                //     );
                //   },
                //   icon: const Icon(Icons.list),
                //   label: const Text("My Resumes"),
                // ),
              ],
            ),
          ),

          // Employment list
          Expanded(
            child: employmentAsync.when(
              data: (jobs) {
                if (jobs.isEmpty) {
                  return const Center(child: Text("No Employment Added"));
                }

                return ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];

                    return Dismissible(
                      key: Key(job.id),
                      background: Container(color: Colors.red),
                      onDismissed: (_) {
                        ref
                            .read(employmentViewModelProvider.notifier)
                            .deleteEmployment(job.id);
                      },
                      child: ListTile(
                        title: Text(job.companyName),
                        subtitle: Text(
                          "${job.startDate.toLocal().toString().split(" ")[0]} - "
                          "${job.endDate != null ? job.endDate!.toLocal().toString().split(" ")[0] : "Present"}",
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EmploymentFormView(employment: job),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: AppLoader()),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
