import 'package:flutter/material.dart';
import 'package:movie_app_flutter/app/utils/theme/app_theme.dart';

class VoteCircle extends StatelessWidget {
  const VoteCircle({Key? key, required this.voteAvarage, this.small = true})
      : super(key: key);

  final String voteAvarage;
  final bool small;

  @override
  Widget build(BuildContext context) {
    double size = small ? 8.0 : 12;
    return Container(
      padding: EdgeInsets.all(size),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.colors.primary,
        border: Border.all(
          color: AppTheme.colors.circleBorder,
          width: 2,
        ),
      ),
      child: Text(
        voteAvarage,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: size * 2,
        ),
      ),
    );
  }
}
