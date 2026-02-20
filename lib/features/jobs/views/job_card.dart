
import 'package:flutter/material.dart';
import 'package:job_tracker/features/jobs/models/job.dart' show Job;

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  JobCard({required this.job, required this.onTap});

  Color getStatusColor(String status) {
    switch (status) {
      case "Applied": return Colors.blue;
      case "Interview": return Colors.orange;
      case "Offer": return Colors.green;
      case "Rejected": return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(job.title, ),
        subtitle: Text(job.company),
        trailing: Text(
          job.status,
          style: TextStyle(color: getStatusColor(job.status)),
        ),
        onTap:onTap ,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
//
// class JobCard extends StatelessWidget {
//   const JobCard(this.jobname, this.Company, this.status, {super.key});
//
//   final String jobname;
//   final String Company;
//   final String status;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//        Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Card(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               children: [
//                 Text("${jobname}"),
//                 Text("${Company}"),
//                 Text("${status}")
//
//               ],
//             ),
//           ),
//                ),
//        );
//
//   }
// }
