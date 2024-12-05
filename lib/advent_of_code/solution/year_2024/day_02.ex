defmodule AdventOfCode.Solution.Year2024.Day02 do
  def part1(input) do
    input |> to_int_list |> solve |> Enum.count(fn x -> x == true end)
  end

  def part2(input) do
   input |> to_int_list |> solve_sublists
  end

  def split_newline(input) do
    input |> String.trim_trailing
    |> String.split("\n")
  end

  def to_int_list(input) do
    input
    |> split_newline
    |> Enum.map(fn x -> String.split(x, " ") end)
    |> Enum.map(fn x -> list_to_integers(x) end)
  end

  def list_to_integers(input) do
    input |> Enum.map(fn x -> String.to_integer(x) end)
  end

  def solve_sublists(input) do
    Enum.map(input, fn x ->
      [x | Enum.map(0..(length(x) - 1), fn i -> List.delete_at(x, i) end)]
    end)
    |> Enum.map(fn x -> solve(x) end)
    |> Enum.count(fn x -> Enum.any?(x, fn y -> y == true end) end)

  end

  def solve(input) do
    Enum.map(input, fn x ->
      Enum.zip_with(x, tl(x), fn a, b -> test([a, b]) end)
    end)
    |> Enum.map(fn x -> get_failures(x) end)

  end

  def test(val) do
    [a, b] = val
    cond do
      a > b && a - b <= 3 -> :dec
      a < b && b - a <= 3 -> :inc
      true -> :wrong
    end
  end

  def get_failures(input) do
    inc = Enum.all?(input, fn x -> x == :inc end)
    dec = Enum.all?(input, fn x -> x == :dec end)
    inc || dec
  end
end
