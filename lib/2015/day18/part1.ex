defmodule Advent.Y2015.Day18.Part1 do
  def run(puzzle) do
    puzzle = String.split(puzzle, "\n")

    puzzle
    |> build_grid()
    |> with_dimensions(puzzle)
    |> evolve(&apply_changes/2, 100)
    |> count_lights_on()
  end

  def build_grid(puzzle) do
    for {row, y} <- Enum.with_index(puzzle),
        {light, x} <- row |> String.graphemes() |> Enum.with_index(),
        into: %{},
        do: {{x, y}, light}
  end

  def with_dimensions(grid, puzzle) do
    rows = length(puzzle)
    cols = puzzle |> hd() |> String.length()
    {grid, rows, cols}
  end

  def evolve({grid, _rows, _cols}, _, 0), do: grid

  def evolve({grid, rows, cols}, apply_changes_fn, rounds) do
    for x <- 0..(cols - 1), y <- 0..(rows - 1), reduce: [] do
      changes ->
        cond do
          !should_stay_on?(grid, {x, y}) -> [{x, y, "."} | changes]
          should_turn_on?(grid, {x, y}) -> [{x, y, "#"} | changes]
          true -> changes
        end
    end
    |> apply_changes_fn.({grid, rows, cols})
    |> evolve(apply_changes_fn, rounds - 1)
  end

  def adjacents(grid, {x, y}) do
    for {x, y} <- [
          {x + 1, y},
          {x + 1, y - 1},
          {x + 1, y + 1},
          {x, y + 1},
          {x, y - 1},
          {x - 1, y},
          {x - 1, y - 1},
          {x - 1, y + 1}
        ],
        into: [],
        do: Map.get(grid, {x, y})
  end

  def should_turn_on?(grid, pos) do
    case Map.get(grid, pos) do
      "." -> grid |> adjacents(pos) |> Enum.count(&(&1 == "#")) == 3
      "#" -> false
    end
  end

  def should_stay_on?(grid, pos) do
    case Map.get(grid, pos) do
      "." -> true
      "#" -> (grid |> adjacents(pos) |> Enum.count(&(&1 == "#"))) in 2..3
    end
  end

  def apply_changes(changes, {grid, rows, cols}) do
    {
      for {x, y, val} <- changes, reduce: grid do
        grid -> Map.put(grid, {x, y}, val)
      end,
      rows,
      cols
    }
  end

  def count_lights_on(grid) do
    grid |> Enum.filter(&(elem(&1, 1) == "#")) |> length()
  end
end
