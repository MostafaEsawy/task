
import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final bool isEnabled;

  const CustomButon({
    super.key,
    this.onTap,
    required this.text,
    this.color,
    this.textColor,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onTap == null;

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: color ,
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        height: 54,
        child: Center(
          child: Text(
            text,
           style: TextStyle(
            fontSize: 16,
             fontFamily: 'Anek Devanagari',
             color: Colors.white,
             fontWeight: FontWeight.w500
           ),
          ),
        ),
      ),
    );
  }
}