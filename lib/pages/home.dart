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
    final int year;
    final int month;
    final String yearMonth;
    final List<int> contributions;

    _ContributionTile({this.year, this.month})
        : contributions = [],
          yearMonth = '${year.toString()}-${month.toString().padLeft(2,'0')}';

    bool isPresentMonth() {
      DateTime today = new DateTime.now();
      return (year == today.year && month == today.month);
    }

    @override
    String toString() => '${yearMonth}:' + contributions.length.toString();
  }

  class _MyHomePageState extends State<_InnerMyHomePage> {
    final GitHubUser model;
    List<_ContributionTile> monthlyContributions = [];

    _MyHomePageState(this.model) {
      monthlyContributions = model.contributions
          .fold(<_ContributionTile>[],
              (List<_ContributionTile> list, Contribution contib) {
            String key =
                '${contib.year.toString()}-${contib.month.toString().padLeft(2,'0')}';
            _ContributionTile tile;
            if (!list.any((c) => c.yearMonth == key)) {
              tile =
                  new _ContributionTile(year: contib.year, month: contib.month);
              list.add(tile);
            } else {
              tile = list.firstWhere((c) => c.yearMonth == key);
            }
            tile.contributions.add(contib.value);
            return list;
          })
          .reversed
          .toList();
    }

    @override
    Widget build(BuildContext context) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('GitHub Grass'),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.refresh),
                onPressed: model.update,
              )
            ],
          ),
          body: new ListView.builder(
            itemCount: monthlyContributions.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _createIdentityWidget();
              } else {
                _ContributionTile monthlyContrib =
                    monthlyContributions[index - 1];
                return _createMonthlyContributionMap(monthlyContrib);
              }
            },
          ));
    }

    Widget _createIdentityWidget() {
      DateTime today = new DateTime.now();

      Contribution c = model.contributions.firstWhere((c) =>
          c.year == today.year && c.month == today.month && c.day == today.day);
      int value = c.value ?? 0;

      String todayLabel =
          '${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}';

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
                      '${todayLabel} is not contributed yet.❌',
                      style: new TextStyle(
                        color: Colors.red,
                      ),
                    ),
            ],
          ),
        ),
      );
    }

    Widget _createMonthlyContributionMap(_ContributionTile monthlyContrib) {
      return new Column(
        children: <Widget>[
          new Text(monthlyContrib.yearMonth),
          new Row(
            mainAxisSize: MainAxisSize.max,
            children: monthlyContrib.contributions.map(
              (c) {
                Widget valueText = new Text(
                  c.toString(),
                  style: new TextStyle(
                    fontSize: 10.0,
                  ),
                );
                valueText = _createValueBox(c);
                return new Flexible(
                  flex: 1,
                  child: monthlyContrib.isPresentMonth()
                      ? valueText
                      : new Center(
                          child: valueText,
                        ),
                );
              },
            ).toList(),
          )
        ],
      );
    }

    Widget _createValueBox(int value) => new Container(
          height: 20.0,
          color: (value == 0)
              ? Colors.grey[200]
              : Colors.green[(value > 8 ? 9 : value) * 100],
        );
  }
