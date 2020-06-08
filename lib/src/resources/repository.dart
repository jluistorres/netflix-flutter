import 'package:netflix/src/models/movie.dart';
import 'package:netflix/src/resources/movie_api_provider.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<MovieResult> fetchMovies(String text, {int page}) =>
      movieApiProvider.fetchMovies(text, page: page);

  Future<MovieDetail> fetchMovieDetail(String id) =>
      movieApiProvider.fetchMovieDetail(id);
}
