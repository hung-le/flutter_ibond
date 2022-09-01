import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:ibond/user.dart';

class ApiProvider {
  final Client client;

  ApiProvider(this.client);

  Future<UserModel> getUser() async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    return UserModel.fromJson(jsonDecode(response.body));
  }
}
