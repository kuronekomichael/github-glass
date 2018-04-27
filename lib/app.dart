import 'package:flutter/material.dart';
import 'package:github_grass/theme.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => new MaterialApp(
        theme: grassTheme,
        home: new MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller =
      new TextEditingController(text: 'kuronekomichael');

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text('Github Grass'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'images/github.png',
                width: 100.0,
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: new Text(
                  'Please your github name:',
                ),
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: new TextField(
                  controller: _controller,
                  autofocus: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
}
