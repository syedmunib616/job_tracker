import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker/Screen/add_job.dart';
import 'Screen/Login.dart';
import 'Screen/dashbord.dart';
import 'Screen/job_detail_screen.dart';
import 'Screen/job_list_screen.dart';

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
      routes: {
        "/":(context)=>Dashbord(),
        "/job":(context)=>JobListScreen(),
        "/detail":(context)=>JobDetailScreen(),
        "/addjob": (context)=> AddJob()
      },
      //  home: Dashbord(),
      //
      // home: LoginScreen(),
    );
  }

}


