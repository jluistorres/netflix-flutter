import 'package:netflix/src/models/movie.dart';
import 'package:netflix/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

// De esta clase necesito multiples instancias para varias listas personalizadas
// por eso no es Singleton
class MoviesBloc {
  final _repository = Repository();

  String searchText;
  int page = 1;
  int total = 0;
  int pages = 0;
  bool _loading = false;

  List<Movie> cache;
  final _moviesFetcher = PublishSubject<List<Movie>>();
  // Stream que se va emitir para actualizar la vista
  Stream<List<Movie>> get movies => _moviesFetcher.stream;

  void fetchAllMovies(String text, {int page}) async {
    searchText = text;
    if (!_loading) {
      _loading = true;

      MovieResult result = await _repository.fetchMovies(text, page: page);

      total = result.totalResults;
      pages = (total / 10).ceil();
      print('Paginas: $pages');

      if (cache == null) cache = new List<Movie>();

      cache.addAll(result.Search);
      _moviesFetcher.sink.add(cache);

      _loading = false;
    }
  }

  void nextPage() {
    if (page < pages) {
      page++;

      print('searching... $page of $pages páginas');
      fetchAllMovies(searchText, page: page);
    }
  }

  dispose() {
    _moviesFetcher.close();
  }
}

// final bloc = MoviesBloc();
