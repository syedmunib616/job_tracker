import 'package:flutter/material.dart';

import '../data/dummy.dart';
import '../widget/job_card.dart';
import 'add_job.dart';

// import '../data/dummy.dart' show jobs;



class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job List"),
        leading: IconButton(onPressed: (){Navigator.pushNamed(context, "/");}, icon: Icon(Icons.arrow_back)),
      ),

      body: ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (context,index){
            return JobCard( job: jobs[index], onTap: () {    Navigator.pushNamed(context, "/detail", arguments: jobs[index]);
            },);

            // return JobCard(jobs[index].title, jobs[index].company, jobs[index].status);
          }
      ),
      // body: ListView.builder(
      //   itemCount: jobs.length,
      //   itemBuilder: (context, index){
      //     final job = jobs[index];
      //     return ListTile(
      //
      //       title: Text(job.title),
      //       subtitle: Text(job.company),
      //       trailing: Text(job.status),
      //       onTap: (){
      //         Navigator.pushNamed(context, "/detail",arguments: job);
      //       },
      //
      //     );
      //   },
      //
      // ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddJob()));
          }
      ),
    );
  }
}
