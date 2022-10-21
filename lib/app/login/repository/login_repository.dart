import 'package:movie_app_flutter/app/login/model/token_request.dart';

import 'package:http/http.dart' as http;

class LoginRepository {
  Future<http.Response> getTokenRquest() async {
    String url =
        'https://api.themoviedb.org/3/authentication/token/new?api_key=ccf5fd2c3d7836bd34d8b2a21a18c8b6';

    var response = await http.get(Uri.parse(url));

    return response;
  }
}
