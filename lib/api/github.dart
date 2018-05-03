import 'dart:async';

import 'package:http/http.dart' as http;

// avator icon url = https://avatars.githubusercontent.com/<username>
//ex. https://avatars.githubusercontent.com/kuronekomichael

// contribution data(json) = https://github.com/users/<username>/contributions
//ex. https://github.com/users/kuronekomichael/contributions

class GitHubApi {
  /// 有効なGitHubユーザーかどうかを返却する
  static Future<bool> isValidUser(String username) async {
    final http.Response response =
        await http.get('https://github.com/users/${username}/contributions');
    if (response.statusCode != 200) {
      return false;
    }
    //TODO: response.bodyを解析して、this.contributionsへ格納する
    return true;
  }

  static final RegExp lineRegex = new RegExp('\n');
  static final RegExp dateRegex = new RegExp('data-date="([^"]+)"');
  static final RegExp countRegex = new RegExp('data-count="([^"]+)"');

  static Map<String, int> getContributionsFromSVG(String text) => text
          .split(lineRegex)
          .where(
            (String line) =>
                dateRegex.hasMatch(line) && countRegex.hasMatch(line),
          )
          .fold(<String, int>{}, (Map<String, int> ret, String line) {
        String date = dateRegex.firstMatch(line).group(1);
        int count = int.parse(countRegex.firstMatch(line).group(1));
        ret[date] = count;
        return ret;
      });

  static Future<Map<String, int>> getContributions(String username) async {
    final http.Response response =
        await http.get('https://github.com/users/${username}/contributions');
    if (response.statusCode != 200) {
      return {};
    }
    return getContributionsFromSVG(response.body);
  }
}
