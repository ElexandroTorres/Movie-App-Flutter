import 'package:flutter/material.dart';
import 'package:movie_app_flutter/app/login/repository/login_repository.dart';
import 'package:movie_app_flutter/app/login/ui/login_page.dart';
import 'package:movie_app_flutter/app/login/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
          create: (_) => LoginViewModel(LoginRepository(client: http.Client())),
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
