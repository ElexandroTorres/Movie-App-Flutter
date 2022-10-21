import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_flutter/app/login/repository/login_repository.dart';

import 'package:movie_app_flutter/main.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Testando o repository', () async {
    final LoginRepository loginRepository = LoginRepository();

    var token = await loginRepository.getTokenRquest();
    var login = await loginRepository.login('elexandro.torres', 'corynthyans');
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    print('requerimento do toke: ${token.toString()}');
    print('requerimento do login: ${login.toString()}');
    expect(1, 1);
  });
}
