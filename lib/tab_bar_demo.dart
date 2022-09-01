import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ibond/grid_list.dart';
import 'package:ibond/line_chart.dart';
import 'package:ibond/sb_value.dart';

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabBarDemoState();
  }
}

class _TabBarDemoState extends State<TabBarDemo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              MyGrid(),
              MyLineChart(),
              MyList(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyListState();
  }
}

class _MyListState extends State<MyList> {
  late Future<SbValuesModel> futureModel;

  Future<SbValuesModel> fetchModel(String url) async {
    final response = await http.get(Uri.parse(url));

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

  createModel() {
    var host =
        'https://api.fiscaldata.treasury.gov/services/api/fiscal_service/v2';
    var context = '/accounting/od/sb_value';
    var year = 2000;
    var query =
        '?filter=series_cd:eq:I,issue_year:eq:$year,redemption_year:in:(2022,2023)';

    var url = '$host$context$query';
    return fetchModel(url);
  }

  @override
  void initState() {
    super.initState();
    futureModel = createModel();
  }

  @override
  Widget build(BuildContext context) {
    var builder = FutureBuilder(
        future: futureModel,
        builder: (BuildContext context, AsyncSnapshot<SbValuesModel> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return createListView(data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
    return builder;
  }

  ListView createListView(SbValuesModel model) {
    const int month = 1;
    return ListView.builder(
        itemCount: model.values.length,
        itemBuilder: (BuildContext context, int index) {
          SbValueModel item = model.values[index];
          double amount = item.amounts[month - 1];
          return ListTile(
              leading: const Icon(Icons.list),
              trailing: Text(
                "$amount",
                style: const TextStyle(color: Colors.green, fontSize: 15),
              ),
              title: Text(
                  "$month/${item.issueYear}, ${item.redemptionMonth}/${item.redemptionYear}"));
        });
  }

  ListView createStaticListView() {
    var view = ListView(
      children: const <Widget>[
        ListTile(
          title: Text('Black'),
        ),
        ListTile(
          title: Text('White'),
        ),
        ListTile(
          title: Text('Grey'),
        ),
      ],
    );
    return view;
  }
}

class MyImage extends StatelessWidget {
  const MyImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = Image.network(
      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.amber,
          alignment: Alignment.center,
          child: const Text(
            'Whoops! Image not found.',
            style: TextStyle(fontSize: 30),
          ),
        );
      },
    );
    return image;
  }
}
