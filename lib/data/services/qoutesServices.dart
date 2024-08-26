import 'package:dio/dio.dart';
import 'package:lastbloc/constants/strings.dart';

class QoutesServices {
  late Dio dio;

  QoutesServices() {
    BaseOptions option = BaseOptions(
      baseUrl: baseUrl_Quotes,
      receiveDataWhenStatusError: true,
      // connectTimeout: 20 * 1000,
      // receiveTimeout: 20 * 1000,
    );
    dio = Dio(option);
  }
   Future getQuotes() async {
    try {
      Response response = await dio.get('quotes/');
     print(response.data.toString());
      return response.data;
    } on Exception catch (e) {
      print(e.toString());
      return [];
    }
  }
}
