import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dictionary_app/url.dart';
import 'package:dictionary_app/models/models.dart';

import 'package:http/http.dart' as http;

//Used to fetch contents from Dictionary API

class DictionaryService {
  Future<List<DictionaryModel>> getMeaning({String? word}) async {
    final url = "$URL/$word";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print(response.body);
        final dictionaryModel = dictionaryModelFromJson(response.body);
        return dictionaryModel;
      } else {
        final dictionaryModel = dictionaryModelFromJson(response.body);
        return dictionaryModel;
      }
    } on SocketException catch (_) {
      return Future.error('No Internet Connection');
    } catch (_) {
      return Future.error('An Unknown error occured');
    }
  }
}
