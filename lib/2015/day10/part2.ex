defmodule Advent.Y2015.Day10.Part2 do
  alias Advent.Y2015.Day10.Part1

  def run(puzzle) do
    puzzle |> Part1.look_and_say(50) |> length()
  end
end
