import 'package:flutter/material.dart';
import 'package:netflix/src/models/movie.dart';

class PeliWidget extends StatelessWidget {
  const PeliWidget(this.params);

  final Movie params;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Peli ${params.Title}');
        Navigator.pushNamed(context, 'detail', arguments: params);
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: params.Poster != 'N/A'
                  ? NetworkImage(params.Poster)
                  : AssetImage('assets/images/logo.png'),
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
            ),
          ),
          //Título de la peli
          child: Container(
            decoration: BoxDecoration(color: new Color.fromRGBO(0, 0, 0, 0.5)),
            width: double.infinity,
            padding: EdgeInsets.all(5),
            child: Text(
              params.Title != null ? params.Title : '',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        // margin: EdgeInsets.all(10),
      ),
    );
  }
}