import 'dart:io';

import 'package:aoc2023/aoc2023.dart';

class Day6 extends AoC2023Day {
  List<Race> races = [];

  Day6(File file) : super(file);
  Day6.fromLines(List<String> lines) : super.fromLines(lines);

  @override
  int part1() {
    int total = 1;
    races = _parseRaces();

    for (Race r in races) {
      total *= r.waysToWin();
    }

    return total;
  }

  @override
  int part2() {
    Race race = _parsePart2Race();

    return race.waysToWin();
  }

  List<Race> _parseRaces() {
    List<Race> parsedRaces = [];
    RegExp numberRegExp = RegExp(r'[0-9]+');

    List<int> timeLimits = numberRegExp
        .allMatches(lines[0])
        .map((e) => int.parse(e.group(0)!))
        .toList();

    List<int> distances = numberRegExp
        .allMatches(lines[1])
        .map((e) => int.parse(e.group(0)!))
        .toList();

    assert(timeLimits.length == distances.length);

    for (int i = 0; i < timeLimits.length; i++) {
      parsedRaces.add(Race(timeLimits[i], distances[i]));
    }

    return parsedRaces;
  }

  Race _parsePart2Race() {
    RegExp numberRegExp = RegExp(r'[0-9]+');

    List<int> timeLimits = numberRegExp
        .allMatches(lines[0])
        .map((e) => int.parse(e.group(0)!))
        .toList();

    List<int> distances = numberRegExp
        .allMatches(lines[1])
        .map((e) => int.parse(e.group(0)!))
        .toList();

    assert(timeLimits.length == distances.length);

    int timeLimit = int.parse(timeLimits
        .map((e) => e.toString())
        .reduce((value, element) => value + element));
    int distance = int.parse(distances
        .map((e) => e.toString())
        .reduce((value, element) => value + element));

    return Race(timeLimit, distance);
  }
}

class Race {
  /// The time limit of the race, in milliseconds.
  int timeLimit;

  /// The longest distance travelled by a participant in millimeters.
  int longestDistance;

  Race(this.timeLimit, this.longestDistance);

  int waysToWin() {
    int total = 0;

    for (int timeWithButtonPressed = 0;
        timeWithButtonPressed < timeLimit;
        timeWithButtonPressed++) {
      int timeWithoutButtonPressed = timeLimit - timeWithButtonPressed;
      int distanceTravelled = timeWithButtonPressed * timeWithoutButtonPressed;

      if (distanceTravelled > longestDistance) {
        total++;
      }
    }

    return total;
  }
}
