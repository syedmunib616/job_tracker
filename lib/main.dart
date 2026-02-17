import 'package:flutter/material.dart';

import 'Screen/dashbord.dart';
import 'Screen/job_detail_screen.dart';
import 'Screen/job_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/":(context)=>Dashbord(),
        "/job":(context)=>JobListScreen(),
        "/detail":(context)=>JobDetailScreen()
      },
      // home: Dashbord(),
      //home: JobListScreen(),

    );
  }
}

