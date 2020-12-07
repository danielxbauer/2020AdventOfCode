using System;
using System.IO;
using System.Linq;

namespace AdventOfCode.Examples
{
    public static class Day01
    {
        public static void Example01()
        {
            var nums = File.ReadLines("Data/day01.txt").Select(n => int.Parse(n)).ToList();
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
        public static void Example02()
        {
            var nums = File.ReadLines("Data/day01.txt").Select(n => int.Parse(n)).ToList();
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
    }
}
