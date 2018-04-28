import 'package:flutter/material.dart';

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
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new FloatingActionButton(
                  //icon: new Icon(Icons.navigate_next),
                  onPressed: _gotoNext,
                  mini: true,
                  child: new Icon(Icons.navigate_next),
                ),
              )
            ],
          ),
        ),
      );

  void _gotoNext() {}
}
