import 'package:aoc2023/day6.dart';
import 'package:test/test.dart';

void main() {
  test('Can solve simple case', () {
    List<String> testInput = r'''Time: 7
Distance: 9'''
        .split('\n')
        .toList();
    Day6 day6 = Day6.fromLines(testInput);
    expect(day6.part1(), 4);
  });

  test('Can solve example input', () {
    List<String> testInput = r'''Time:      7  15   30
Distance:  9  40  200'''
        .split('\n')
        .toList();

    Day6 day6 = Day6.fromLines(testInput);
    expect(day6.part1(), 288);
  });
}
