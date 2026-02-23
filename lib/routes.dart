
import 'package:flutter/material.dart';
import 'package:job_tracker/features/auth/view/auth_gate.dart';
import 'package:job_tracker/features/auth/view/login.dart';
import 'package:job_tracker/features/jobs/views/job_list_screen.dart';

import 'features/dashboard/view/dashbord.dart';
import 'features/settings/views/settings_view.dart';
import 'features/splash/view/splash_screen.dart';

class AppRoutes{


   static final routes = {
     "/": (context) => const SplashScreen(),
     "/auth": (context) => const AuthGate(),
     "login": (context) => LoginScreen(),
     "dashboard": (context) => Dashboard(),
     "/jobs": (context) => JobListScreen(),
     "/settings":(context)=>SettingsView(),
     // "jobDetail": (context) => JobDetailScreen(),
     // "addJob": (context) => AddJob(),
   };
}
