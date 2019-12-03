defmodule Advent2019.Day3.Part2 do
  alias Advent2019.Day3.Part1

  def run(file_path) do
    [path1, path2] = file_path |> File.read!() |> String.split()
    min_steps_to_intersection(path1, path2)
  end

  @doc ~S"""
  ## Examples
    iex> alias Advent2019.Day3.Part2
    iex> path1 = "R8,U5,L5,D3"
    iex> path2 = "U7,R6,D4,L4"
    iex> Part2.min_steps_to_intersection(path1, path2)
    30
    iex> path1 = "R75,D30,R83,U83,L12,D49,R71,U7,L72"
    iex> path2 = "U62,R66,U55,R34,D71,R55,D58,R83"
    iex> Part2.min_steps_to_intersection(path1, path2)
    610
    iex> path1 = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51"
    iex> path2 = "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    iex> Part2.min_steps_to_intersection(path1, path2)
    410
  """
  def min_steps_to_intersection(path1, path2) do
    path1 = Part1.detailed_path(path1)
    path2 = Part1.detailed_path(path2)
    intersections = path1 -- path1 -- path2

    intersections
    |> Enum.map(fn intersection ->
      index1 = Enum.find_index(path1, &(&1 == intersection))
      index2 = Enum.find_index(path2, &(&1 == intersection))
      2 + index1 + index2
    end)
    |> Enum.min()
  end
end
