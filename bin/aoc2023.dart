import 'package:aoc2023/aoc2023.dart';
import 'dart:io';

final List<AoC2023Day> adventDays = [
  Day1(File('inputs/day1.txt')),
  Day2(File('inputs/day2.txt')),
  Day3(File('inputs/day3.txt')),
  Day4(File('inputs/day4.txt')),
  Day5(File('inputs/day5.txt')),
  Day6(File('inputs/day6.txt')),
];

void main(List<String> arguments) {
  int day = 1;
  for (AoC2023Day adventDay in adventDays) {
    print('Day$day, part 1: ${adventDay.part1()}');
    print('Day$day, part 2: ${adventDay.part2()}');
    day++;
  }
}
