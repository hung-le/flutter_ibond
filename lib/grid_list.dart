import 'package:flutter/material.dart';

class GridListApp extends StatelessWidget {
  const GridListApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: const MyGrid(),
      ),
    );
  }
}

class MyGrid extends StatelessWidget {
  const MyGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildGridView(context);
  }

  GridView buildGridView(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 3,
      children: buildMyList(context),
    );
  }

  List<Center> buildMyList(BuildContext context) {
    return buildTestList(context);
  }

  // Generate widgets that display their index in the List.
  List<Center> buildTestList(BuildContext context) {
    return List.generate(12, (index) {
      return const Center(
        child: MyCard(8, 9),
      );
    });
  }
}

class MyCard extends StatelessWidget {
  final month;

  final interest;

  const MyCard(this.month, this.interest, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          children: children(),
        ),
      ),
    );
  }

  List<Widget> children() {
    var month = Text(
      '${this.month}',
      style: TextStyle(
        fontSize: 20,
        color: Colors.blue[900],
      ), // TextStyle
    );
    var interest = Text(
      '${this.interest}%',
      style: TextStyle(
        fontSize: 60,
        color: Colors.green[900],
      ),
    );
    return [
      month,
      interest,
    ];
  }
}
