
import 'package:flutter/material.dart';
class JobStageCard extends StatelessWidget {
  final String title;
  final String assetPath;
  final Color colorOverlay;
  final IconData icon;
  final String description;

  const JobStageCard({
    super.key,
    required this.title,
    required this.assetPath,
    required this.colorOverlay,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,                           // ← shadow strength
      shadowColor: Colors.black.withOpacity(0.35),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background from assets
          Image.asset(
            assetPath,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.45),
            colorBlendMode: BlendMode.darken,
          ),

          // Gradient overlay + content
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  colorOverlay.withOpacity(0.65),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: colorOverlay.withOpacity(0.9),
                  radius: 28,
                  child: Icon(icon, color: Colors.white, size: 32),
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}