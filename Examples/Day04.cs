using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace AdventOfCode.Examples
{
    public static class Day04
    {
        private static Dictionary<string, string> ToPassport(string value)
        {
            return value
                .Split(" ", StringSplitOptions.RemoveEmptyEntries)
                .Select(prop => prop.Split(":", StringSplitOptions.RemoveEmptyEntries))
                .ToDictionary(key => key[0], value => value[1]);
        }

        private static IEnumerable<Dictionary<string, string>> GetPassports()
        {
            return File.ReadAllText("Data/day04.txt")
                .Split(Environment.NewLine + Environment.NewLine)
                .Select(str => str.Replace(Environment.NewLine, " "))
                .Select(ToPassport)
                .ToList();
        }

        public static void Example01()
        {
            var passports = GetPassports();
            var requiredFields = new[] { "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" };
            var validPassports = passports
                .Where(p => p.Keys.ContainsAll(requiredFields))
                .Count();

            Console.WriteLine(validPassports);
        }

        private static bool IsHeight(string value)
        {
            if (value.EndsWith("cm")) return value.WithoutPrefix("cm").Between(150, 193);
            if (value.EndsWith("in")) return value.WithoutPrefix("in").Between(59, 76);
            return false;
        }

        private static bool ValidateRule(Dictionary<string, string> values, Dictionary<string, Func<string, bool>> rules)
        {
            foreach (var value in values)
            {
                var rule = rules.GetValueOrDefault(value.Key, null);
                if (rule != null && !rule(value.Value))
                {
                    return false;
                }
            }

            return true;
        }

        public static void Example02()
        {
            var requiredFields = new[] { "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" };
            var rules = new Dictionary<string, Func<string, bool>>
            {
                { "byr", value => value.Between(1920, 2002) },
                { "iyr", value => value.Between(2010, 2020) },
                { "eyr", value => value.Between(2020, 2030) },
                { "hgt", value => IsHeight(value) },
                { "hcl", value => value.Matches("#[a-f0-9]{6}") },
                { "ecl", value => new[] { "amb", "blu", "brn", "gry", "grn", "hzl", "oth" }.Contains(value) },
                { "pid", value => value.Length == 9 && value.Matches("[0-9]{9}") }
            };

            var validPassports = GetPassports()
                .Where(p => p.Keys.ContainsAll(requiredFields))
                .Where(values => ValidateRule(values, rules))
                .ToList();

            Console.WriteLine(validPassports.Count);
        }
    }
}
