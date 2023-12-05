import 'dart:io';

abstract class AoC2023Day {
  late final File inputFile;
  late final List<String> lines;

  AoC2023Day(this.inputFile) {
    lines = inputFile.readAsLinesSync();
  }

  /// This constructor must be used for testing purposes only.
  AoC2023Day.fromLines(List<String> inputLines) {
    inputFile = File('');
    lines = inputLines;
  }

  int part1();
  int part2();
}
