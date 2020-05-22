import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:marvelflutter/widgets/marvel_home.dart';

void main() {
  Stetho.initialize();

  runApp(MarvelFlutterApp());
}

class MarvelFlutterApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Flutter',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MarvelHome(),
    );
  }
}
