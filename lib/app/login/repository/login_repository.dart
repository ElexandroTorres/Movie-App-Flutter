import 'dart:convert';

import 'package:movie_app_flutter/app/login/model/token_request.dart';

import 'package:http/http.dart' as http;

class LoginRepository {
  TokenRequest tokenRequest = TokenRequest();

  Future<TokenRequest> getTokenRquest() async {
    String url =
        'https://api.themoviedb.org/3/authentication/token/new?api_key=ccf5fd2c3d7836bd34d8b2a21a18c8b6';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var roverInfos = jsonDecode(response.body);

      tokenRequest = TokenRequest.fromMap(roverInfos);

      return tokenRequest;
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future<TokenRequest> login(String userName, String password) async {
    String url =
        'https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=ccf5fd2c3d7836bd34d8b2a21a18c8b6';

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
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
