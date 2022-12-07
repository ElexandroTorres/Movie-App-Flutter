import 'package:movie_app_flutter/app/utils/theme/app_colors.dart';
import 'package:movie_app_flutter/app/utils/theme/app_input_border.dart';
import 'package:movie_app_flutter/app/utils/theme/app_text_styles.dart';

class AppTheme {
  static final instance = AppTheme();

  final _colors = AppColorsImpl();
  static AppColors get colors => instance._colors;

  final _textStyles = AppTextStylesImpl();
  static AppTextStyles get textStyles => instance._textStyles;

  final _inputBorders = AppInputBorderImpl();
  static AppInputBorder get inputBorder => instance._inputBorders;
}
