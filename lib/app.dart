import 'package:flutter/material.dart';
import 'package:github_grass/models/user.dart';
import 'package:github_grass/pages/export.dart';
import 'package:github_grass/theme.dart';
import 'package:scoped_model/scoped_model.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => new ScopedModel<GitHubUser>(
        model: new GitHubUser(),
        child: new MaterialApp(
          theme: grassTheme,
          home: new InputPage(),
        ),
      );
}
