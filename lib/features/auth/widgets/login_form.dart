import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_tracker/features/auth/view/forget.dart';
import 'package:job_tracker/features/auth/view/sign_up.dart';
import 'package:job_tracker/features/auth/view_models/auth_state.dart';
import 'package:job_tracker/features/auth/view_models/auth_view_model.dart';
import '../../../../core/widget/app_text_field.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  late final ProviderSubscription<AuthState> _authListener;

  @override
  void initState() {
    super.initState();

    _authListener = ref.listenManual<AuthState>(
      authViewModelProvider,
          (prev, next) {
        if (next.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.error!)),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _authListener.close();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    ref.listen<AuthState>(authViewModelProvider, (prev, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });
    return // MAIN LOGIN UI
      Center(
        child: SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: 360,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    const SizedBox(height: 5),

                    Text(
                      "Welcome",
                      style: GoogleFonts.lato(
                        textStyle:  TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                    ),

                    const SizedBox(height: 15),

                    AppTextField(
                      controller: emailController,
                      hint: "Email",
                      iconData: Icons.email,),

                    const SizedBox(height: 18),
                    // Password
                    AppTextField(
                      controller: passController,
                      hint: "Password",
                      iconData: Icons.lock,
                      isPassword: true,
                    ),

                    const SizedBox(height: 30),

                    if (authState.error != null)
                      Text(
                        authState.error!,
                        style: TextStyle(color: Colors.red),
                      ),

                    GestureDetector(
                      onTap:()async{
                        // await ref.read(authViewModelProvider).login(emailController.text, passController.text);
                        if( emailController.text.isNotEmpty && passController.text.isNotEmpty){
                        try{
                          await ref.read(authViewModelProvider.notifier).login(
                            emailController.text,
                            passController.text,
                          );}catch(e){
                             print(e);
                          }
                        }else if(emailController.text.isEmpty && passController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Fill Email and Password")),
                          );
                        }else if(emailController.text.isEmpty || passController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Email or Password field is empty")),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              offset: Offset(0, 10),
                              blurRadius: 20,
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              offset: Offset(0, -2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child:  Text(
                          "LOGIN",
                          style: GoogleFonts.lato(
                            textStyle:  TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                          // style: TextStyle(
                          //   fontSize: 20,
                          //   fontWeight: FontWeight.bold,
                          //   color: Colors.white,
                          //   letterSpacing: 2,
                          // ),
                        ),
                      ),
                    ),


                    const SizedBox(height: 20),



                    const SizedBox(height: 10),

                    // Social Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));

                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        socialButton(FontAwesomeIcons.google, Colors.white),
                        // const SizedBox(width: 15),
                        // socialButton(FontAwesomeIcons.apple, Colors.white),
                        // const SizedBox(width: 15),
                        // socialButton(
                        //   FontAwesomeIcons.facebook,
                        //   Colors.blue,
                        // ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No account? ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));

                          },
                          child:  Text(
                            "Sign Up",
                            style: GoogleFonts.lato(
                              textStyle:  TextStyle(
                                // fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }

  // Social Login Buttons
  Widget socialButton(IconData icon, Color color) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.black.withOpacity(0.4),
      child: Icon(icon, color: color),
    );
  }
}


