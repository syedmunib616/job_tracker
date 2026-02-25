import 'package:flutter/material.dart';
import 'package:job_tracker/core/constants/app_colors.dart';


class JobTextField extends StatelessWidget {
  final TextEditingController c;
  final String label;
  final IconData icon;
  bool number=false;

  JobTextField({
    super.key, required this.c, required this.label, required this.icon,required this.number
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: c,
          keyboardType: number ? TextInputType.number : TextInputType.text,
          cursorColor: AppColors.textSecondary,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: AppColors.textSecondary),
            labelText: label,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.textSecondary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        )
    );
  }
}
