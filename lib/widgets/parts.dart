import 'package:flutter/material.dart';

class MyFlipButton extends StatefulWidget {
  final String aText;
  final String bText;
  final VoidCallback onPressed;

  const MyFlipButton({this.aText, this.bText, this.onPressed});

  @override
  _FlipButtonState createState() => new _FlipButtonState();
}

class _FlipButtonState extends State<MyFlipButton> {
  bool isReversed = false;

  _FlipButtonState();

  @override
  Widget build(BuildContext context) => new FlatButton(
      color: isReversed ? Colors.blue : Colors.green,
      padding: EdgeInsets.all(10.0),
      onPressed: _onPressed,
      child: new Text(isReversed ? widget.bText : widget.aText));

  void _onPressed() {
    setState(() {
      isReversed = !isReversed;
    });
    widget.onPressed();
  }
}
