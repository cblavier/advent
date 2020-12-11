defmodule Advent.Y2020.Day11.Part1 do
  def run(puzzle) do
    puzzle = String.split(puzzle, "\n")

    puzzle
    |> build_grid()
    |> with_dimensions(puzzle)
    |> evolve()
    |> count_occupied()
  end

  def build_grid(puzzle) do
    for {row, y} <- Enum.with_index(puzzle),
        {seat, x} <- row |> String.graphemes() |> Enum.with_index(),
        into: %{},
        do: {{x, y}, seat}
  end

  def with_dimensions(grid, puzzle) do
    rows = length(puzzle)
    cols = puzzle |> hd() |> String.length()
    {grid, rows, cols}
  end

  def evolve({grid, rows, cols}) do
    all_positions = for x <- 0..(cols - 1), y <- 0..(rows - 1), do: {x, y}

    Stream.cycle([0])
    |> Enum.reduce_while(grid, fn _, grid ->
      changes =
        Enum.reduce(all_positions, [], fn {x, y}, changes ->
          cond do
            should_turn_occupied?(grid, x, y) -> [{x, y, "#"} | changes]
            should_turn_free?(grid, x, y) -> [{x, y, "L"} | changes]
            true -> changes
          end
        end)

      if Enum.empty?(changes) do
        {:halt, grid}
      else
        {:cont, apply_changes(grid, changes)}
      end
    end)
  end

  def should_turn_occupied?(grid, x, y) do
    if Map.get(grid, {x, y}) == "L" do
      Enum.all?(adjacents(x, y), fn {x, y} ->
        Map.get(grid, {x, y}) != "#"
      end)
    else
      false
    end
  end

  def should_turn_free?(grid, x, y) do
    if Map.get(grid, {x, y}) == "#" do
      Enum.count(adjacents(x, y), fn {x, y} ->
        Map.get(grid, {x, y}) == "#"
      end) >= 4
    else
      false
    end
  end

  def adjacents(x, y) do
    [
      {x + 1, y},
      {x + 1, y - 1},
      {x + 1, y + 1},
      {x, y + 1},
      {x, y - 1},
      {x - 1, y},
      {x - 1, y - 1},
      {x - 1, y + 1}
    ]
  end

  def apply_changes(grid, changes) do
    Enum.reduce(changes, grid, fn {x, y, new_val}, grid ->
      Map.put(grid, {x, y}, new_val)
    end)
  end

  def count_occupied(grid) do
    grid |> Enum.filter(fn {_, seat} -> seat == "#" end) |> length()
  end
end
