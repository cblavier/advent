defmodule Advent.Y2019.Day10.Part1 do
  @doc ~S"""
    iex> alias Advent.Y2019.Day10.Part1
    iex> puzzle = ".#..#\n.....\n#####\n....#\n...##"
    iex> Part1.run(puzzle)
    {{3, 4}, 8}
  """
  def run(puzzle) do
    asteroids = asteroid_coordinates(puzzle)

    for a1 <- asteroids do
      count =
        for(a2 <- asteroids, a1 != a2, do: angle(a1, a2))
        |> Enum.uniq()
        |> Enum.count()

      {a1, count}
    end
    |> Enum.max_by(&elem(&1, 1))
  end

  @doc ~S"""
    iex> alias Advent.Y2019.Day10.Part1
    iex> puzzle = ".#.#\n..#."
    iex> Part1.asteroid_coordinates(puzzle)
    [{1,0},{3,0},{2,1}]
  """
  def asteroid_coordinates(puzzle) do
    puzzle
    |> String.split()
    |> Enum.with_index()
    |> Enum.reduce([], fn {row, y}, acc ->
      row
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn
        {"#", x}, acc -> acc ++ [{x, y}]
        _, acc -> acc
      end)
    end)
  end

  def angle({x1, y1}, {x2, y2}) do
    deg = :math.atan2(x2 - x1, y1 - y2) * 180 / :math.pi()
    if deg < 0, do: 360 + deg, else: deg
  end
end
