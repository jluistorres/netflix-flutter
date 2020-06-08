import 'package:netflix/src/models/movie.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesBloc {
  // Singleton
  static final FavoritesBloc _singleton = FavoritesBloc._internal();

  factory FavoritesBloc() {
    return _singleton;
  }

  FavoritesBloc._internal();
  // end singleton

  List<Movie> _favorites;

  // PublishSubject : comienza vacío y solo emite elementos nuevos para los suscriptores
  // BehaviorSubject: recuerda el último elemento emitido
  final _favoritesSubject = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get favorites => _favoritesSubject.stream;

  int get count => _favorites?.length ?? 0;
  // List<Movie> get lista => _favorites;

  toggleFavorite(Movie movie) {
    int index = inFavorites(movie);

    if (index == -1) {
      _favorites.add(movie);
    } else {
      _favorites.removeAt(index);
    }

    _favoritesSubject.sink.add(_favorites);
  }

  inFavorites(Movie movie) {
    if (_favorites == null) _favorites = new List<Movie>();
    return _favorites.indexWhere((element) => element.imdbID == movie.imdbID);
  }

  dispose() {
    _favoritesSubject.close();
  }
}
