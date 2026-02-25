import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/drawer.dart';
import 'package:job_tracker/features/jobs/views/edit_job_view.dart';
import '../view_models/job_view_model.dart';
import 'package:job_tracker/core/constants/app_colors.dart';
class JobListView extends ConsumerWidget {
  const JobListView({super.key});

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "applied":
        return Colors.blue;
      case "interview":
        return Colors.orange;
      case "offer":
        return Colors.green;
      case "rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(jobsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Jobs")),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,color: AppColors.text,),
        onPressed: () => Navigator.pushNamed(context, "/addJob"),
      ),
      body: jobs.when(
        // data: (list) => ListView.builder(
        //   itemCount: list.length,
        //   itemBuilder: (_, i) {
        //     final job = list[i];
        //     return Card(
        //       child: ListTile(
        //         title: Text(job.company),
        //         subtitle: Text("${job.role} • ${job.status}"),
        //         trailing: Text("\$${job.salary}"),
        //       ),
        //     );
        //   },
        // ),
          data: (list) => ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final job = list[i];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                 child:  Dismissible(
                    key: Key(job.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                   onDismissed:  (_) {
                         ref.read(jobViewModelProvider.notifier).deleteJob(job.id);
                       },
                    child: GestureDetector(
                      onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => EditJobView(job: job)),
                                );
                      },
                      child: Card(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                        
                              /// 🔹 Company Name
                              Text(
                                job.company,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                        
                              const SizedBox(height: 6),
                        
                              /// 🔹 Role
                              Text(
                                job.role,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                        
                              const SizedBox(height: 12),
                        
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                        
                                  /// Status Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: getStatusColor(job.status).withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      job.status,
                                      style: TextStyle(
                                        color: getStatusColor(job.status),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                        
                                  /// Salary Chip
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "\$${job.salary}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )

                // child: Dismissible(
                //   key: Key(job.id),
                //   direction: DismissDirection.endToStart,
                //   background: Container(
                //     color: Color(0xffc20000),
                //     alignment: Alignment.centerRight,
                //     padding: const EdgeInsets.only(right: 20),
                //     child: const Icon(Icons.delete, color: Colors.white),
                //   ),
                //   onDismissed: (_) {
                //     ref.read(jobViewModelProvider.notifier).deleteJob(job.id);
                //   },
                //   child: Card(
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                //     child: ListTile(
                //       title: Text(job.company, style: TextStyle(fontWeight: FontWeight.bold)),
                //       subtitle: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(job.role),
                //           const SizedBox(height: 4),
                //           Container(
                //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                //             decoration: BoxDecoration(
                //               color: getStatusColor(job.status).withOpacity(0.15),
                //               borderRadius: BorderRadius.circular(6),
                //             ),
                //             child: Text(
                //               job.status,
                //               style: TextStyle(
                //                 color: getStatusColor(job.status),
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       trailing: Text(
                //         "\$${job.salary}",
                //         style: const TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (_) => EditJobView(job: job)),
                //         );
                //       },
                //     ),
                //   ),
                //   // child: Card(
                //   //   child: ListTile(
                //   //     title: Text(job.company),
                //   //     subtitle: Text("${job.role} • ${job.status}"),
                //   //     trailing: Text("\$${job.salary}"),
                //   //     onTap: () {
                //   //       Navigator.push(
                //   //         context,
                //   //         MaterialPageRoute(
                //   //           builder: (_) => EditJobView(job: job),
                //   //         ),
                //   //       );
                //   //       // Navigator.push(
                //   //       //   context,
                //   //       //   MaterialPageRoute(
                //   //       //     builder: (_) => EditJobView(job: job),
                //   //       //   ),
                //   //       // );
                //   //     },
                //   //   ),
                //   // ),
                // ),
              );
            },
          ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}

// floatingActionButton: FloatingActionButton(
// child: Icon(Icons.add),
// onPressed: (){
// Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddJob()));
// }
// ),