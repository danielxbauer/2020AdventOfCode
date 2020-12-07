using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace AdventOfCode.Examples
{
    public static class Day03
    {
        private const char Tree = '#';

        private record Coord(int Row, int Col)
        {
            public static Coord operator +(Coord a, Coord b)
                => new Coord(a.Row + b.Row, a.Col + b.Col);

            public static Coord operator %(Coord coord, int value)
                => new Coord(coord.Row, coord.Col % value);
        }

        private static IEnumerable<Coord> Traverse(IEnumerable<string> area, Coord down)
        {
            var slope = new List<Coord> { new Coord(0, 0) };
            int length = area.First().Length;
            for (var last = slope.Last(); (last + down).Row < area.Count();)
            {
                last = (last + down) % length;
                slope.Add(last);
            }

            return slope;
        }

        private static uint TreesEncountered(List<string> area, IEnumerable<Coord> slope)
        {
            return (uint)slope
                .Select(p => area[p.Row][p.Col])
                .Where(p => p == Tree)
                .Count();
        }

        public static void Example01()
        {
            var area = File.ReadAllLines("Data/day03.txt").ToList();

            var slope = Traverse(area, new Coord(1, 3));
            var treesEncountered = TreesEncountered(area, slope);

            Console.WriteLine(treesEncountered);
        }

        public static void Example02()
        {
            var area = File.ReadAllLines("Data/day03.txt").ToList();

            var slope11 = TreesEncountered(area, Traverse(area, new Coord(1, 1)));
            var slope13 = TreesEncountered(area, Traverse(area, new Coord(1, 3)));
            var slope15 = TreesEncountered(area, Traverse(area, new Coord(1, 5)));
            var slope17 = TreesEncountered(area, Traverse(area, new Coord(1, 7)));
            var slope21 = TreesEncountered(area, Traverse(area, new Coord(2, 1)));

            var result = slope11 * slope13 * slope15 * slope17 * slope21;
            Console.WriteLine(result);
        }
    }
}
