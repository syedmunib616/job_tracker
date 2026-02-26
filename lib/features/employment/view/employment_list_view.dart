import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/drawer.dart';
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
            MaterialPageRoute(
                builder: (_) => const EmploymentFormView()),
          );
        },
        child: const Icon(Icons.add),
      ),
      drawer: AppDrawer(),
      body: employmentAsync.when(
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
                          "${job.endDate != null ? job.endDate!.toLocal().toString().split(" ")[0] : "Present"}"),
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
        loading: () =>
        const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}