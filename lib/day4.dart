import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:aoc2023/day.dart';

class Day4 extends AoC2023Day {
  HashSet<int> winners = HashSet<int>();
  HashSet<int> numbers = HashSet<int>();

  Day4(input) : super(input);
  Day4.fromLines(List<String> inputLines) : super.fromLines(inputLines);

  @override
  int part1() {
    int total = 0;
    for (var (winners, numbers) in lines.map(parseScratchPad)) {
      // calculate amount of winning numbers
      int winningNumbers = winners.intersection(numbers).length;
      // calculate points
      int points = pow(2, (winningNumbers - 1)).toInt();
      total += points;
    }
    return total;
  }

  @override
  int part2() {
    int numberOfGames = lines.length;
    Map<int, int> scratchpads = {
      for (var game = 1; game <= numberOfGames; game++) game: 1
    };
    int currentGame = 1;

    for (var (winners, numbers) in lines.map(parseScratchPad)) {
      if (currentGame > numberOfGames) {
        break;
      }
      // calculate amount of winning numbers
      int winningNumbers = winners.intersection(numbers).length;
      // add copies
      for (int j = 1; j <= (scratchpads[currentGame] ?? 0); j++) {
        for (int i = 1; i <= winningNumbers; i++) {
          if (scratchpads[currentGame + i] != null) {
            scratchpads[currentGame + i] = scratchpads[currentGame + i]! + 1;
          } else {
            scratchpads[currentGame + i] = 2;
          }
        }
      }

      currentGame++;
    }

    return scratchpads.values.reduce((a, b) => a + b);
  }
}

(Set<int>, Set<int>) parseScratchPad(String line) {
  List<String> scratchedNumbers = line.split(':')[1].split('|');
  Set<int> winners = scratchedNumbers[0]
      .split(' ')
      .where((s) => s.isNotEmpty)
      .map(int.parse)
      .toSet();

  Set<int> numbers = scratchedNumbers[1]
      .split(' ')
      .where((s) => s.isNotEmpty)
      .map(int.parse)
      .toSet();

  return (winners, numbers);
}
