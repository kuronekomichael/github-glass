import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_grass/api/github.dart';
import 'package:github_grass/models/user.dart';
import 'package:github_grass/pages/export.dart';
import 'package:scoped_model/scoped_model.dart';

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<GitHubUser>(
      builder: (context, child, model) => new _InnerInputPage(user: model),
    );
  }
}

class _InnerInputPage extends StatefulWidget {
  final GitHubUser user;

  _InnerInputPage({this.user});

  @override
  _InputPageState createState() => new _InputPageState(user: user);
}

class _InputPageState extends State<_InnerInputPage> {
  final GitHubUser user;
  bool isNameInputed = false;
  bool isInvalidUser = false;
  bool isLoading = false;

  _InputPageState({this.user});

  final TextEditingController _controller =
      new TextEditingController(text: 'kuronekomichael');

  static const iconWidth = 80.0;

  String _flavor = '(unknown)';

  @override
  void initState() {
    super.initState();

    const MethodChannel('flavor').invokeMethod('getFlavor').then(
      (Object flavor) {
        setState(() {
          _flavor = flavor;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    isNameInputed = _controller.text.isNotEmpty;

    bool isButtonEnable = false;
    IconData buttonIcon = Icons.arrow_downward;
    if (isLoading) {
      isButtonEnable = false;
      buttonIcon = Icons.refresh;
    } else if (isNameInputed && !isInvalidUser) {
      isButtonEnable = true;
      buttonIcon = Icons.arrow_downward;
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_flavor),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
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
              child: new FloatingActionButton(
                backgroundColor:
                    isButtonEnable ? Colors.green : Colors.green[100],
                //icon: new Icon(Icons.navigate_next),
                onPressed: isButtonEnable ? _submitName : null,
                mini: true,
                child: new Icon(buttonIcon),
              ),
            ),
            isInvalidUser
                ? new Text(
                    'Not found',
                    style: new TextStyle(
                      color: Colors.red,
                    ),
                  )
                : new Text(''),
          ],
        ),
      ),
    );
  }

  void _onChanged(String inputString) {
    setState(() {
      isNameInputed = inputString.isNotEmpty;
      if (isNameInputed && isInvalidUser) {
        isInvalidUser = false;
      }
    });
  }

  void _onSubmitted(String _) => _submitName();

  void _submitName() {
    String username = _controller.text.toLowerCase();

    setState(() {
      isLoading = true;
      isInvalidUser = false;
    });

    GitHubApi.isValidUser(username).then((bool isValidUser) {
      if (!isValidUser) {
        setState(() {
          isLoading = false;
          isInvalidUser = true;
        });
        return;
      }

      GitHubApi
          .getContributions(username)
          .then((Map<String, int> contributions) {
        user.setIdentity(username, contributions);
        setState(() {
          isLoading = false;
          isInvalidUser = false;
        });
        _goNext(username);
      });
    });
  }

  void _goNext(username) {
    Navigator.push(
      context,
      new PageRouteBuilder(
          opaque: false,
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) =>
                  new FadeTransition(
                    opacity: animation,
                    child: new RotationTransition(
                      turns: new Tween<double>(
                        begin: 0.5,
                        end: 1.0,
                      ).animate(
                        animation,
                      ),
                      child: child,
                    ),
                  ),
          pageBuilder: (BuildContext context, _, __) => new Center(
                child: new ConfirmPage(username: username),
              )),
    );
  }
}
