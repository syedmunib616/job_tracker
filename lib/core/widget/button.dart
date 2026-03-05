import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final bool isLoading;
  final IconData? icon;
  final bool isOutlined;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.isLoading = false,
    this.icon,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor =
    isOutlined ? Colors.transparent : AppColors.textSecondary;

    final foregroundColor =
    isOutlined ? AppColors.textSecondary : AppColors.onPrimary;

    final borderSide = isOutlined
        ? BorderSide(color: AppColors.textSecondary, width: 1.5)
        : BorderSide.none;

    return SizedBox(
      width: width ?? double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: isOutlined ? 0 : (isDark ? 0 : 2),
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation(
              isOutlined
                  ? AppColors.textSecondary
                  : AppColors.onPrimary,
            ),
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class AppButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final double? width;
//   final bool isLoading;
//
//   const AppButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.width,
//     this.isLoading = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return SizedBox(
//       width: width ?? double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.textSecondary,
//           foregroundColor: AppColors.onPrimary,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14),
//           ),
//         ),
//         child: isLoading
//             ? const SizedBox(
//           height: 22,
//           width: 22,
//           child: CircularProgressIndicator(
//             strokeWidth: 2.5,
//             valueColor:
//             AlwaysStoppedAnimation<Color>(Colors.white),
//           ),
//         )
//             : Text(
//           text,
//           style: theme.textTheme.bodyLarge?.copyWith(
//             fontWeight: FontWeight.w600,
//             letterSpacing: 0.5,
//           ),
//         ),
//       ),
//     );
//   }
// }