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
    |> String.split("\n")
  end

  def list_to_integers(input) do
    input |> Enum.map(fn x -> String.to_integer(x) end)
  end

end


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

  def part1(input) do
    input |> to_int_list
    |> solve
    |> Enum.count(fn x -> x == true end)
  end

  def part2(input) do
  end

  def to_int_list(input) do
    input
    |> Mod.split_newline
    |> Enum.map(fn x -> String.split(x, " ") end)
    |> Enum.map(fn x -> Mod.list_to_integers(x) end)
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

day2_input = Mod.read_file("day2input.txt")
Mod.print_output("d2p1 test", Day2.part1(d2_test))
Mod.print_output("d2p1 answer", Day2.part1(day2_input))
Mod.print_output("d2p2 test", Day2.part2(d2_test))
Mod.print_output("d2p2 answer", Day2.part2(day2_input))


day3_test_input = "xmul(3,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
day3_test_input_part2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
defmodule Day3 do

  def part1(input) do
    input
    |> (&Regex.scan(~r/mul\((\d+),(\d+)\)/, &1)).()
    |> Enum.map(fn x -> Enum.take(x, -2) end)
    |> Mod.list_to_integers
    #|> Enum.map(fn [a, b] -> a * b end)
    #|> Enum.sum
  end

  def part2(input) do
    String.split(input, ~r/do/)
    |> Enum.filter(fn x -> !String.starts_with?(x, "n't") end)
    |> Enum.map(fn x -> part1(x) end)
    |> Enum.sum
  end

end

#day3_input = Mod.read_file("day3input.txt")
#Mod.print_output("d3p1 test", Day3.part1(day3_test_input))
# Mod.print_output("d3p1 answer", Day3.part1(day3_input))
# Mod.print_output("d3p2 test", Day3.part2(day3_test_input_part2))
# Mod.print_output("d3p2 answer", Day3.part2(day3_input))


# IO.puts("Day 4")

# day4_test_input = """
# MMMSXXMASM
# MSAMXMSMSA
# AMXSXMAAMM
# MSAMASMSMX
# XMASAMXAMM
# XXAMMXXAMA
# SMSMSASXSS
# SAXAMASAAA
# MAMMMXMMMM
# MXMXAXMASX
# """

# defmodule Day4 do
#   def part1 (input) do
#     input
#     |> Mod.split_newline
#   end
# end
