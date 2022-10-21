import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_flutter/app/login/repository/login_repository.dart';

import 'package:movie_app_flutter/main.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Testando o repository', () async {
    final LoginRepository loginRepository = LoginRepository();

    var response = await loginRepository.getTokenRquest();
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    expect(1, 1);
  });
}
