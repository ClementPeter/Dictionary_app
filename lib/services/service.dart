import 'dart:io';
import 'package:dictionary_app/models/models.dart';

import 'package:http/http.dart' as http;

//Used to fetch contents from Dictionary API

class DictionaryService {
  Future<List<DictionaryModel>> getMeaning({String? word}) async {
    final url = "https://api.dictionaryapi.dev/api/v2/entries/en/$word";

    try {
      final response = await http.get(Uri.parse(url));
      //print(response.statusCode);

      if (response.statusCode == 200) {
        //print(response.body);
        final dictionaryModel = dictionaryModelFromJson(response.body);
        return dictionaryModel;
      } else {
        final dictionaryModel = dictionaryModelFromJson(response.body);
        return dictionaryModel;
      }
    } on SocketException catch (_) {
      return Future.error('No Internet Connection');
    } catch (_) {
      return Future.error('An unknown error occured, Please retry');
    }
  }
}
