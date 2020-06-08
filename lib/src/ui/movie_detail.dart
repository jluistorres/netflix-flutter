import 'package:flutter/material.dart';
import 'package:netflix/src/blocs/favorites_bloc.dart';
import 'package:netflix/src/models/movie.dart';
import 'package:netflix/src/resources/movie_api_provider.dart';

class MovieDetailScreen extends StatefulWidget {
  MovieDetailScreen({Key key, @required this.movie}) : super(key: key);

  final Movie movie;

  @override
  _MovieDetailScreen createState() => _MovieDetailScreen(movie);
}

class _MovieDetailScreen extends State<StatefulWidget> {
  FavoritesBloc blocFavorites;
  Future<MovieDetail> detail;
  final Movie movie;

  _MovieDetailScreen(this.movie);

  @override
  void initState() {
    super.initState();
    detail = MovieApiProvider().fetchMovieDetail(movie.imdbID);
    blocFavorites = FavoritesBloc();
  }

  @override
  Widget build(BuildContext context) {
    // movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.Title),
      ),
      floatingActionButton: StreamBuilder<List<Movie>>(
        stream: blocFavorites.favorites,
        builder: (context, snapshot) {
          return FloatingActionButton(
            child: Icon(Icons.favorite),
            backgroundColor: blocFavorites.inFavorites(movie) != -1
                ? Colors.red
                : Colors.white30,
            foregroundColor: Colors.white,
            onPressed: () {
              blocFavorites.toggleFavorite(movie);
              // print('toggle');
              // setState(() { });          
            },
          );
        }
      ),
      body: FutureBuilder<MovieDetail>(
        future: detail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var m = snapshot.data;
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: m.Poster != 'N/A'
                      ? NetworkImage(m.Poster)
                      : AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, .6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Resumen',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.yellow,
                          // letterSpacing: 7,
                        ),
                      ),
                      Text(m.Plot),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(m.Actors),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
