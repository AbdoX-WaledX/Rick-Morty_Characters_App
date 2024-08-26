import 'package:bloc/bloc.dart';
import 'package:lastbloc/data/models/charcter_model.dart';

import '../../data/repository/character_repository.dart';
import 'character_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  List<CharactersModel> characters = [];

  CharactersCubit() : super(CharactersInitial());

  List<CharactersModel> getAllCharacters() {
    CharactersRepository().getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });

    return characters;
  }
}
