using System;
using System.IO;
using System.Linq;

namespace AdventOfCode.Examples
{
    public static class Day05
    {
        private const int rows = 128;
        private const int columns = 8;

        public static void Example()
        {
            var boardingPasses = File.ReadAllLines("Data/day05.txt")
                .Select(line =>
                {
                    var row = line.Substring(0, 7).Pipe(AsIndex);
                    var col = line.Substring(7, 3).Pipe(AsIndex);
                    var id = row * columns + col;
                    return new { Id = id, Row = row, Col = col, Input = line };
                })
                .OrderBy(p => p.Id)
                .ToList();

            // Example 01
            var highestId = boardingPasses.Max(b => b.Id);
            Console.WriteLine($"Highest Id: {highestId}");

            // Example 02
            var missing = boardingPasses.Slide()
                .Where(pair => Math.Abs(pair.A.Id - pair.B.Id) != 1)
                .Select(pair => pair.A.Id + 1)
                .First();
            Console.WriteLine($"Missing seat id: {missing}");
        }

        // Solve Binary:
        private static int AsIndex(string seq)
        {
            string binary = seq
                .Replace('F', '0').Replace('L', '0')
                .Replace('B', '1').Replace('R', '1');
            return Convert.ToInt32(binary, 2);
        }

        // My first attempt:
        private static int GetIndex(string seq, int from, int to)
        {
            var range = (to - from) / 2;
            return (seq.FirstOrDefault()) switch
            {
                'F' or 'L' => GetIndex(seq.Substring(1), from, to - range - 1),
                'B' or 'R' => GetIndex(seq.Substring(1), from + range + 1, to),
                _ => from,
            };
        }
    }
}
