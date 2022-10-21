import 'package:flutter/material.dart';
import 'package:movie_app_flutter/app/login/ui/login_page.dart';
import 'package:movie_app_flutter/app/login/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MovieAppFlutter());
}

class MovieAppFlutter extends StatelessWidget {
  const MovieAppFlutter({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie App Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
