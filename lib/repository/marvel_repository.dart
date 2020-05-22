import 'package:dio/dio.dart';
import 'package:marvelflutter/model/character_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import 'dart:convert';

class MarvelRepository {

  Future<List<Character>> fetchCharacters(int offset) async {

    var loadString = await rootBundle.loadString('assets/secrets.json');
    Map<String, dynamic> secretMap = json.decode(loadString);

    final pubKey = secretMap['pubKey'];
    final privKey = secretMap['privKey'];

    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = _generateMd5(timestamp + privKey + pubKey).toString();

    Map<String, dynamic> queryParameters = {
      "apikey": pubKey,
      "hash": hash,
      "ts": timestamp,
      "limit": 100,
      "offset": offset
    };

    final dio = Dio();

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

    final response = await dio.get('http://gateway.marvel.com/v1/public/characters', queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return CharactersResponse.fromJson(json.decode(response.toString())).data.characters;
    } else {
      throw Exception('Failed to load album');
    }
  }

  _generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}

