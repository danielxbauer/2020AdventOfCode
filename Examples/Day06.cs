using System;
using System.IO;
using System.Linq;

namespace AdventOfCode.Examples
{
    public static class Day06
    {

        public static void Example01()
        {
            var questions = File.ReadAllText("Data/day06.txt")
                .Split(Environment.NewLine + Environment.NewLine)
                .Select(g => g
                    .Replace(Environment.NewLine, string.Empty)
                    .ToHashSet())
                .Sum(g => g.Count);

            Console.WriteLine(questions);
        }

        public static void Example02()
        {
            var questions = File.ReadAllText("Data/day06.txt")
               .Split(Environment.NewLine + Environment.NewLine)
               .Select(g => g.Split(Environment.NewLine))
               .Select(g => g.Skip(1)
                    .Aggregate(
                        g.First().ToList(),
                        (h, e) => h.Intersect(e.ToList()).ToList()))
               .Sum(c => c.Count);

            Console.WriteLine(questions);
        }
    }
}
