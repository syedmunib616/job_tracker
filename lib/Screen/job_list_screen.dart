import 'package:flutter/material.dart';

import '../data/dummy.dart';

// import '../data/dummy.dart' show jobs;



class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Application"),),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index){
          final job = jobs[index];
          return ListTile(

            title: Text(job.title),
            subtitle: Text(job.company),
            trailing: Text(job.status),
            onTap: (){
              Navigator.pushNamed(context, "/detail",arguments: job);
            },

          );
        },

      ),
    );
  }
}
