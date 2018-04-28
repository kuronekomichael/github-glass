import 'package:flutter/material.dart';
import 'package:github_grass/pages/export.dart';
import 'package:github_grass/theme.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => new MaterialApp(
        theme: grassTheme,
        home: new MyHomePage(),
      );
}
