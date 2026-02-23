import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset("assets/download.png", fit: BoxFit.cover),
        ),
        Container(color: Colors.black.withOpacity(0.6)),
        Positioned(top: -80, left: -80, child: _neonCircle(200)),
        Positioned(bottom: -80, right: -80, child: _neonCircle(220)),
      ],
    );
  }

  Widget _neonCircle(double size) {
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