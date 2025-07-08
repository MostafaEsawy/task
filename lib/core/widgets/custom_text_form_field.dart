

import 'package:flutter/material.dart';
import 'package:task/core/utils/responsive.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.textInputType,
    this.suffixIcon,
    this.controller,
    this.isObscure,
    this.prefixIcon,
    this.onChanged,
    this.minLines,
    this.onTap,
  });

  final String hint;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool? isObscure;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final int? minLines;
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return SizedBox(
      width: double.infinity,
      height: responsive.screenHeight * 0.06,
      child: TextFormField(
        obscureText: isObscure ?? false,
        validator: (value) {
          if (controller!.text.isEmpty) {
            return "This Field is required";
          } else {
            return null;
          }
        },
        // minLines: minLines??1,
        maxLines: minLines ?? 1,
        onChanged: onChanged,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        onTap: onTap,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hint,
          // hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}
