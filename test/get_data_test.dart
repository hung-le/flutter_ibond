import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

Future<void> main() async {
  HttpOverrides.global =
      _MyHttpOverrides(); // Setting a customer override that'll use an unmocked HTTP client
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
    testGetHttpClient('Test with HTTP enabled', (tester) async {
      await tester.runAsync(() async {
        // Use `runAsync` to make real asynchronous calls
        var response =
            await http.Client().get(Uri.parse('https://www.google.com/'));
        logger.i("statusCode=${response.statusCode}");
        expect(
          (response).statusCode,
          200,
        );
      });
    });
  });
}

void testGetHttpClient(
    String s, Future<void> Function(dynamic tester) param1) {}

class _MyHttpOverrides extends HttpOverrides {}
