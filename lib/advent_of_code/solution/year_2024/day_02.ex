defmodule AdventOfCode.Solution.Year2024.Day02 do
  def part1(input) do
    input |> to_int_list |> solve |> Enum.count(fn x -> x == true end)
  end

  def part2(input) do
   input |> to_int_list |> solve_sublists
  end
end
