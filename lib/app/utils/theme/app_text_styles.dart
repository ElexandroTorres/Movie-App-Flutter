import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_flutter/app/utils/theme/app_theme.dart';

abstract class AppTextStyles {
  TextStyle get detailsTitle;
  TextStyle get loginButtonText;
  TextStyle get signupLink;
  TextStyle get signupText;
  TextStyle get appNameTitle;
  TextStyle get listMovieError;
  TextStyle get movieVoteCount;
}

class AppTextStylesImpl implements AppTextStyles {
  @override
  TextStyle get detailsTitle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get loginButtonText => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get signupLink => const TextStyle(
        color: Colors.blue,
        fontSize: 18,
        decoration: TextDecoration.underline,
      );

  @override
  TextStyle get appNameTitle => GoogleFonts.getFont(
        'Aclonica',
        fontSize: 60,
        color: AppTheme.colors.primary,
      );

  @override
  TextStyle get signupText => const TextStyle(
        color: Colors.black,
        fontSize: 18,
      );

  @override
  TextStyle get listMovieError => const TextStyle(
        color: Colors.black,
        fontSize: 16,
      );

  @override
  TextStyle get movieVoteCount => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
}
