import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
// avator icon url = https://avatars.githubusercontent.com/<username>
//ex. https://avatars.githubusercontent.com/kuronekomichael

// contribution data(json) = https://github.com/users/<username>/contributions
//ex. https://github.com/users/kuronekomichael/contributions

class Contribution {
  final int year;
  final int month;
  final int day;
  final int value;

  Contribution({this.year, this.month, this.day, this.value});
}

class GitHubUser extends Model {
  final String username;
  Image image;
  bool isValid = false;
  List<Contribution> contributions = List<Contribution>();

  GitHubUser({this.username}) {
    image = new Image.network(
      'https://avatars.githubusercontent.com/${username}',
    );
    _fetch().then((bool isValid) {
      isValid = true;
      notifyListeners();
    });
  }

  Future<bool> _fetch() async {
    final http.Response response =
        await http.get('https://github.com/users/${username}/contributions');
    if (response.statusCode != 200) {
      return false;
    }
    //TODO: response.bodyを解析して、this.contributionsへ格納する
    return true;
  }
}
