import 'package:flutter/material.dart';
import 'package:netflix/src/ui/favorites_screen.dart';
// import 'package:netflix/src/ui/infinite.dart';
import 'package:netflix/src/ui/movie_detail.dart';
import 'package:netflix/src/ui/movie_list.dart';
import 'package:netflix/src/ui/splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Nunito',
            ),
      ),
      // home: SplashScreen(),
      // home: MovieList(),
      initialRoute: 'splash',
      // routes: {
      //   '/': (context) => MovieList(),
      //   '/detail': (context) => MovieDetailScreen()
      // },
      onGenerateRoute: (RouteSettings settings) {
        // print('build route for ${settings.name}');
        var routes = <String, WidgetBuilder>{
          "splash": (ctx) => SplashScreen(),
          "start": (ctx) => MovieList(), //InfiniteWidget(),
          "favorites": (ctx) => FavoritesScreen(),
          "detail": (ctx) => MovieDetailScreen(movie: settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
