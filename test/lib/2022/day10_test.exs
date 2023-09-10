defmodule Advent.Y2022.Day10Test do
  use ExUnit.Case
  alias Advent.Y2022.Day10.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2022, 10)

  test "run part1 puzzle" do
    assert Part1.run(@puzzle) == 17_380
  end

  test "run part2 puzzle" do
    assert Part2.run(@puzzle) == [
             "####..##...##..#..#.####.###..####..##..",
             "#....#..#.#..#.#..#....#.#..#.#....#..#.",
             "###..#....#....#..#...#..#..#.###..#....",
             "#....#.##.#....#..#..#...###..#....#....",
             "#....#..#.#..#.#..#.#....#.#..#....#..#.",
             "#.....###..##...##..####.#..#.####..##.."
           ]
  end
end
