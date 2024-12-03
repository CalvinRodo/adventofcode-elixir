defmodule Mod do

  def print_output(name, input) do
   IO.puts("#{name}")
   IO.inspect(input)
  end

  def read_file(name) do
    case File.read(name) do
      {:ok, contents} -> contents
      {:error, reason} -> IO.inspect(reason)
    end
  end

  def count_lists(l1, l2) do
    Enum.map(l1, fn item ->
      {item, Enum.count(l2, fn x -> x == item end)}
    end)
  end

  def split_newline(input) do
    input |> String.trim_trailing
    |> (&String.split(&1, "\n")).()
  end

  def list_to_integers(input) do
    input |> Enum.map(fn x -> String.to_integer(x) end)
  end

end


IO.puts("Day 1")

defmodule Day1 do

  def part1(input) do
    input |> Mod.split_newline()
    |> (&Enum.map(&1, fn line -> String.split(line, "   ") end)).()
    |> (&Enum.map(&1, fn line -> Mod.list_to_integers(line) end)).()
    |> Enum.zip
    |> (&Enum.map(&1, fn tuple -> Tuple.to_list(tuple) end)).()
    |> (&Enum.map(&1, fn list -> Enum.sort(list, fn a, b -> a < b end) end)).()
    |> Enum.zip
    |> (&Enum.map(&1, fn {a,b} -> abs(a-b) end)).()
    |> Enum.sum
  end

  def part2(input) do
    input |> Mod.split_newline()
    |> (&Enum.map(&1, fn line -> String.split(line, "   ") end)).()
    |> (&Enum.map(&1, fn line -> Mod.list_to_integers(line) end)).()
    |> Enum.zip
    |> (&Enum.map(&1, fn tuple -> Tuple.to_list(tuple) end)).()
    |> (fn loc_ids -> Mod.count_lists(Enum.at(loc_ids, 0), Enum.at(loc_ids, 1)) end).()
    |> (&Enum.map(&1, fn {a, b} -> a * b end)).()
    |> Enum.sum
  end
end

day1_test_input = """
3   4
4   3
2   5
1   3
3   9
3   3
"""

d1p1_test = Day1.part1(day1_test_input)
Mod.print_output("d1p1 test", d1p1_test)

day1_input = Mod.read_file("day1input.txt")

Mod.print_output("d1p1 answer", Day1.part1(day1_input))

d1p2_test = Day1.part2(day1_test_input)
Mod.print_output("d1p2 test", d1p2_test)

Mod.print_output("d1p2 answer", Day1.part2(day1_input))


IO.puts("Day 2")

d2_test = """
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"""

defmodule Day2 do

  def part_1 (input) do
    input |> Mod.split_newline()
    |> (&Enum.map(&1, fn line -> String.split(line, " ") end)).()
    |> (&Enum.map(&1, fn line -> Mod.list_to_integers(line) end)).()
    |> check_part1
  end

  def check_part1 (input) do
    IO.inspect(input)
    exlusive_checkers = [
      fn x ->
        Enum.reduce(x, {:infinity, true}, fn elem, {old_val, test} -> {elem, ((old_val > elem) && test)} end)
        |> elem(1)
      end,
      fn x ->
        Enum.reduce(x, {0, true}, fn elem, {old_val, test} -> {elem, ((old_val < elem) && test)} end)
        |> elem(1)
      end,
    ]
    inclusive_checkers = [
      fn x -> Enum.any?(exlusive_checkers, fn check -> check.(x) end) end
    ]

    Enum.map(input, fn list ->
      Enum.all?(inclusive_checkers, fn check -> check.(list) end)
    end)
  end
end

d2p1_test = Day2.part_1(d2_test)
Mod.print_output("d2p1 test", d2p1_test)
