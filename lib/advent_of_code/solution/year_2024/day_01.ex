defmodule AdventOfCode.Solution.Year2024.Day01 do

  def list_to_integers(input) do
    input |>
    Enum.map(fn x -> String.to_integer(x) end)
  end

  def split_newline(input) do
    input |> String.trim_trailing
    |> String.split("\n")
  end

  def count_lists(l1, l2) do
    Enum.map(l1, fn item ->
      {item, Enum.count(l2, fn x -> x == item end)}
    end)
  end

  @spec part1(binary()) :: number()
  def part1(input) do
    input |> split_newline()
    |> Enum.map(fn line -> String.split(line, "   ") end)
    |> Enum.map(fn line -> list_to_integers(line) end)
    |> Enum.zip
    |> Enum.map(fn tuple -> Tuple.to_list(tuple) end)
    |> Enum.map(fn list -> Enum.sort(list, fn a, b -> a < b end) end)
    |> Enum.zip
    |> Enum.map(fn {a,b} -> abs(a-b) end)
    |> Enum.sum
  end

  @spec part2(any()) :: nil
  def part2(input) do
    input |> split_newline()
    |> Enum.map(fn line -> String.split(line, "   ") end)
    |> Enum.map(fn line -> list_to_integers(line) end)
    |> Enum.zip
    |> Enum.map(fn tuple -> Tuple.to_list(tuple) end)
    |> (fn loc_ids -> count_lists(Enum.at(loc_ids, 0), Enum.at(loc_ids, 1)) end).()
    |> Enum.map(fn {a, b} -> a * b end)
    |> Enum.sum
  end
end
