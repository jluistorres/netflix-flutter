import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Widget de prueba para conocer el funcionamiento del scroll infinito
class InfiniteWidget extends StatefulWidget {
  @override
  _InfiniteWidget createState() => _InfiniteWidget();
}

class _InfiniteWidget extends State<InfiniteWidget> {
  List<String> dogImages = new List();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    fetchFive();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('load more images...');
        fetchFive();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: dogImages.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          constraints: BoxConstraints.tightFor(height: 150.0),
          child: Image.network(
            dogImages[index],
            fit: BoxFit.fitWidth,
          ),
        );
      },
    );
  }

  fetch() async {
    final response = await http.get('https://dog.ceo/api/breeds/image/random');
    if (response.statusCode == 200) {
      setState(() {
        dogImages.add(json.decode(response.body)['message']);
      });
    } else {
      throw Exception('Failed to load images');
    }
  }

  fetchFive() {
    for (int i = 0; i < 5; i++) {
      fetch();
    }
  }
}
