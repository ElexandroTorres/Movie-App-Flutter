import 'package:flutter/material.dart';
import 'package:movie_app_flutter/app/login/ui/login_page.dart';

void main() {
  runApp(const MovieAppFlutter());
}

class MovieAppFlutter extends StatelessWidget {
  const MovieAppFlutter({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
