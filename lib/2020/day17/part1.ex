defmodule Advent.Y2020.Day17.Part1 do
  @dimensions 3
  @generations 6

  def run(puzzle) do
    puzzle
    |> parse_puzzle(@dimensions)
    |> evolve(@dimensions, @generations)
    |> count_cubes()
  end

  def parse_puzzle(puzzle, 3) do
    y_dim =
      puzzle
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {row, y}, y_dim ->
        x_dim =
          row
          |> String.graphemes()
          |> Enum.with_index()
          |> Enum.reduce(%{}, fn
            {"#", x}, x_dim -> Map.put(x_dim, x, true)
            {".", x}, x_dim -> Map.put(x_dim, x, false)
          end)

        Map.put(y_dim, y, x_dim)
      end)

    %{0 => y_dim}
  end

  def parse_puzzle(puzzle, n), do: %{0 => parse_puzzle(puzzle, n - 1)}

  def evolve(grid, _, 0), do: grid

  def evolve(grid, dimension_count, n) do
    grid
    |> all_positions(dimension_count)
    |> Enum.reduce(%{}, fn pos, next_grid ->
      next_state = cube_next_state(pos, grid)
      put_in_grid(next_grid, Enum.reverse(pos), next_state)
    end)
    |> evolve(dimension_count, n - 1)
  end

  def all_positions(_grid, 0), do: [[]]

  def all_positions(grid, n) do
    {min, max} = dimension_size(grid, n - 1)

    Enum.flat_map(all_positions(grid, n - 1), fn positions ->
      for i <- (min - 1)..(max + 1), do: positions ++ [i]
    end)
  end

  def dimension_size(grid, 0) do
    keys = Map.keys(grid)
    {Enum.min(keys), Enum.max(keys)}
  end

  def dimension_size(grid, index), do: grid |> Map.get(0) |> dimension_size(index - 1)

  def put_in_grid(grid, [index], val), do: Map.put(grid, index, val)

  def put_in_grid(grid, [index | tail], val) do
    dimension = grid |> Map.get(index, %{}) |> put_in_grid(tail, val)
    Map.put(grid, index, dimension)
  end

  def cube_next_state(pos, grid) do
    case get_in(grid, pos) do
      true -> active_neighbours(grid, pos) in 2..3
      _ -> active_neighbours(grid, pos) == 3
    end
  end

  def active_neighbours(grid, position) do
    position
    |> neighbours()
    |> Enum.reject(&(&1 == position))
    |> Enum.count(&get_in(grid, &1))
  end

  def neighbours([i]), do: [[i - 1], [i], [i + 1]]
  def neighbours([i | tail]), do: for(j <- neighbours(tail), i <- (i - 1)..(i + 1), do: [i | j])

  def count_cubes(grid, acc \\ 0) do
    Enum.reduce(grid, acc, fn
      {_key, val}, acc when is_map(val) -> count_cubes(val, acc)
      {_key, true}, acc -> acc + 1
      {_key, _}, acc -> acc
    end)
  end
end
