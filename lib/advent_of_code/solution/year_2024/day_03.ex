defmodule AdventOfCode.Solution.Year2024.Day03 do

  def part1(input) do
    Regex.scan(~r/mul\((\d+),(\d+)\)/, input)
    |> Enum.map(fn x -> Enum.take(x, -2) end)
    |> Enum.reduce(0, fn [a, b], acc -> acc + String.to_integer(a) * String.to_integer(b) end)
  end

  def part2(input) do
    input |> String.split(~r/do/)
    |> Enum.filter(fn x -> !String.starts_with?(x, "n't") end)
    |> Enum.map(fn x -> part1(x) end)
    |> Enum.sum
  end
end
