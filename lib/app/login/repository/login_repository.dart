import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app_flutter/app/login/model/token_request.dart';
import 'package:movie_app_flutter/app/utils/constants.dart';
import 'package:movie_app_flutter/app/utils/exceptions.dart';

class LoginRepository {
  TokenRequest _tokenRequest = TokenRequest();
  http.Client client;

  LoginRepository({
    required this.client,
  });

  Future<TokenRequest> getTokenRequest() async {
    String url = '$baseUrl/authentication/token/new?api_key=$apiKey';

    var response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      _tokenRequest = TokenRequest.fromMap(jsonResponse);

      return _tokenRequest;
    } else {
      throw Exception();
    }
  }

  Future<TokenRequest> login(
      String userName, String password, String requestToken) async {
    String url =
        '$baseUrl/authentication/token/validate_with_login?api_key=$apiKey';

    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'username': userName,
      'password': password,
      'request_token': requestToken
    };

    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      var tokenInfos = jsonDecode(response.body);

      _tokenRequest = TokenRequest.fromMap(tokenInfos);

      return _tokenRequest;
    } else if (response.statusCode == 401) {
      throw LoginErrorException('Invalid user or/and passoword');
    } else {
      throw Exception();
    }
  }
}
