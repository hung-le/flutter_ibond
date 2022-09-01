import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ibond/api_provider.dart';
import 'package:ibond/user.dart';

void main() {
  test('test 1', () {
    // The model should be able to receive the following data:
    final user = UserModel(
      userId: 1,
      id: 1,
      title: '',
      body: '',
    );

    expect(user.userId, 1);
    expect(user.id, 1);
    expect(user.title, '');
    expect(user.body, '');
  });

  test('test 2', () {
    final file =
        File('test/test_resources/random_user.json').readAsStringSync();
    final user = UserModel.fromJson(jsonDecode(file) as Map<String, dynamic>);

    expect(user.userId, 1);
    expect(user.id, 1);
    expect(
      user.title,
      'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
    );
    expect(
      user.body,
      'quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto',
    );
  });

  test('test 3', () async {
    Future<http.Response> _mockRequest(http.Request request) async {
      if (request.url
          .toString()
          .startsWith('https://jsonplaceholder.typicode.com/posts/')) {
        return http.Response(
            File('test/test_resources/random_user.json').readAsStringSync(),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      }
      return http.Response('Error: Unknown endpoint', 404);
    }

    final apiProvider = ApiProvider(MockClient(_mockRequest));
    final user = await apiProvider.getUser();
    expect(user.userId, 1);
    expect(user.id, 1);
    expect(
      user.title,
      'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
    );
    expect(
      user.body,
      'quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto',
    );
  });
}
