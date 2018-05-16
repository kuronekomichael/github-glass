import 'package:scoped_model/scoped_model.dart';

class Contribution {
  final int year;
  final int month;
  final int day;
  final int value;

  Contribution({this.year, this.month, this.day, this.value});

  @override
  String toString() => '$year-$month-$day: $value';
}

class GitHubUser extends Model {
  String username;
  List<Contribution> contributions = [];

  final RegExp dateRegex = new RegExp('^(\\d+)[-_/](\\d+)[-_/](\\d+)\$');

  void update() {
    //TODO: GitHubAPIから取り直す予定
    notifyListeners();
  }

  void setIdentity(String newUsername, Map<String, int> newContributions) {
    username = newUsername;

    // Clear all
    contributions.clear();

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

    notifyListeners();
  }
}
