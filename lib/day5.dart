import 'package:aoc2023/day.dart';
import 'dart:io';

class Day5 extends AoC2023Day {
  Day5(File inputFile) : super(inputFile);
  Day5.fromLines(List<String> inputLines) : super.fromLines(inputLines);

  @override
  int part1() {
    Almanac almanac = Almanac.fromLines(lines);
    assert(almanac.maps.length == 7);
    int minimumSeed = 1000000000000000;

    for (int seed in almanac.seeds) {
      int location = almanac.getLocationForSeed(seed);
      if (location < minimumSeed) {
        minimumSeed = location;
      }
    }

    return minimumSeed;
  }

  @override
  int part2() {
    Almanac almanac = Almanac.fromLines(lines);
    assert(almanac.maps.length == 7);
    List<int> extendedSeeds = [];
    extendedSeeds.addAll([
      for (int i = 0; i < almanac.seeds[0] + almanac.seeds[1]; i++)
        almanac.seeds[0] + i
    ]);
    extendedSeeds.addAll([
      for (int i = 0; i < almanac.seeds[2] + almanac.seeds[3]; i++)
        almanac.seeds[2] + i
    ]);
    int minimumSeed = 1000000000000000;

    for (int seed in almanac.seeds) {
      int location = almanac.getLocationForSeed(seed);
      if (location < minimumSeed) {
        minimumSeed = location;
      }
    }

    return minimumSeed;
  }
}

class Almanac {
  List<int> seeds = [];
  List<AlmanacMap> maps = [];

  Almanac.fromLines(List<String> lines) {
    List<String> firstLine =
        lines.first.split(':')[1].trim().split(' ').toList();
    seeds = firstLine.map(int.parse).toList();
    List<List<String>> mapsLinesAccum = [];
    List<String> currentMapLines = [];

    for (String line in lines.skip(2)) {
      if (line.isEmpty) {
        mapsLinesAccum.add(currentMapLines);
        currentMapLines = [];
      } else {
        currentMapLines.add(line);
      }
    }

    mapsLinesAccum.add(currentMapLines);

    for (List<String> mapLines in mapsLinesAccum) {
      maps.add(AlmanacMap.fromLines(mapLines));
    }
  }

  int getLocationForSeed(int seed) {
    int value = seed;

    for (var map in maps) {
      print('From: ${map.from}');
      print('To: ${map.to}');
    }

    AlmanacMap seedToSoil =
        maps.firstWhere((element) => element.from == "seed");
    value = seedToSoil.getValue(value);
    AlmanacMap soilToFertilizer =
        maps.firstWhere((element) => element.from == "soil");
    value = soilToFertilizer.getValue(value);
    AlmanacMap fertilizerToWater =
        maps.firstWhere((element) => element.from == "fertilizer");
    value = fertilizerToWater.getValue(value);
    AlmanacMap waterToLight =
        maps.firstWhere((element) => element.from == "water");
    value = waterToLight.getValue(value);
    AlmanacMap lightToTemperature =
        maps.firstWhere((element) => element.from == "light");
    value = lightToTemperature.getValue(value);
    AlmanacMap temperatureToHumidity =
        maps.firstWhere((element) => element.from == "temperature");
    value = temperatureToHumidity.getValue(value);
    AlmanacMap humidityToLocation =
        maps.firstWhere((element) => element.from == "humidity");
    value = humidityToLocation.getValue(value);

    return value;
  }
}

class AlmanacMap {
  late String from;
  late String to;
  List<Entry> entries = [];

  AlmanacMap(this.entries);

  AlmanacMap.fromLines(List<String> lines) {
    List<String> fromTo = lines.first.split(' ').first.split('-').toList();
    from = fromTo.first;
    to = fromTo.last;

    // skip the first line.
    for (int i = 1; i < lines.length; i++) {
      entries.add(Entry.fromString(lines[i]));
    }
  }

  int getValue(int sourceValue) {
    for (Entry entry in entries) {
      if (sourceValue >= entry.sourceRangeStart &&
          sourceValue < entry.sourceRangeStart + entry.rangeLength) {
        return entry.destinationRangeStart +
            (sourceValue - entry.sourceRangeStart);
      }
    }

    // if it was not found in the map, return the source value.
    return sourceValue;
  }
}

class Entry {
  int destinationRangeStart = 0;
  int sourceRangeStart = 0;
  int rangeLength = 0;

  Entry(this.destinationRangeStart, this.sourceRangeStart, this.rangeLength);

  Entry.fromString(String string) {
    List<int> numbers = string.split(' ').map(int.parse).toList();

    assert(numbers.length == 3, "Entry must have 3 numbers");

    destinationRangeStart = numbers[0];
    sourceRangeStart = numbers[1];
    rangeLength = numbers[2];
  }
}
