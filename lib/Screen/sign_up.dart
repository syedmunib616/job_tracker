import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool showPass = false;
  bool showConfirmPass = false;

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
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: 380,
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
                          "Create Account",
                          style: GoogleFonts.lato(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 20),

                        futuristicField(
                          controller: nameController,
                          hint: "Full Name",
                          icon: Icons.person,
                        ),

                        const SizedBox(height: 15),

                        futuristicField(
                          controller: emailController,
                          hint: "Email",
                          icon: Icons.email,
                        ),

                        const SizedBox(height: 15),

                        futuristicField(
                          controller: passController,
                          hint: "Password",
                          icon: Icons.lock,
                          isPassword: true,
                        ),

                        const SizedBox(height: 15),

                        futuristicField(
                          controller: confirmPassController,
                          hint: "Confirm Password",
                          icon: Icons.lock_outline,
                          isConfirm: true,
                        ),

                        const SizedBox(height: 30),

                        // SIGN UP BUTTON
                        GestureDetector(
                          onTap: () {
                            signUpUser();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: Colors.white.withOpacity(0.2)),
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
                              "SIGN UP",
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have account? ",
                                style: TextStyle(color: Colors.white70)),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            socialButton(FontAwesomeIcons.google, Colors.white),
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

  // Firebase Sign Up Function (Add Firebase Auth Later)
  void signUpUser() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String pass = passController.text.trim();
    String confirmPass = confirmPassController.text.trim();

    if (pass != confirmPass) {
      print("Passwords do not match");
      return;
    }

    print("Firebase Sign Up Ready: $email");
    // TODO: FirebaseAuth.instance.createUserWithEmailAndPassword(...)
  }

  // Futuristic Field
  Widget futuristicField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isConfirm = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: (isPassword && !showPass) || (isConfirm && !showConfirmPass),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: (isPassword || isConfirm)
            ? IconButton(
          icon: Icon(
            (isConfirm ? showConfirmPass : showPass)
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.white70,
          ),
          onPressed: () {
            setState(() {
              if (isConfirm) {
                showConfirmPass = !showConfirmPass;
              } else {
                showPass = !showPass;
              }
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

  // Neon Circle
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

  // Social Button
  Widget socialButton(IconData icon, Color color) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.black.withOpacity(0.4),
      child: Icon(icon, color: color),
    );
  }
}
