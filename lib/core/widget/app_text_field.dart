import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {

  final String hint;
  final TextEditingController controller;
  final IconData iconData;
  final bool isPassword ;
  AppTextField({super.key, required this.hint, required this.controller,required this.iconData ,this.isPassword=false});


  // ValueNotifier handles the toggle state without a full StatefulWidget
  final ValueNotifier<bool> _obscureNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _obscureNotifier,
        builder: (context, bool isObscured, child){
          return TextFormField(
            controller: controller,
            // Only obscure if it IS a password field AND notifier says so
            obscureText: isPassword ? isObscured : false,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: Icon(iconData, color: Colors.white),
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: () => _obscureNotifier.value = !_obscureNotifier.value,
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

    });
  }
}
