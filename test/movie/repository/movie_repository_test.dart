import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_flutter/app/movie/model/top_rated.dart';
import 'package:movie_app_flutter/app/movie/repository/movie_repository.dart';
import 'package:movie_app_flutter/app/utils/constants.dart';

import 'movie_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Get TopRated Movies | ', () {
    test('Returns a TopRated if the api call works correctly', () async {
      final client = MockClient();
      String language = 'pt-BR';
      String url =
          '$baseUrl/movie/top_rated?api_key=$apiKey&language=$language&page=1';

      when(
        client.get(Uri.parse(url)),
      ).thenAnswer(
        (_) async => http.Response(fakeResponse, 200),
      );

      final MovieRepository movieRepository = MovieRepository(client: client);

      expect(await movieRepository.getTopRatedMovies(1), isA<TopRated>());
    });

    test('throws an exception if the api call throws an Exception', () async {
      final client = MockClient();
      String language = 'pt-BR';
      String url =
          '$baseUrl/movie/top_rated?api_key=$apiKey&language=$language&page=1';

      when(
        client.get(Uri.parse(url)),
      ).thenAnswer(
        (_) async => http.Response('Nothing', 404),
      );

      final MovieRepository movieRepository = MovieRepository(client: client);

      expect(movieRepository.getTopRatedMovies(1), throwsException);
    });
  });
}

String fakeResponse =
    '{"page": 1,"results": [{"adult": false,"backdrop_path": "/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg","genre_ids": [18,80],"id": 238,"original_language": "en","original_title": "The Godfather","overview": "Em 1945, Don Corleone é o chefe de uma mafiosa família italiana de Nova York. Ele costuma apadrinhar várias pessoas, realizando importantes favores para elas, em troca de favores futuros. Com a chegada das drogas, as famílias começam uma disputa pelo promissor mercado. Quando Corleone se recusa a facilitar a entrada dos narcóticos na cidade, não oferecendo ajuda política e policial, sua família começa a sofrer atentados para que mudem de posição. É nessa complicada época que Michael, um herói de guerra nunca envolvido nos negócios da família, vê a necessidade de proteger o seu pai e tudo o que ele construiu ao longo dos anos.","popularity": 110.229,"poster_path": "/oJagOzBu9Rdd9BrciseCm3U3MCU.jpg","release_date": "1972-03-14","title": "O Poderoso Chefão","video": false,"vote_average": 8.7,"vote_count": 16778}],"total_pages": 522,"total_results": 10426}';
