import 'package:flutter/material.dart';
import 'package:github_grass/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new ScopedModelDescendant<GitHubUser>(
      builder: (context, child, model) => new _InnerMyHomePage(model));
}

class _InnerMyHomePage extends StatefulWidget {
  final GitHubUser model;
  const _InnerMyHomePage(this.model);

  @override
  _MyHomePageState createState() => new _MyHomePageState(model);
}

class _ContributionTile {
  final String yearMonth;
  final List<int> contributions;

  _ContributionTile(this.yearMonth) : contributions = [];

  @override
  String toString() {
    return '${yearMonth}:' + contributions.length.toString();
  }
}

class _MyHomePageState extends State<_InnerMyHomePage> {
  final GitHubUser model;
  List<_ContributionTile> monthlyContributions = [];

  _MyHomePageState(this.model) {
    monthlyContributions = model.contributions
        .fold(<_ContributionTile>[],
            (List<_ContributionTile> list, Contribution contib) {
          String key = '${contib.year}-${contib.month}';
          _ContributionTile tile = null;
          if (!list.any((c) => c.yearMonth == key)) {
            tile = new _ContributionTile(key);
            list.add(tile);
          } else {
            tile = list.firstWhere((c) => c.yearMonth == key);
          }
          tile.contributions.add(contib.value);
          return list;
        })
        .reversed
        .toList();
    //monthlyContributions.reversed.toList();
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        title: new Text('GitHub Grass'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.refresh), onPressed: () => model.update())
        ],
      ),
      body: new ListView.builder(
        itemCount: monthlyContributions.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _createIdentityWidget();
          }
          return new Column(
            children: <Widget>[
              new Text(monthlyContributions[index - 1].yearMonth),
              new Row(
                children: monthlyContributions[index - 1].contributions.map(
                  (c) {
                    return new Flexible(
                      flex: 1,
                      child: new Text(
                        c.toString(),
                        style: new TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                    );
                  },
                ).toList(),
              )
            ],
          );
        },
      ));

  Widget _createIdentityWidget() {
    DateTime today = new DateTime.now();
    String dateSlug =
        "${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";

    Contribution c = model.contributions.firstWhere((c) =>
        c.year == today.year && c.month == today.month && c.day == today.day);
    int value = c.value ?? 0;

    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Center(
        child: new Column(
          children: <Widget>[
            new CircleAvatar(
              backgroundImage: new NetworkImage(
                  'https://avatars.githubusercontent.com/${model.username}'),
            ),
            new Text(
              model.username,
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
            value > 0
                ? new Text(
                    'Today\'s contribution is ${value}! 👍',
                    style: new TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : new Text(
                    'Today is not contributed yet.❌',
                    style: new TextStyle(
                      color: Colors.red,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
