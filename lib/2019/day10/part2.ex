defmodule Advent.Y2019.Day10.Part2 do
  alias Advent.Y2019.Day10.Part1

  @doc ~S"""
  iex> alias Advent.Y2019.Day10.Part2
  iex> puzzle = ""
  iex> puzzle = puzzle <> ".#....#####...#..\n"
  iex> puzzle = puzzle <> "##...##.#####..##\n"
  iex> puzzle = puzzle <> "##...#...#.#####.\n"
  iex> puzzle = puzzle <> "..#.....X...###..\n"
  iex> puzzle = puzzle <> "..#.#.....#....##\n"
  iex> Part2.run(puzzle, {8, 3}, 1)
  801
  iex> Part2.run(puzzle, {8, 3}, 2)
  900
  """
  def run(puzzle, station, count) do
    asteroids =
      puzzle
      |> Part1.asteroid_coordinates()
      |> Enum.group_by(&Part1.angle(station, &1))
      |> Enum.map(fn {angle, asteroids} ->
        {angle, Enum.sort(asteroids, &(distance(station, &1) <= distance(station, &2)))}
      end)
      |> Enum.into(%{})

    {_, {x, y}, _} =
      asteroids
      |> Map.keys()
      |> Enum.sort()
      |> Stream.cycle()
      |> Enum.reduce_while({asteroids, nil, count}, fn angle, {asteroids, last, count} ->
        case Map.get(asteroids, angle) do
          [] ->
            {:cont, {asteroids, last, count}}

          [asteroid | tail] ->
            asteroids = Map.put(asteroids, angle, tail)
            new_acc = {asteroids, asteroid, count - 1}
            if count == 1, do: {:halt, new_acc}, else: {:cont, new_acc}
        end
      end)

    x * 100 + y
  end

  def distance({x1, y1}, {x2, y2}) do
    :math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
  end
end
