import 'package:flutter/material.dart';
import 'package:netflix/src/blocs/favorites_bloc.dart';
import 'package:netflix/src/models/movie.dart';
import 'package:netflix/src/widgets/movie_widget.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoritesBloc favoritesBloc = FavoritesBloc();

  @override
  void initState() {
    // favoritesBloc = FavoritesBloc();
    // print(favoritesBloc.count);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis películas'),
      ),
      body: StreamBuilder<List<Movie>>(
          stream: favoritesBloc.favorites,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Sin favoritos'),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 3,
                ),
                itemBuilder: (ctx, index) {
                  final Movie peli = snapshot.data[index];
                  return PeliWidget(peli);
                },
                itemCount: snapshot.data.length,
              ),
            );
          }),
    );
  }
}
