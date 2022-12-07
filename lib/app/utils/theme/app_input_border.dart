import 'package:flutter/material.dart';
import 'package:movie_app_flutter/app/utils/theme/app_theme.dart';

abstract class AppInputBorder {
  InputBorder get loginBorder;
  InputBorder get loginFocusedBorder;
}

class AppInputBorderImpl implements AppInputBorder {
  @override
  InputBorder get loginBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppTheme.colors.inputBorder,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      );

  @override
  InputBorder get loginFocusedBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppTheme.colors.inputBorder,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      );
}
