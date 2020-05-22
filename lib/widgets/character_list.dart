import 'package:flutter/material.dart';
import 'package:marvelflutter/model/character_response.dart';
import 'package:marvelflutter/presenter/characters_presenter.dart';
import 'package:marvelflutter/view/characters_view.dart';
import 'package:marvelflutter/widgets/loading_list_item.dart';
import 'package:shimmer/shimmer.dart';

import 'character_list_item.dart';

class CharactersList extends StatefulWidget {
  final CharactersPresenter charactersPresenter;

  CharactersList(this.charactersPresenter) {}

  @override
  State<StatefulWidget> createState() => CharactersListState();
}

class CharactersListState extends State<CharactersList>
    implements CharactersView {
  var _isLoadingContent = true;
  ScrollController _scrollController;
  List<Character> _characters = List<Character>();

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    this.widget.charactersPresenter.initView(this);
    this.widget.charactersPresenter.loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Characters'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: _isLoadingContent
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) => Shimmer.fromColors(
                            baseColor: Colors.grey[200],
                            period: Duration(milliseconds: 3000),
                            highlightColor: Colors.white,
                            child: CharacterListItem(index: -1)),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _characters.length + 1,
                        itemBuilder: (context, index) {

                          if (index == _characters.length) {
                            return LoadingListItem(index: index,);
                          }

                          final character = _characters[index];
                          return CharacterListItem(
                            index: index,
                            name: character.name,
                            description: character.description,
                            imgUrl: character.thumbnail.path +
                                "." +
                                character.thumbnail.extension,
                          );
                        },
                      ))
          ],
        ));
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      this.widget.charactersPresenter.loadCharacters();
    }
  }

  @override
  void showLoadingLayout() {
    setState(() {
      _isLoadingContent = true;
    });
  }

  @override
  void hideLoadingLayout() {
    setState(() {
      _isLoadingContent = false;
    });
  }

  @override
  void populateCharactersList(List<Character> characters) {
    setState(() {
      _isLoadingContent = false;
      _characters.addAll(characters);
    });
  }

  @override
  void showErrorLayout() {
    // TODO: implement showErrorLayout
  }
}
