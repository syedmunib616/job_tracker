import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset("assets/download.png", fit: BoxFit.cover),
          ),

          // Dark overlay
          Container(color: Colors.black.withOpacity(0.6)),

          // Neon circles
          Positioned(top: -80, left: -80, child: neonCircle(200)),
          Positioned(bottom: -80, right: -80, child: neonCircle(220)),

          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Forgot Password",
                        style: GoogleFonts.lato(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Enter your email to reset password",
                        style: TextStyle(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      futuristicField(
                        controller: emailController,
                        hint: "Email Address",
                        icon: Icons.email,
                      ),

                      const SizedBox(height: 30),

                      // RESET BUTTON
                      GestureDetector(
                        onTap: resetPassword,
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
                                offset: const Offset(0, 10),
                                blurRadius: 20,
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                offset: const Offset(0, -2),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Text(
                            "RESET PASSWORD",
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Back to Login",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Firebase Reset Password Logic
  void resetPassword() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      print("Email required");
      return;
    }

    print("Send reset email to: $email");


  }

  // Text Field
  Widget futuristicField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white),
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
}
