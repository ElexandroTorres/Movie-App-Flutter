import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_flutter/app/login/model/token_request.dart';
import 'package:movie_app_flutter/app/login/repository/login_repository.dart';
import 'package:movie_app_flutter/app/login/viewmodel/login_viewmodel.dart';
import 'package:movie_app_flutter/app/utils/constants.dart';

import 'package:movie_app_flutter/main.dart';
import 'package:http/http.dart' as http;

import 'login_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('TokenRequest', () {
    test('Returns a TokenRequest if the http call works correctly', () async {
      final client = MockClient();
      String url = '$baseUrl/authentication/token/new?api_key=$apiKey';

      when(
        client.get(Uri.parse(url)),
      ).thenAnswer(
        (_) async => http.Response(
            '{"success": true,"expires_at": "2022-10-20 19:50:10 UTC","request_token": "abcd"}',
            200),
      );

      final LoginRepository loginRepository = LoginRepository(client: client);

      expect(await loginRepository.getTokenRequest(), isA<TokenRequest>());
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();
      String url = '$baseUrl/authentication/token/new?api_key=$apiKey';

      when(
        client.get(Uri.parse(url)),
      ).thenAnswer(
        (_) async => http.Response('Nothing', 404),
      );

      final LoginRepository loginRepository = LoginRepository(client: client);

      //var token = await loginRepository.getTokenRequest();
      //var login = await loginRepository.login('elexandro.torres', 'corynthyans');

      expect(loginRepository.getTokenRequest(), throwsException);
    });
  });

  /*
  test('Testando o viewmodel', () async {
    final LoginViewModel loginViewModel = LoginViewModel();
    print('requerimento do toke: ${loginViewModel.loginStatus.toString()}');
    await loginViewModel.login('elexandro.torres', 'corynthyans');
    print('requerimento do toke: ${loginViewModel.loginStatus.toString()}');
    expect(1, 1);
  });
  */
}
