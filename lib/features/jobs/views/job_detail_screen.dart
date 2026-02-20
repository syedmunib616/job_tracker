import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/job.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  Color getStatusColor(String status){
    switch(status){
      case "Applied":
        return Colors.blue;
      case "Interview":
        return Colors.orangeAccent;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Job job= ModalRoute.of(context)!.settings.arguments as Job;
    return Scaffold(
      appBar: AppBar(title: Text(job.title),),
      body: Padding(padding: const EdgeInsets.all(16),
      child: Card(
        child:SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.title, style: GoogleFonts.lexend(
                      textStyle:  TextStyle(
                       fontSize: 16,
                      fontWeight: FontWeight.bold,
                        color: Colors.black,
                        // letterSpacing: 2,
                      ),
                    )),
                    Text(job.company, style: GoogleFonts.lexend(
                      textStyle:  TextStyle(
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                        // letterSpacing: 2,
                      ),
                    ),

                    )
                  ],
                ),
                Text(job.status, style: GoogleFonts.lexend(
                  textStyle:  TextStyle(
                    fontSize: 14,
                    color: getStatusColor(job.status)
                    // fontWeight: FontWeight.bold,
                    // color:job.status=="Applied"
                    //     ? Colors.black
                    //     : job.status=="Interview"
                    //     :Colors.blue
                    //     :Colors.black,
                    // job.status == "Applied"
                    //     ? Colors.black
                    //     : job.status == "Interview"
                    //     ? Colors.blue
                    //     : Colors.black,
                    // letterSpacing: 2,
                  ),
                ),)
              ],
            ),
          ),
        ),
      ),

      // child: Column(
      //     children: [
      //       Text("Company: ${job.company}", style: TextStyle(fontSize: 18),),
      //       SizedBox(height: 10,),
      //       Text("Status: ${job.status}", style: TextStyle(fontSize: 18),)
      //   ],
      // ),

      ),

    );
  }
}
