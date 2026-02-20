import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_tracker/features/auth/view/forget.dart';
import 'package:job_tracker/features/auth/view/sign_up.dart';
import 'package:job_tracker/features/dashboard/view/dashbord.dart';

import '../../../core/widget/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset("assets/download.png", fit: BoxFit.cover),
          ),

          // ✅ DARK OVERLAY FOR READABILITY
          Container(color: Colors.black.withOpacity(0.6)),

          // Neon circles
          Positioned(top: -80, left: -80, child: neonCircle(200)),
          Positioned(bottom: -80, right: -80, child: neonCircle(220)),

          // MAIN LOGIN UI
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

                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard()));
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
          ),
        ],
      ),
    );
  }

  // Futuristic TextField
  Widget futuristicField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !showPass,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white54),
        // prefixIcon: Icon(icon, color: Colors.cyanAccent),
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  showPass ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    showPass = !showPass;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Neon Circle Effect
  Widget neonCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.25),
        boxShadow: [
          BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 80),
        ],
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
