import 'package:flutter/material.dart';
import 'package:movie_app/app/utils/theme/app_theme.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({
    Key? key,
    this.isObscure = false,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.onSaved,
    required this.prefixIcon,
  }) : super(key: key);

  final bool isObscure;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: AppTheme.colors.primary,
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppTheme.colors.primary,
        ),
        border: AppTheme.inputBorder.loginBorder,
        focusedBorder: AppTheme.inputBorder.loginFocusedBorder,
      ),
      keyboardType: TextInputType.text,
      obscureText: isObscure,
    );
  }
}
