import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:ibond/sb_value.dart';
import 'package:logger/logger.dart';

void main() {
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: false,
  ));

  test('test 1', () {
    logger.i('test 1 ...');

    Future<Album> fetchAlbum() async {
      logger.i('> calling fetchAlbum ...');

      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1xxx'));
      logger.i('< calling fetchAlbum ...');

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return Album.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    }

    () async {
      var album = fetchAlbum();
      await album;
    };
  });

  test('test 2', () {
    Future<SbValuesModel> fetchModel(String url) async {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return SbValuesModel.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load model');
      }
    }

    var host =
        'https://api.fiscaldata.treasury.gov/services/api/fiscal_service/v2';
    var context = '/accounting/od/sb_value';

    for (var i = 2000; i < 2023; i++) {
      var year = i;
      var query =
          '?filter=series_cd:eq:I,issue_year:eq:$year,redemption_year:in:(2022,2023)';

      var url = '$host$context$query';
      // debugPrint('GET: $url');

      fetchModel(url).then((model) {
        logger.i('values: ${model.values.length}');
        expect(model.values.isNotEmpty, false);
      });
    }
  });
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
