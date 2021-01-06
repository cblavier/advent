defmodule Advent.Y2015.Day17.Part2 do
  alias Advent.Y2015.Day17.Part1
  @target 150

  def run(puzzle) do
    puzzle
    |> Part1.buckets()
    |> Part1.combinations_for_target(@target)
    |> Enum.min_by(&length/1)
    |> length()
  end
end
