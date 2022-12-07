import 'package:flutter/material.dart';

abstract class AppColors {
  Color get background;
  Color get textColor;
  Color get backButton;
  Color get inputBorder;
  Color get primary;
  Color get circleBorder;
}

class AppColorsImpl implements AppColors {
  @override
  Color get backButton => const Color(0xFF032541);

  @override
  Color get background => Colors.white;

  @override
  Color get textColor => Colors.black;

  @override
  Color get inputBorder => const Color(0xFF032541);

  @override
  Color get primary => const Color(0xFF032541);

  @override
  Color get circleBorder => const Color.fromARGB(255, 97, 97, 42);
}
