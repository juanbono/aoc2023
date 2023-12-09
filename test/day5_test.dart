import 'package:aoc2023/day5.dart';
import 'package:test/test.dart';

void main() {
  List<String> testInput = r'''seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4'''
      .split('\n')
      .toList();

  test('Can parse an Entry', () {
    Entry entry = Entry.fromString('1 2 3');
    expect(entry.destinationRangeStart, 1);
    expect(entry.sourceRangeStart, 2);
    expect(entry.rangeLength, 3);
  });

  test('Can parse an AlmanacMap', () {
    List<String> testInput = r'''seed-to-soil map
50 98 2
52 50 48'''
        .split('\n')
        .toList();

    AlmanacMap almanacMap = AlmanacMap.fromLines(testInput);
    AlmanacMap expectedAlmanac = AlmanacMap([
      Entry(50, 98, 2),
      Entry(52, 50, 48),
    ]);
    expectedAlmanac.from = 'seed';
    expectedAlmanac.to = 'soil';

    expect(almanacMap.from, expectedAlmanac.from);
    expect(almanacMap.to, expectedAlmanac.to);
    expect(almanacMap.entries.length, expectedAlmanac.entries.length);
  });

  test('Can parse an Almanac', () {

    Almanac almanac = Almanac.fromLines(testInput);
    expect(almanac.seeds.length, 4);
    expect(almanac.maps.length, 7);
  });

  test('Can get source values from an Almanac map', () {
    List<String> testInput = r'''seed-to-soil map
50 98 2
52 50 48'''
        .split('\n')
        .toList();

    AlmanacMap almanacMap = AlmanacMap.fromLines(testInput);

    expect(almanacMap.getValue(98), 50);
    expect(almanacMap.getValue(99), 51);
    expect(almanacMap.getValue(53), 55);
    expect(almanacMap.getValue(10), 10);
  });

  test('Can get location for seed', () {
    Almanac almanac = Almanac.fromLines(testInput);

    expect(almanac.getLocationForSeed(79), 82);
    expect(almanac.getLocationForSeed(14), 43);
    expect(almanac.getLocationForSeed(55), 86);
    expect(almanac.getLocationForSeed(13), 35);
  });

  test('Part 1 example input works', () {
    Day5 day5 = Day5.fromLines(testInput);
    expect(day5.part1(), 35);
  });
}
