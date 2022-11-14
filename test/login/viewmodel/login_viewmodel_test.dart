import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_app_flutter/app/login/repository/login_repository.dart';
import 'package:movie_app_flutter/app/login/viewmodel/login_viewmodel.dart';
import 'package:movie_app_flutter/app/utils/constants.dart';

import '../repository/login_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('Test Stats of Login when the login is sucessful', () async {
    final client = MockClient();
    LoginRepository loginRepository = LoginRepository(client: client);
    LoginViewModel loginViewModel = LoginViewModel(loginRepository);
    String urlToken = '$baseUrl/authentication/token/new?api_key=$apiKey';
    String urlLogin =
        '$baseUrl/authentication/token/validate_with_login?api_key=$apiKey';

    when(
      client.get(Uri.parse(urlToken)),
    ).thenAnswer(
      (_) async => http.Response(
          '{"success": true,"expires_at": "2022-10-20 19:50:10 UTC","request_token": "abcd"}',
          200),
    );

    when(client.post(
      Uri.parse(urlLogin),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response(
        '{"success": true,"expires_at": "2022-10-20 19:50:10 UTC","request_token": "abcd"}',
        200));

    int a = 1;
    loginViewModel.addListener(() {
      if (a == 1) {
        expect(loginViewModel.loginStatus, LoginStatus.loading);
        a++;
      } else if (a == 2) {
        expect(loginViewModel.loginStatus, LoginStatus.success);
      }
    });
  });
}
