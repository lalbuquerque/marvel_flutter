import 'package:marvelflutter/view/characters_view.dart';
import 'package:marvelflutter/repository/marvel_repository.dart';

class CharactersPresenter {
  CharactersView _view;
  int _offset = -100;

  void initView(CharactersView charactersView) {
    _view = charactersView;
    _view.showLoadingLayout();
  }

  void loadCharacters() {
    _offset += 100;
    MarvelRepository().fetchCharacters(_offset)
        .then((value) { _view.populateCharactersList(value); })
        .catchError((onError) { _view.showErrorLayout(); });
  }
}