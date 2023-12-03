import 'dart:io';

abstract class AoC2023Day {
  File inputFile;
  late final List<String> lines;
  
  AoC2023Day(this.inputFile) {
    lines = inputFile.readAsLinesSync();
  }

  int part1();
  int part2();
}
