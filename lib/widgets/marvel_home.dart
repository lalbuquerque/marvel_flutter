import 'package:flutter/material.dart';
import 'package:marvelflutter/presenter/characters_presenter.dart';
import 'package:marvelflutter/widgets/character_list.dart';

class MarvelHome extends StatefulWidget {

  @override
  _MarvelHomeState createState() => _MarvelHomeState();
}

class _MarvelHomeState extends State<MarvelHome> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel Flutter'),
      ),
      body: Center(
        child: Image(image: AssetImage('images/ic_marvel.png')),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: _openCharactersList,
        tooltip: 'View heroes',
        child: Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _openCharactersList() {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return CharactersList(new CharactersPresenter());
          },
        ),
    );
  }
}