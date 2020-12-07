using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace AdventOfCode
{
    public static class Extensions
    {
        public static TOut Pipe<TIn, TOut>(this TIn @in, Func<TIn, TOut> func)
            => func(@in);

        public static IEnumerable<(T A, T B)> Slide<T>(this IEnumerable<T> items)
            => items.Zip(items.Skip(1), (a, b) => (A: a, B: b));

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

        public static string WithoutPrefix(this string value, string prefix)
            => value.EndsWith(prefix) ? value.Substring(0, value.Length - prefix.Length) : value;

        public static bool Between(this string str, int min, int max)
        {
            return int.TryParse(str, out int result)
                ? result >= min && result <= max
                : false;
        }

        public static bool Matches(this string str, string regex)
            => new Regex(regex).IsMatch(str);
    }
}
