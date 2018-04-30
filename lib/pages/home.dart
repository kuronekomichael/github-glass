import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_grass/pages/export.dart';
import 'package:http/http.dart' as http;
//import 'package:github_grass/models/user.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isNameInputed = false;
  bool isValidUser = false;
  String avatorUrl = '';

  final TextEditingController _controller =
      new TextEditingController(text: 'kuronekomichael');

  static const iconWidth = 100.0;

  @override
  Widget build(BuildContext context) {
    isNameInputed = _controller.text.isNotEmpty;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Github Grass'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isValidUser
                ? new Image.network(
                    avatorUrl,
                    width: iconWidth,
                  )
                : new Image.asset(
                    'images/github.png',
                    width: iconWidth,
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
                onSubmitted: _onSubmitted,
                onChanged: _onChanged,
                controller: _controller,
                autofocus: true,
                textAlign: TextAlign.center,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: isValidUser
                  ? new Column(
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(right: 50.0),
                              child: new FloatingActionButton(
                                backgroundColor: Colors.red,
                                //icon: new Icon(Icons.navigate_next),
                                onPressed: null,
                                mini: true,
                                child: new Icon(Icons.clear),
                              ),
                            ),
                            new FloatingActionButton(
                              backgroundColor: Colors.green,
                              //icon: new Icon(Icons.navigate_next),
                              onPressed: null,
                              mini: true,
                              child: new Icon(Icons.check),
                            ),
                          ],
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: new Text('Is this user?'),
                        )
                      ],
                    )
                  : new FloatingActionButton(
                      backgroundColor:
                          isNameInputed ? Colors.green : Colors.green[100],
                      //icon: new Icon(Icons.navigate_next),
                      onPressed: isNameInputed ? _gotoNext : null,
                      mini: true,
                      child: new Icon(Icons.navigate_next),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _onChanged(String inputString) {
    setState(() {
      isNameInputed = inputString.isNotEmpty;
    });
  }

  void _onSubmitted(String _) => _gotoNext();

  void _gotoNext() {
    Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => new ConfirmPage(),
          ),
        );
//    String username = _controller.text.toLowerCase();
//
//    _fetch(username).then((bool isValid) {
//      setState(() {
//        avatorUrl = 'https://avatars.githubusercontent.com/${username}';
//        isValidUser = true;
//      });
//    });
    //TODO: ユーザーが見つからない時のエラー処理
  }

  Future<bool> _fetch(String username) async {
    final http.Response response =
        await http.get('https://github.com/users/${username}/contributions');
    if (response.statusCode != 200) {
      return false;
    }
    //TODO: response.bodyを解析して、this.contributionsへ格納する
    return true;
  }
}
