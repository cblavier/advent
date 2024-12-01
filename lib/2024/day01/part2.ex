defmodule Advent.Y2024.Day01.Part2 do
  alias Advent.Y2024.Day01.Part1

  def run(puzzle) do
    {l1, l2} = Part1.parse(puzzle)
    l2_frequencies = Enum.frequencies(l2)

    Enum.reduce(l1, 0, fn n, acc ->
      acc + n * Map.get(l2_frequencies, n, 0)
    end)
  end
end
