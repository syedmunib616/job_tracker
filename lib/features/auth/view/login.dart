import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_tracker/core/providers/auth_providers.dart';
import 'package:job_tracker/core/services/auth_service.dart';
import 'package:job_tracker/features/auth/view/forget.dart';
import 'package:job_tracker/features/auth/view/sign_up.dart';
import 'package:job_tracker/features/auth/view_models/auth_view_model.dart';
import 'package:job_tracker/features/auth/widgets/login_background.dart';
import 'package:job_tracker/features/auth/widgets/login_form.dart';
import 'package:job_tracker/features/dashboard/view/dashbord.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import '../../../core/widget/app_text_field.dart';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: const [
          LoginBackground(),
          Center(child: LoginForm()),
        ],
      ),
    );
  }
}

