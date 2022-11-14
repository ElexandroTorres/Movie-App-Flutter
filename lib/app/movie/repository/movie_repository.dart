import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app_flutter/app/movie/model/top_rated.dart';
import 'package:movie_app_flutter/app/utils/constants.dart';

class MovieRepository {
  MovieRepository({
    required this.client,
  });
  http.Client client;

  Future<TopRated> getTopRatedMovies(int page) async {
    String language = 'pt-BR';
    String url =
        '$baseUrl/movie/top_rated?api_key=$apiKey&language=$language&page=$page';
    late TopRated topRated;

    var response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      topRated = TopRated.fromJson(jsonResponse);
    } else {
      throw Exception();
    }
    return topRated;
  }
}
