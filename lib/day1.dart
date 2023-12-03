import 'package:aoc2023/day.dart';
import 'dart:io';

class Day1 extends AoC2023Day {
  RegExp regexp =
      RegExp(r'1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine');
  Day1(File inputFile) : super(inputFile);

  @override
  int part1() {
    int total = 0;
    for (String line in lines) {
      List<int> numbersFromLine = getIntsFromString(line);
      int number = int.parse(
          numbersFromLine.first.toString() + numbersFromLine.last.toString());
      total += number;
    }

    return total;
  }

  @override
  int part2() {
    int total = 0;

    for (String line in lines) {
      int firstMatchPosition = line.indexOf(regexp);
      String firstMatch =
          regexp.matchAsPrefix(line, firstMatchPosition)![0] as String;
      int lastMatchPosition = line.lastIndexOf(regexp);
      String lastMatch =
          regexp.matchAsPrefix(line, lastMatchPosition)![0] as String;

      int number =
          int.parse(replaceNumber(firstMatch) + replaceNumber(lastMatch));

      total += number;
    }

    return total;
  }
}

String replaceNumber(String number) {
  return switch (number) {
    'one' => '1',
    'two' => '2',
    'three' => '3',
    'four' => '4',
    'five' => '5',
    'six' => '6',
    'seven' => '7',
    'eight' => '8',
    'nine' => '9',
    _ => number
  };
}

List<int> getIntsFromString(String string) {
  return string.runes
      .where((r) => r >= 48 && r <= 57)
      .map((r) => r - 48)
      .toList();
}
