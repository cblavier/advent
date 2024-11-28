defmodule Advent.Y2017.Day09Test do
  use ExUnit.Case
  alias Advent.Y2017.Day09.{Part1, Part2}

  @puzzle Advent.Puzzle.load(2017, 09)

  test "run part1 puzzle" do
    assert Part1.run("{}") == 1
    assert Part1.run("{{{}}}") == 6
    assert Part1.run("{{},{}}") == 5
    assert Part1.run("{{{},{},{{}}}}") == 16
    assert Part1.run("{<a>,<a>,<a>,<a>}") == 1
    assert Part1.run("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 9
    assert Part1.run("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 9
    assert Part1.run("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 3
    assert Part1.run(@puzzle) == 20530
  end

  test "run part2 puzzle" do
    assert Part2.run("<>") == 0
    assert Part2.run("<random characters>") == 17
    assert Part2.run("<random characters>") == 17
    assert Part2.run("<<<<>") == 3
    assert Part2.run("<{!>}>") == 2
    assert Part2.run("<!!>") == 0
    assert Part2.run("<!!!>>") == 0
    assert Part2.run(~s|<{o"i!a,<{i<a>|) == 10
    assert Part2.run(@puzzle) == 9978
  end
end
