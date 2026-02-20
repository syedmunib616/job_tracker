
import 'package:flutter/material.dart';
import 'package:job_tracker/features/auth/view/Login.dart' ;
import 'package:job_tracker/features/jobs/views/job_list_screen.dart';

import 'features/settings/views/settings_view.dart';

class AppRoutes{
   static final routes={
     "/":(context)=>LoginScreen(),
     "/jobs":(context)=>JobListScreen(),
     "/settings":(context)=>SettingsView(),
   };
}