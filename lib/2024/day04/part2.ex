defmodule Advent.Y2024.Day04.Part2 do
  alias Advent.Y2024.Day04.Part1

  def run(puzzle) do
    grid = Part1.parse(puzzle)
    a_positions = Part1.find_char(grid, "A")
    Enum.count(a_positions, &xmas?(grid, &1))
  end

  def xmas?(grid, {x, y}) do
    grid
    |> Part1.multiple_get([{x - 1, y - 1}, {x + 1, y - 1}, {x + 1, y + 1}, {x - 1, y + 1}])
    |> Kernel.in(["MMSS", "MSSM", "MSSM", "SSMM", "SMMS"])
  end
end
