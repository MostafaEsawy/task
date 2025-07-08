

import 'package:flutter/material.dart';

class Responsive {
  final double screenWidth;
  final double screenHeight;

  Responsive({
    required this.screenWidth,
    required this.screenHeight,
  });

  factory Responsive.of(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Responsive(screenWidth: size.width, screenHeight: size.height);
  }

  double widthPercent(double percent) {
    return screenWidth * (percent / 100);
  }

  double heightPercent(double percent) {
    return screenHeight * (percent / 100);
  }
}