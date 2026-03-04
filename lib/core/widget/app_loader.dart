import 'package:flutter/material.dart';
//
// class AppLoader extends StatelessWidget {
//   final String? message;
//   final bool fullScreen;
//
//   const AppLoader({
//     super.key,
//     this.message,
//     this.fullScreen = false,
//   });
//
//   static const Color primaryBrandColor = Color(0xFF80796B);
//
//   @override
//   Widget build(BuildContext context) {
//     final loader = Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const SizedBox(
//           height: 40,
//           width: 40,
//           child: CircularProgressIndicator(
//             strokeWidth: 3,
//             valueColor:
//             AlwaysStoppedAnimation<Color>(primaryBrandColor),
//           ),
//         ),
//         if (message != null) ...[
//           const SizedBox(height: 16),
//           Text(
//             message!,
//             style: const TextStyle(
//               color: primaryBrandColor,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.5,
//             ),
//           ),
//         ],
//       ],
//     );
//
//     if (fullScreen) {
//       return Container(
//         color: Colors.white,
//         child: Center(child: loader),
//       );
//     }
//
//     return Center(child: loader);
//   }
// }
//
// import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final bool fullScreen;

  const AppLoader({
    super.key,
    this.fullScreen = false,
  });

  static const _brandColor = Color(0xFF80796B);

  @override
  Widget build(BuildContext context) {
    final loader = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _brandColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const SizedBox(
        height: 36,
        width: 36,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation(_brandColor),
        ),
      ),
    );

    if (fullScreen) {
      return Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: loader,
      );
    }

    return Center(child: loader);
  }
}