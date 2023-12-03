import 'package:aoc2023/aoc2023.dart';
import 'package:test/test.dart';

void main() {
  test('Can detect part numbers adjacent to a symbol', () {
    PartNumber partNumber = PartNumber(467, Position(1, 1));
    Symbol symbol = Symbol('*', Position(4, 2));
    Symbol nonAdjacentSymbol = Symbol('%', Position(5, 2));

    expect(partNumber.isAdjacentTo(symbol), true);
    expect(!partNumber.isAdjacentTo(nonAdjacentSymbol), true);
  });

  test('Can parse part numbers', () {
    List<String> lines = ['123....#...'];
    Schematic schematic = Schematic.fromStrings(lines);

    expect(schematic.partNumbers.length, 1);
    expect(schematic.partNumbers[0].number, 123);
    expect(schematic.partNumbers[0].position.x, 1);
    expect(schematic.partNumbers[0].position.y, 1);
  });

  test('Can parse symbols', () {
    List<String> lines = ['123....#...'];
    Schematic schematic = Schematic.fromStrings(lines);

    expect(schematic.symbols.length, 1);
    expect(schematic.symbols[0].symbol, '#');
    expect(schematic.symbols[0].position.x, 8);
    expect(schematic.symbols[0].position.y, 1);
  });

  test('Solution works for test input', () {
    String testInput = r'''467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..''';

    List<String> lines = testInput.split('\n');
    Schematic schematic = Schematic.fromStrings(lines);
    expect(schematic.validPartNumberSum(), 4361);
  });

  test('It works for other inputs', () {
    String testInput = r'''124.......
...-1-2...''';

    List<String> lines = testInput.split('\n');
    Schematic schematic = Schematic.fromStrings(lines);
    expect(schematic.validPartNumberSum(), 127);
  });


  test('Can calculate gear ratio sum', () {
        String testInput = r'''467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..''';

    List<String> lines = testInput.split('\n');
    Schematic schematic = Schematic.fromStrings(lines);
    expect(schematic.gearRatioSum(), 467835);
  });
}
