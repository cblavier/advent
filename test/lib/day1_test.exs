defmodule Advent2019.Day1Test do
  use ExUnit.Case
  doctest Advent2019.Day1.Part1
  doctest Advent2019.Day1.Part2

  alias Advent2019.Day1.{Part1, Part2}

  @puzzle_path Path.expand("../fixtures/day1/puzzle.txt", __DIR__)

  test "run part1 puzzle" do
    IO.puts("Day1 / Part1")
    @puzzle_path |> Part1.run() |> IO.puts()
  end

  test "run part2 puzzle" do
    IO.puts("Day1 / Part2")
    @puzzle_path |> Part2.run() |> IO.puts()
  end
end
