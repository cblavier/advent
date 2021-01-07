defmodule Advent.Y2015.Day18.Part2 do
  alias Advent.Y2015.Day18.Part1

  def run(puzzle) do
    puzzle = String.split(puzzle, "\n")

    puzzle
    |> Part1.build_grid()
    |> Part1.with_dimensions(puzzle)
    |> Part1.evolve(&apply_changes/2, 100)
    |> Part1.count_lights_on()
  end

  def apply_changes(changes, {grid, rows, cols}) do
    {
      for {x, y, val} <- changes,
          {x, y} not in [{0, 0}, {0, rows - 1}, {cols - 1, 0}, {cols - 1, rows - 1}],
          reduce: grid do
        grid -> Map.put(grid, {x, y}, val)
      end,
      rows,
      cols
    }
  end
end
