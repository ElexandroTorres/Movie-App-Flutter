import 'dart:convert';

import 'package:movie_app_flutter/app/login/model/token_request.dart';

import 'package:http/http.dart' as http;
import 'package:movie_app_flutter/app/utils/constants.dart';

class NoInternetException implements Exception {}

class FailToLoginException implements Exception {}

class LoginRepository {
  TokenRequest tokenRequest = TokenRequest();

  Future<TokenRequest> getTokenRequest() async {
    String url = '$baseUrl/authentication/token/new?api_key=$apiKey';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var roverInfos = jsonDecode(response.body);

      tokenRequest = TokenRequest.fromMap(roverInfos);

      return tokenRequest;
    } else {
      throw NoInternetException();
    }
  }

  Future<TokenRequest> login(String userName, String password) async {
    String url =
        '$baseUrl/authentication/token/validate_with_login?api_key=$apiKey';

    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'username': userName,
      'password': password,
      "request_token": tokenRequest.requestToken
    };

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      var roverInfos = jsonDecode(response.body);

      tokenRequest = TokenRequest.fromMap(roverInfos);

      return tokenRequest;
    } else if (response.statusCode == 401) {
      throw FailToLoginException();
    } else {
      throw NoInternetException();
    }
  }
}
