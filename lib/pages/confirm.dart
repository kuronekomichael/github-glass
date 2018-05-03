import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_grass/pages/export.dart';

@immutable
class ConfirmPage extends StatefulWidget {
  final String username;

  const ConfirmPage({this.username});

  @override
  _ConfirmPageState createState() => new _ConfirmPageState(username);
}

class _ConfirmPageState extends State<ConfirmPage> {
  final String username;
  final String avatarUrl;
  bool isValidUser = true; //FIXME: 未実装

  _ConfirmPageState(this.username)
      : avatarUrl = 'https://avatars.githubusercontent.com/${username}';

  static const iconWidth = 80.0; //TODO: Themeに移動する

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.username),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.network(
                avatarUrl,
                width: iconWidth,
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: new Text(
                  'It\'s you?',
                  style: new TextStyle(
                    fontSize: 28.0,
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: new Text(widget.username),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new FloatingActionButton(
                  backgroundColor:
                      isValidUser ? Colors.green : Colors.green[100],
                  //icon: new Icon(Icons.navigate_next),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new MyHomePage()),
                        (_) => false);
                  },
                  mini: true,
                  child: new Icon(Icons.check),
                ),
              )
            ],
          ),
        ),
      );
}
