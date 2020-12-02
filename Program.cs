using System;
using System.Linq;
using System.IO;

namespace AdventOfCode
{
    class Program
    {
        static void countDay01_01()
        {
            var nums = File.ReadLines("day01.txt").Select(n => int.Parse(n)).ToList();
            for (int i = 0; i < nums.Count(); i++)
            {
                for (int j = i + 1; j < nums.Count; j++)
                {
                    if (nums[i] + nums[j] == 2020)
                    {
                        Console.WriteLine($"{nums[i]} + {nums[j]} = 2020");
                        Console.WriteLine($"{nums[i]} * {nums[j]} = {nums[i] * nums[j]}");
                        break; 
                    }
                }
            }
        }
        static void countDay01_02()
        {
            var nums = File.ReadLines("day01.txt").Select(n => int.Parse(n)).ToList();
            for (int i = 0; i < nums.Count(); i++)
            {
                for (int j = i + 1; j < nums.Count; j++)
                {
                    for (int z = j + 1; z < nums.Count; z++)
                    {
                        if (nums[i] + nums[j] + nums[z] == 2020)
                        {
                            Console.WriteLine($"{nums[i]} + {nums[j]} + {nums[z]} = 2020");
                            Console.WriteLine($"{nums[i]} * {nums[j]} * {nums[z]} = {nums[i] * nums[j] * nums[z]}");
                            break;
                        }
                    }
                }
            }
        }

        static int countDay02_01()
        {
            return File.ReadLines("day02.txt")
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
        static int countDay02_02()
        {
            return File.ReadLines("day02.txt")
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

        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            countDay01_02();

        }
    }
}
