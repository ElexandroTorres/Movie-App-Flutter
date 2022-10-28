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
  test('viewModel', () async {
    final client = MockClient();
    final List<String> results = [];
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

    loginViewModel.addListener(() {
      results.add(loginViewModel.loginStatus.toString());
    });

    loginViewModel.login('userName', 'password');

    expect(loginViewModel.loginStatus, LoginStatus.loading);
  });
}
