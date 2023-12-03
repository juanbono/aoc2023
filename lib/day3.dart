import 'package:aoc2023/aoc2023.dart';
import 'dart:io';

class Day3 extends AoC2023Day {
  Day3(File inputFile) : super(inputFile);

  @override
  int part1() {
    Schematic schematic = Schematic.fromStrings(lines);

    return schematic.validPartNumberSum();
  }

  @override
  int part2() {
    Schematic schematic = Schematic.fromStrings(lines);

    return schematic.gearRatioSum();
  }
}

class Schematic {
  RegExp partNumberRegExp = RegExp(r'([0-9]+)');
  RegExp symbolRegExp = RegExp(r'[#\-%+*$@/=&]');
  List<PartNumber> partNumbers = [];
  List<Symbol> symbols = [];

  Schematic.fromStrings(List<String> lines) {
    int lineNumber = 1;
    for (String line in lines) {
      partNumbers.addAll(_parsePartNumbers(lineNumber, line));
      symbols.addAll(_parseSymbols(lineNumber, line));
      lineNumber++;
    }
  }

  List<PartNumber> _parsePartNumbers(int lineNumber, String line) {
    List<PartNumber> parts = [];
    Iterable<RegExpMatch> matches = partNumberRegExp.allMatches(line);

    for (RegExpMatch match in matches) {
      int number = int.parse(match.group(0)!);
      Position position = Position(match.start + 1, lineNumber);
      parts.add(PartNumber(number, position));
    }

    return parts;
  }

  List<Symbol> _parseSymbols(int lineNumber, String line) {
    List<Symbol> parsedSymbols = [];
    Iterable<RegExpMatch> matches = symbolRegExp.allMatches(line);

    for (RegExpMatch match in matches) {
      String symbol = match.group(0)!;
      Position position = Position(match.start + 1, lineNumber);
      parsedSymbols.add(Symbol(symbol, position));
    }

    return parsedSymbols;
  }

  int validPartNumberSum() {
    List<PartNumber> parts = [];

    for (PartNumber partNumber in partNumbers) {
      if (symbols.any((s) => partNumber.isAdjacentTo(s))) {
        parts.add(partNumber);
      }
    }

    return parts.fold(0, (sum, part) => sum + part.number);
  }

  int gearRatioSum() {
    int total = 0;
    for (Symbol symbol in symbols) {
      if (symbol.symbol == '*') {
        List<PartNumber> adjacentParts = [];

        for (PartNumber partNumber in partNumbers) {
          if (partNumber.isAdjacentTo(symbol)) {
            adjacentParts.add(partNumber);
          }
        }

        if (adjacentParts.length == 2) {
          total += adjacentParts.first.number * adjacentParts.last.number;
        }
      }
    }

    return total;
  }
}

class PartNumber {
  int number;
  Position position;

  PartNumber(this.number, this.position);

  bool isAdjacentTo(Symbol symbol) {
    // the position of the symbol in the y-axis should be the same, -1 or +1.
    bool checkY = position.y - 1 <= symbol.position.y &&
        symbol.position.y <= position.y + 1;
    // the position of the symbol in the x-axis should be in the range:
    // x - 1 <= symbol.position.x <= x + len(self) + 1
    bool checkX = position.x - 1 <= symbol.position.x &&
        symbol.position.x <= position.x + number.toString().length;
    return checkY && checkX;
  }
}

class Symbol {
  String symbol;
  Position position;

  Symbol(this.symbol, this.position);
}

class Position {
  int x;
  int y;

  Position(this.x, this.y);
}
