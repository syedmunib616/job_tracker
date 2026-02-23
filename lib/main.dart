import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_tracker/features/jobs/views/add_job.dart';
import 'package:job_tracker/routes.dart';
import 'core/providers/theme_provider.dart';
import 'features/auth/view/login.dart';
import 'features/dashboard/view/dashbord.dart';
import 'features/jobs/views/job_detail_screen.dart';
import 'features/jobs/views/job_list_screen.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/theme/app_theme.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(const MyApp());
  runApp(const ProviderScope(child: MyApp()));
}



class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: "Student Job Tracker",
    //   initialRoute: "/",
    //   routes: AppRoutes.routes,
    // );
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student Job Tracker",
      initialRoute: "/",
      routes: AppRoutes.routes,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
    );
      // return MaterialApp(
      // routes: {
      //   "/":(context)=>Dashbord(),
      //   "/job":(context)=>JobListScreen(),
      //   "/detail":(context)=>JobDetailScreen(),
      //   "/addjob": (context)=> AddJob()
      // },
      // title: 'Job Tracker',
      // debugShowCheckedModeBanner: false,
      //
      // theme: darkTheme,
      // darkTheme: darkTheme,
      // themeMode: themeMode,
      //  home: Dashbord(),
      // home: JobListScreen(),
      //home: LoginScreen(),
      //);
  }

}


