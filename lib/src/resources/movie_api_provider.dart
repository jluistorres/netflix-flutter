import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix/src/models/movie.dart';

class MovieApiProvider {
  final String _api = 'http://www.omdbapi.com/?apikey=7efaf4dc';

  Future<MovieResult> fetchMovies(String text, {int page}) async {
    if (page == null) page = 1;

    final response = await http.get('$_api&s=$text&page=$page');

    if (response.statusCode == 200) {
      return MovieResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Movies');
    }
  }

  Future<MovieDetail> fetchMovieDetail(String id) async {
    final response = await http.get('$_api&i=$id');

    if (response.statusCode == 200) {
      return MovieDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail');
    }
  }
}
