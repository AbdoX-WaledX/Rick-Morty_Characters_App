import 'package:lastbloc/data/models/charcter_model.dart';
import 'package:lastbloc/data/services/character_service.dart';

class CharactersRepository {
  Future<List<CharactersModel>> getAllCharacters() async {
    final List<dynamic> characters =
        await CharactersServices().getAllCharacters();
    return characters
        .map((character) => CharactersModel.fromJson(character))
        .toList();
  }
}
