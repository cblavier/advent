defmodule Advent.Y2019.Day3.Part1 do
  def run(file_path) do
    [path1, path2] = file_path |> File.read!() |> String.split()
    distance_to_closest_intersection(path1, path2)
  end

  @doc ~S"""
  ## Examples
    iex> alias Advent.Y2019.Day3.Part1
    iex> path1 = "R75,D30,R83,U83,L12,D49,R71,U7,L72"
    iex> path2 = "U62,R66,U55,R34,D71,R55,D58,R83"
    iex> Part1.distance_to_closest_intersection(path1, path2)
    159
    iex> path1 = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51"
    iex> path2 = "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    iex> Part1.distance_to_closest_intersection(path1, path2)
    135
  """
  def distance_to_closest_intersection(path1, path2) do
    path1 = detailed_path(path1)
    path2 = detailed_path(path2)
    intersections = path1 -- path1 -- path2

    intersections
    |> Enum.map(&manhattan_distance/1)
    |> Enum.min()
  end

  @doc ~S"""
  ## Examples
    iex> Advent.Y2019.Day3.Part1.detailed_path("R2,U2,L1")
    [{1, 0}, {2, 0}, {2, 1}, {2, 2}, {1, 2}]
  """
  def detailed_path(path) when is_binary(path) do
    path
    |> String.split(",")
    |> Enum.map(fn <<direction::utf8, distance::binary>> ->
      {<<direction>>, String.to_integer(distance)}
    end)
    |> detailed_path()
  end

  def detailed_path(path) when is_list(path) do
    path
    |> Enum.reduce([{0, 0}], fn
      {"R", distance}, acc -> inc_pos(acc, distance, 0)
      {"L", distance}, acc -> inc_pos(acc, -distance, 0)
      {"U", distance}, acc -> inc_pos(acc, 0, distance)
      {"D", distance}, acc -> inc_pos(acc, 0, -distance)
    end)
    |> List.delete_at(-1)
    |> Enum.reverse()
  end

  @doc ~S"""
  ## Examples
    iex> Advent.Y2019.Day3.Part1.inc_pos([{0, 0}], 3, 0)
    [{3, 0}, {2, 0}, {1, 0}, {0, 0}]
    iex> Advent.Y2019.Day3.Part1.inc_pos([{0, 0}], 0, 3)
    [{0, 3}, {0, 2}, {0, 1}, {0, 0}]
  """
  def inc_pos(path = [{x, y} | _], dist_x, 0) do
    Enum.reduce(1..abs(dist_x), path, fn i, path ->
      [if(dist_x > 0, do: {x + i, y}, else: {x - i, y})] ++ path
    end)
  end

  def inc_pos(path = [{x, y} | _], 0, dist_y) do
    Enum.reduce(1..abs(dist_y), path, fn i, path ->
      [if(dist_y > 0, do: {x, y + i}, else: {x, y - i})] ++ path
    end)
  end

  defp manhattan_distance({x, y}), do: abs(x) + abs(y)
end
