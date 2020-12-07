using System.IO;
using System.Linq;

namespace AdventOfCode.Examples
{
    public static class Day02
    {
        public static int Example01()
        {
            return File.ReadLines("Data/day02.txt")
                .Where(line =>
                {
                    var parts = line.Split(' ');
                    var rule = parts[0].Split('-');
                    var min = int.Parse(rule[0]);
                    var max = int.Parse(rule[1]);
                    var character = parts[1].First();
                    var password = parts[2];

                    var count = password.Count(c => c == character);
                    return count >= min && count <= max;
                })
                .Count();
        }
        public static int Example02()
        {
            return File.ReadLines("Data/day02.txt")
                .Where(line =>
                {
                    var parts = line.Split(' ');
                    var rule = parts[0].Split('-');
                    var pos1 = int.Parse(rule[0]) - 1;
                    var pos2 = int.Parse(rule[1]) - 1;
                    var character = parts[1].First();
                    var password = parts[2];

                    return new[]
                    {
                        password[pos1],
                        password[pos2]
                    }
                    .Where(c => c == character)
                    .Count() == 1;
                })
                .Count();
        }
    }
}
