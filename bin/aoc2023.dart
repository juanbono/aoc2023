import 'package:aoc2023/aoc2023.dart';
import 'dart:io';

final List<AoC2023Day> adventDays = [
  Day1(File('inputs/day1.txt')),
  Day2(File('inputs/day2.txt')),
  Day3(File('inputs/day3.txt')),
];

void main(List<String> arguments) {
  for (AoC2023Day adventDay in adventDays) {
    print('Part 1: ${adventDay.part1()}');
    print('Part 2: ${adventDay.part2()}');
  }
}
