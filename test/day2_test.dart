import 'dart:collection';

import 'package:aoc2023/aoc2023.dart';
import 'package:test/test.dart';

void main() {
  test('can parse a game', () {
    String inputLine = 'Game 1: 1 green, 4 blue; 1 blue, 2 green, 1 red; 1 red, 1 green, 2 blue; 1 green, 1 red; 1 green; 1 green, 1 blue, 1 red';
    HashMap<Color, int> expected = HashMap.from({
      Color.red: 4,
      Color.green: 7,
      Color.blue: 8,
    });

    expect(parseGame(inputLine), expected);
  });

  test('can check if a game is possible', () {
    HashMap<Color, int> game = HashMap.from({
      Color.red: 4,
      Color.green: 7,
      Color.blue: 8,
    });

    expect(isPossible(game, cubesInBag), true);
  });
}
