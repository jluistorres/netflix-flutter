import 'package:flutter/material.dart';
import 'package:netflix/src/blocs/favorites_bloc.dart';

class DrawerWidget extends StatelessWidget {
  final FavoritesBloc favoritesBloc = FavoritesBloc();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: ListView(
          // Importante: elimina cualquier padding del ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Películas',
                style: Theme.of(context).textTheme.headline4,
              ),
              // decoration: BoxDecoration(
              //   color: Colors.red,
              // ),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Color(0xFF3f0303), Colors.black],
                  begin: const FractionalOffset(1.0, 0.1),
                  end: const FractionalOffset(1.0, 0.9),
                ),
              ),
            ),
            /* ListTile(
              title:
                  Text('Inicio', style: Theme.of(context).textTheme.headline6),
              onTap: () {
                // Actualiza el estado de la aplicación
                // ...
                // Luego cierra el drawer
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, 'start');
              },
            ), */
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Mis favoritos',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Spacer(),
                  favoritesBloc.count > 0
                      ? Container(
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.red,
                          ),
                          child: Text(
                            favoritesBloc.count.toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              onTap: () {
                // // Actualiza el estado de la aplicación
                // ...
                // Luego cierra el drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, 'favorites');
              },
            ),
          ],
        ),
      ),
    );
  }
}
