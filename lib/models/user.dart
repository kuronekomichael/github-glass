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

  @override
  String toString() => '${year}-${month}-${day}: ${value}';
}

class GitHubUser extends Model {
  String username;
  //Image image;
  List<Contribution> contributions = <Contribution>[];

  final RegExp dateRegex = new RegExp('^(\\d+)[-_/](\\d+)[-_/](\\d+)\$');

  void update() {
    //TODO: GitHubAPIから取り直す予定
    notifyListeners();
  }

  void setIdentity(String newUsername, Map<String, int> newContributions) {
    username = newUsername;
//    image = new Image.network(
//      'https://avatars.githubusercontent.com/${username}',
//    );

    // all clear
    contributions.clear();

    // re-set
    newContributions.forEach((String date, int value) {
      Match matched = dateRegex.firstMatch(date);
      if (matched == null) {
        throw new Exception('Error on setting to contibutions');
      }
      Contribution contribution = new Contribution(
        year: int.parse(matched.group(1)),
        month: int.parse(matched.group(2)),
        day: int.parse(matched.group(3)),
        value: value,
      );
      contributions.add(contribution);
    });

//    contributions.sort((c1, c2) {
//      var r = c2.year.compareTo(c1.year);
//      if (r != 0) return r;
//      r = c2.month.compareTo(c1.month);
//      if (r != 0) return r;
//      return c2.day.compareTo(c1.day);
//    });

    notifyListeners();
  }
}
