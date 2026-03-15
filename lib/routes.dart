
import 'package:flutter/material.dart';
import 'package:job_tracker/features/auth/view/auth_gate.dart';
import 'package:job_tracker/features/auth/view/login.dart';
import 'package:job_tracker/features/jobs/views/add_job.dart';
import 'package:job_tracker/features/jobs/views/job_list_screen.dart';

import 'features/ai_tools/view/ai_tools_view.dart';
import 'features/ai_tools/view/cover_letter_view.dart';
import 'features/ai_tools/view/interview_questions_view.dart';
import 'features/ai_tools/view/job_description_analyzer_view.dart';
import 'features/ai_tools/view/resume_analyzer_view.dart';
import 'features/ai_tools/view/resume_button.dart';
import 'features/dashboard/view/dashbord.dart';
import 'features/employment/view/employment_list_view.dart';
import 'features/employment/view/resumes_list_view.dart';
import 'features/opt/view/opt_setup_view.dart';
import 'features/settings/views/settings_view.dart';
import 'features/splash/view/splash_screen.dart';

class AppRoutes{

   static final routes = {
     "/": (context) => const SplashScreen(),
     "/auth": (context) => const AuthGate(),
     "login": (context) => LoginScreen(),
     "dashboard": (context) => Dashboard(),
     "/jobs": (context) => JobListView(),
     "/settings":(context)=>SettingsView(),
     // "jobDetail": (context) => JobDetailScreen(),
     "/addJob": (context) => AddJobView(),
     "/optedit": (context) => OptSetupView(),
     "/employement":(context) => EmploymentListView(),
     "/resumes":(context) => ResumesListView(),
     '/ai-tools': (context) => const AIToolsView(),
     '/resume-analyzer': (context) => const ResumeAnalyzerView(),
     '/job-analyzer': (context) => const JobDescriptionAnalyzerView(),
     '/cover-letter': (context) => const CoverLetterView(),
     '/interview-questions': (context) => const InterviewQuestionsView(),
     '/resume-button': (context) => const ResumeButton(),
   };

}
