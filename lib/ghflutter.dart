import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'member.dart';
import 'strings.dart' as strings;

class GHFlutterApp extends StatelessWidget {
  const GHFlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: strings.appTitle,
      home: GHFlutter(),
      theme: ThemeData(
        primaryColor: Colors.deepOrange.shade800,
      ),
    );
  }
}

class GHFlutter extends StatefulWidget {
  const GHFlutter({Key? key}) : super(key: key);

  @override
  State<GHFlutter> createState() => _GHFlutterState();
}

class _GHFlutterState extends State<GHFlutter> {
  final _members = <Member>[];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appTitle),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _members.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildRow(index);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  Future<void> _loadData() async {
    const dataUrl = 'https://api.github.com/orgs/raywenderlich/members';
    final response = await http.get(Uri.parse(dataUrl));
    setState(() {
      final dataList = json.decode(response.body) as List;
      for (final item in dataList) {
        final login = item['login'] as String? ?? '';
        final url = item['avatar_url'] as String? ?? '';
        final member = Member(login, url);
        _members.add(member);
      }
    });
  }

  Widget _buildRow(int index) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Text(
          '${_members[index].login}',
          style: _biggerFont,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: NetworkImage(_members[index].avatarUrl),
        ),
      ),
    );
  }
}
