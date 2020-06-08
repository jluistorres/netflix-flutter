import 'package:flutter/material.dart';
import 'package:netflix/src/models/movie.dart';
import 'package:netflix/src/widgets/drawer.dart';
import 'package:netflix/src/widgets/movie_widget.dart';
import 'package:netflix/src/blocs/movies_bloc.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _searchField = new TextEditingController();

  ScrollController _scrollController = new ScrollController();
  ScrollController _scrollPreferences = new ScrollController();

  MoviesBloc bloc;
  MoviesBloc blocPreferences;

  @override
  void initState() {
    super.initState();
    print('Iniciando vista...');
    bloc = MoviesBloc();
    blocPreferences = MoviesBloc();

    blocPreferences.fetchAllMovies('lolita');
    fetch();

    _scrollController.addListener(() {
      var triggerFetchMoreSize = _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels == triggerFetchMoreSize) {
        // ... call method to load more repositories
        bloc.nextPage();
      }
    });

    _scrollPreferences.addListener(() {
      var triggerFetchMoreSize = _scrollPreferences.position.maxScrollExtent;
      if (_scrollPreferences.position.pixels == triggerFetchMoreSize) {
        blocPreferences.nextPage();
      }
    });
  }

  void fetch() {
    var text = _searchField.text.isEmpty ? "man" : _searchField.text;

    bloc.fetchAllMovies(text, page: bloc.page);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _searchField.dispose();
    bloc.dispose();
    blocPreferences.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: _appBar(),
      backgroundColor: Colors.black,
      body: _body(),
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
        foregroundColor: Colors.white,
        onPressed: () {
          _scrollController.position.moveTo(0, duration: Duration(seconds: 1));
        },
        tooltip: 'Subir',
        child: Icon(Icons.arrow_upward),
      ),
    );
  }

  Widget _body() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          // title: new Text("Películas"),
          snap: true,
          primary: true,
          pinned: true,
          floating: true,
          expandedHeight: 200,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              tooltip: 'Mis favoritos',
              onPressed: () {
                // handle the press
                // Navigator.pushReplacementNamed(context, 'splash');
                Navigator.pushNamed(context, 'favorites');
              },
            ),
          ],
          backgroundColor: Colors.black,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Row(
              children: <Widget>[
                Spacer(),
                CircleAvatar(
                  radius: 54.0,
                  backgroundImage: AssetImage(
                    "assets/images/logo.png",
                  ),
                ),
                Spacer(),
              ],
            ),
            title: Text(
              'Netflix',
              style: Theme.of(context).textTheme.headline6,
            ),
            centerTitle: true,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      // width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mi Lista',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Container(
                      height: 170,
                      child: StreamBuilder<List<Movie>>(
                          stream: blocPreferences.movies,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _scrollPreferences,
                                itemBuilder: (cxt, index) {
                                  if (index < snapshot.data.length) {
                                    return Container(
                                      width: 130,
                                      child: PeliWidget(snapshot.data[index]),
                                    );
                                  } else {
                                    if (blocPreferences.page <
                                        blocPreferences.pages) {
                                      return Container(
                                        padding: EdgeInsets.all(20.0),
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }

                                  return SizedBox.shrink();
                                },
                                itemCount: snapshot.hasData
                                    ? snapshot.data.length + 1
                                    : 0,
                              );
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                    _formSearch()
                  ],
                ),
              );
            },
            childCount: 1,
          ),
        ),
        // SliverFillRemaining(
        //   child: Container(
        //     child: Center(
        //       child: Text('Orale'),
        //     ),
        //   ),
        // ),

        StreamBuilder<List<Movie>>(
          stream: bloc.movies,
          builder: (context, snapshot) {
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  final peliculas = snapshot.data;
                  return PeliWidget(peliculas[index]);
                },
                childCount: snapshot.hasData ? snapshot.data.length : 0,
              ),
            );
          },
        ),
        // usamos el mismo stream de las peliculas
        StreamBuilder<List<Movie>>(
            stream: bloc.movies,
            builder: (context, snapshot) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) {
                    return Container(
                      height: 100.0,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                  childCount: bloc.page < bloc.pages ? 1 : 0,
                ),
              );
            }),
      ],
    );
  }

  Widget _formSearch() {
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: _searchField,
          decoration: InputDecoration(hintText: 'Ingresa tu película...'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Ingresa una palabra';
            }
          },
          onFieldSubmitted: (value) {
            if (_formKey.currentState.validate()) {
              bloc.page = 1;
              bloc.pages = 0;
              bloc.cache = null;
              fetch();

              // Si el formulario es válido, queremos mostrar un Snackbar
              final snackBar = SnackBar(
                  content: Text('Resultados para ${_searchField.text}...'));
              _scaffoldKey.currentState.showSnackBar(snackBar);
            }
          },
        ),
      ),
    );
  }
}
