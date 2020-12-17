defmodule Advent.Y2020.Day17.Part1 do
  @dimensions 3
  @generations 6

  def run(puzzle) do
    puzzle
    |> parse_puzzle(@dimensions)
    |> evolve(@dimensions, @generations)
    |> count_cubes()
  end

  def parse_puzzle(puzzle, 2) do
    for {row, y} <- puzzle |> String.split("\n") |> Enum.with_index(), into: %{} do
      {y,
       row
       |> String.graphemes()
       |> Enum.with_index()
       |> Enum.reduce(%{}, fn
         {"#", x}, x_dim -> Map.put(x_dim, x, true)
         {".", x}, x_dim -> Map.put(x_dim, x, false)
       end)}
    end
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
    keys = grid |> Map.keys() |> Enum.sort()
    {Enum.at(keys, 0), Enum.at(keys, -1)}
  end

  def dimension_size(grid, i), do: grid |> Map.get(0) |> dimension_size(i - 1)

  def put_in_grid(grid, [i], val), do: Map.put(grid, i, val)

  def put_in_grid(grid, [i | tail], val) do
    dimension = grid |> Map.get(i, %{}) |> put_in_grid(tail, val)
    Map.put(grid, i, dimension)
  end

  def cube_next_state(pos, grid) do
    case get_in(grid, pos) do
      true -> active_neighbours_count(grid, pos) in 2..3
      _ -> active_neighbours_count(grid, pos) == 3
    end
  end

  def active_neighbours_count(grid, position) do
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
