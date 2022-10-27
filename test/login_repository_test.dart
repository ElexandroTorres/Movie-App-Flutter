import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_app_flutter/app/login/model/token_request.dart';
import 'package:movie_app_flutter/app/login/repository/login_repository.dart';
import 'package:movie_app_flutter/app/utils/constants.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Token Request | ', () {
    test('Returns a TokenRequest if the api call works correctly', () async {
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

    test('throws an exception if the api call throws an Exception', () async {
      final client = MockClient();
      String url = '$baseUrl/authentication/token/new?api_key=$apiKey';

      when(
        client.get(Uri.parse(url)),
      ).thenAnswer(
        (_) async => http.Response('Nothing', 404),
      );

      final LoginRepository loginRepository = LoginRepository(client: client);

      expect(loginRepository.getTokenRequest(), throwsException);
    });
  });

  group('Login | ', () {
    test('Returns a TokenRequest if the login works correctly', () async {
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

    test('throws an exception if the api call throws an Exception', () async {
      final client = MockClient();
      String url = '$baseUrl/authentication/token/new?api_key=$apiKey';

      when(
        client.get(Uri.parse(url)),
      ).thenAnswer(
        (_) async => http.Response('Nothing', 404),
      );

      final LoginRepository loginRepository = LoginRepository(client: client);

      expect(loginRepository.getTokenRequest(), throwsException);
    });
  });
}
