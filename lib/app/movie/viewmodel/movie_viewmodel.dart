import 'package:flutter/foundation.dart';
import 'package:movie_app_flutter/app/movie/model/movie.dart';
import 'package:movie_app_flutter/app/movie/model/top_rated.dart';
import 'package:movie_app_flutter/app/movie/repository/movie_repository.dart';

enum LoadingStatus { empty, initialLoading, loading, success, error }

class MovieViewModel extends ChangeNotifier {
  MovieViewModel({required this.movieRepository});

  final MovieRepository movieRepository;

  List<Movie> _topRatedList = [];
  List<Movie> get topRatedList => _topRatedList;

  LoadingStatus _loadingStatus = LoadingStatus.empty;
  LoadingStatus get loadingStatus => _loadingStatus;
  TopRated? _topRated;
  int _currentPage = 1;

  Future<void> getTopRated() async {
    try {
      if (_currentPage == 1) {
        _loadingStatus = LoadingStatus.loading;
      }

      notifyListeners();
      _topRated = await movieRepository.getTopRatedMovies(_currentPage);
      _topRatedList.addAll(_topRated!.results!);

      if (_topRated != null) {
        _loadingStatus = LoadingStatus.success;
        _currentPage++;
        notifyListeners();
      }
    } catch (error) {
      _loadingStatus = LoadingStatus.error;
      notifyListeners();
    }
  }

  void resetConfigs() {
    _currentPage = 1;
    _topRatedList = [];
    _loadingStatus = LoadingStatus.empty;
    notifyListeners();
  }
}
