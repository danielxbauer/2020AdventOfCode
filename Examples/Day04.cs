using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AdventOfCode.Examples
{
    public static class Extension
    {
        public static bool ContainsAll<T>(this IEnumerable<T> list, IEnumerable<T> values)
        {
            foreach (var value in values)
            {
                if (!list.Contains(value))
                {
                    return false;
                }
            }

            return true;
        }
    }

    public static class Day04
    {
        private static Dictionary<string, string> ToPassport(string value)
        {
            return value
                .Split(" ")
                .Select(prop => prop.Split(":"))
                .ToDictionary(key => key[0], value => value[1]);
        }

        public static void Example01()
        {
            var passports = File.ReadAllText("Data/day04.txt")
                .Split(Environment.NewLine + Environment.NewLine)
                .Select(str => str.Replace(Environment.NewLine, " "))
                .Select(ToPassport)
                .ToList();

            var requiredFields = new[] { "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" };
            var validPassports = passports
                .Where(p => p.Keys.ContainsAll(requiredFields))
                .Count();

            Console.WriteLine(validPassports);
        }
    }
}
