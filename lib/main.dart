import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker/features/jobs/views/add_job.dart';
import 'package:job_tracker/routes.dart';
import 'features/auth/view/Login.dart';
import 'features/dashboard/view/dashbord.dart';
import 'features/jobs/views/job_detail_screen.dart';
import 'features/jobs/views/job_list_screen.dart';
import 'package:collection/collection.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student Job Tracker",
      initialRoute: "/",
      routes: AppRoutes.routes,
    );


    return MaterialApp(
      // routes: {
      //   "/":(context)=>Dashbord(),
      //   "/job":(context)=>JobListScreen(),
      //   "/detail":(context)=>JobDetailScreen(),
      //   "/addjob": (context)=> AddJob()
      // },
      //  home: Dashbord(),
      // home: JobListScreen(),
       home: LoginScreen(),
    );
  }

}


