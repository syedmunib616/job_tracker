import 'package:flutter/material.dart';

import '../models/job.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Job job= ModalRoute.of(context)!.settings.arguments as Job;
    return Scaffold(
      appBar: AppBar(title: Text(job.title),),
      body: Padding(padding: const EdgeInsets.all(16),
      child: Column(
          children: [
            Text("Company: ${job.company}", style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text("Status: ${job.status}", style: TextStyle(fontSize: 18),)
        ],
      ),
      ),

    );
  }
}
