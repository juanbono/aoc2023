import 'dart:io';

import 'package:aoc2023/day.dart';
import 'dart:collection';
import 'dart:math';

enum Color { red, green, blue }

final HashMap<Color, int> cubesInBag = HashMap.from({
  Color.red: 12,
  Color.green: 13,
  Color.blue: 14,
});

class Day2 extends AoC2023Day {
  Day2(File inputFile) : super(inputFile);

  @override
  int part1() {
    int currentGame = 1;
    int total = 0;
    for (String line in lines) {
      Game game = Game.fromString(currentGame, line);
      if (game.isPossible(cubesInBag)) {
        total += currentGame;
      }
      currentGame++;
    }

    return total;
  }

  @override
  int part2() {
    int total = 0;
    int currentGame = 1;
    for (String line in lines) {
      Game game = Game.fromString(currentGame, line);
      CubeSet minCubeSet = game.minAmountOfCubes();
      total += minCubeSet.power();
      currentGame++;
    }

    return total;
  }
}

class CubeSet {
  HashMap<Color, int> cubes = HashMap();
  static RegExp colorRegExp = RegExp(r'([0-9]+) (green|red|blue)');

  CubeSet(this.cubes);

  static CubeSet fromString(String cubeSetString) {
    HashMap<Color, int> phaseCubes = HashMap.from({
      Color.red: 0,
      Color.green: 0,
      Color.blue: 0,
    });

    List<String> cubes = cubeSetString.split(',');

    for (String cubeString in cubes) {
      int parsedAmount =
          int.parse(colorRegExp.firstMatch(cubeString)!.group(1)!);
      String parsedColor = colorRegExp.firstMatch(cubeString)!.group(2)!;
      Color? color = switch (parsedColor) {
        'red' => Color.red,
        'green' => Color.green,
        'blue' => Color.blue,
        _ => null,
      };

      if (color == null) {
        throw Exception('Invalid color: $parsedColor');
      }

      phaseCubes[color] = phaseCubes[color]! + parsedAmount;
    }

    return CubeSet(phaseCubes);
  }

  bool isPossible(HashMap<Color, int> maxAmountOfCubes) {
    for (Color color in Color.values) {
      if (cubes[color]! > maxAmountOfCubes[color]!) {
        return false;
      }
    }

    return true;
  }

  /// The power of a set of cubes is equal to the numbers of red, green,
  /// and blue cubes multiplied together.
  int power() {
    return cubes.values.reduce((c1, c2) => c1 * c2);
  }
}

class Game {
  int id;
  List<CubeSet> cubeSets = [];

  Game(this.id, this.cubeSets);

  static Game fromString(int id, String line) {
    List<CubeSet> phases = [];
    // remove the game number and keep the part with the game phases.
    String gamePhases = line.split(':').skip(1).first;

    List<String> phaseStrings = gamePhases.split(';');

    for (String phaseString in phaseStrings) {
      phases.add(CubeSet.fromString(phaseString));
    }

    return Game(id, phases);
  }

  bool isPossible(HashMap<Color, int> maxAmountOfCubes) {
    return cubeSets.every((p) => p.isPossible(maxAmountOfCubes));
  }

  CubeSet minAmountOfCubes() {
    HashMap<Color, int> minCubes = HashMap.from({
      Color.red: cubeSets.map((cs) => cs.cubes[Color.red]!).reduce(max),
      Color.green: cubeSets.map((cs) => cs.cubes[Color.green]!).reduce(max),
      Color.blue: cubeSets.map((cs) => cs.cubes[Color.blue]!).reduce(max),
    });
    return CubeSet(minCubes);
  }
}

HashMap<Color, int> parseGame(String line) {
  HashMap<Color, int> currentGameCubes = HashMap.from({
    Color.red: 0,
    Color.green: 0,
    Color.blue: 0,
  });

  RegExp colorRegExp = RegExp(r'([0-9]+) (green|red|blue)');

  // remove the game number and keep the part with the game phases.
  String gamePhases = line.split(':').skip(1).first;

  List<String> phases = gamePhases.split(';');

  for (String phase in phases) {
    List<String> cubes = phase.split(',');

    for (String cube in cubes) {
      int parsedAmount = int.parse(colorRegExp.firstMatch(cube)!.group(1)!);
      print(parsedAmount);
      String parsedColor = colorRegExp.firstMatch(cube)!.group(2)!;
      Color? color = switch (parsedColor) {
        'red' => Color.red,
        'green' => Color.green,
        'blue' => Color.blue,
        _ => null,
      };

      if (color == null) {
        throw Exception('Invalid color: $parsedColor');
      }

      currentGameCubes[color] = currentGameCubes[color]! + parsedAmount;
    }
  }

  return currentGameCubes;
}

bool isPossible(HashMap<Color, int> currentGameCubes,
    HashMap<Color, int> totalAmountOfCubes) {
  for (Color color in Color.values) {
    if (currentGameCubes[color]! > totalAmountOfCubes[color]!) {
      return false;
    }
  }

  return true;
}
