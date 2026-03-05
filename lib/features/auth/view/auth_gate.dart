import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/app_loader.dart';
import '../view_models/auth_view_model.dart';
import 'login.dart';
import '../../dashboard/view/dashbord.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return LoginScreen(); // your login screen
        }
        return Dashboard(); // your dashboard screen
      },
      loading: () => const Scaffold(
        body: Center(child: Center(child: AppLoader())),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text("Error: $e")),
      ),
    );
  }
}