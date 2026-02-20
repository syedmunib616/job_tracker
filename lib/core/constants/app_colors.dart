import 'package:flutter/material.dart';
class AppColors {
  static const primary=Colors.blue;
  static const background = Color(0xFFF5F5F5);
  static const text = Colors.black;
  static const onPrimary = Colors.white;
  static const primaryContainer = Color(0xFFD1E0FF);
  static const surface = Colors.white;
  static const surfaceVariant = Color(0xFFE8ECF5);

  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B7280);

  // Job status colors (same for both modes – or override in dark if needed)
  static const statusApplied = Color(0xFF10B981);   // green
  static const statusInterview = Color(0xFF3B82F6); // blue
  static const statusOffer = Color(0xFF059669);
  static const statusRejected = Color(0xFFEF4444);  // red

  // Dark mode variants (you can define them here too)
  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkSurfaceVariant = Color(0xFF2D3748);
  static const darkTextPrimary = Color(0xFFE0E0E0);
  static const darkTextSecondary = Color(0xFF9CA3AF);
}