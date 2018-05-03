import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_grass/api/github.dart';

void main() {
  test('GitHub user not found', () async {
    bool isValid = await GitHubApi.isValidUser('this-is-not-valid-username');
    expect(isValid, false);
  });

  test('GitHub user found', () async {
    bool isValid = await GitHubApi.isValidUser('kuronekomichael');
    expect(isValid, true);
  });

  test('Read contribution SVG file', () async {
    final file = new File('test_resources/contributions.svg');
    final text = await file.readAsString();

    expect(text.isNotEmpty, true);

    Map<String, int> contributions = GitHubApi.getContributionsFromSVG(text);

    expect(contributions.containsKey('2017-04-30'), true);
    expect(contributions.containsKey('2017-4-30'), false);
    expect(contributions.containsKey('2017-06-29'), true);
    expect(contributions.containsKey('2017-12-25'), true);
    expect(contributions.containsKey('2018-05-03'), true);

    expect(contributions['2017-04-30'], 2);
    expect(contributions['2017-06-29'], 2);
    expect(contributions['2017-12-25'], 0);
    expect(contributions['2018-05-03'], 5);
  });

  test('Get contributions', () async {
    Map<String, int> contributions =
        await GitHubApi.getContributions('kuronekomichael');
    expect(contributions.isNotEmpty, true);
  });
}
