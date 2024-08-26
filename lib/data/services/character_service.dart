import 'package:dio/dio.dart';
import 'package:lastbloc/constants/strings.dart';

class CharactersServices {
  late Dio dio;

  CharactersServices() {
    BaseOptions option = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: 20 * 1000,
      // receiveTimeout: 20 * 1000,
    );

    dio = Dio(option);
  }

  Future getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
     //print(response.data.toString());
      return response.data;
    } on Exception catch (e) {
      print(e.toString());
      return [];
    }
  }
}
