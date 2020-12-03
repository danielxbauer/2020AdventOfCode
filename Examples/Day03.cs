using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

        public static void Example01()
        {
            var start = new Coord(0, 0);
            var down = new Coord(1, 3);

            var lines = File.ReadAllLines("Data/day03.txt").ToList();

            var points = new List<Coord> { start };
            foreach (var line in lines.Skip(1))
            {
                var last = points.Last();
                points.Add((last + down) % line.Length);
            }

            var treesEncountered = points
                .Select(p => lines[p.Row][p.Col])
                .Where(p => p == Tree)
                .Count();

            Console.WriteLine(treesEncountered);
        }
    }
}
