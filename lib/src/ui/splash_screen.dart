import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:netflix/src/ui/movie_list.dart';

class SplashScreen extends StatefulWidget {
  @override
  State createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(milliseconds: 1500),
      () {
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (BuildContext context) => MovieList()),
        // );
        Navigator.pushReplacementNamed(context, 'start');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.black),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      child: CircleAvatar(
                        radius: 48.0,
                        backgroundImage: AssetImage("assets/images/logo.png"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Text(
                      "Netflix",
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text(
                    "Por favor espere un\nmomento",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
