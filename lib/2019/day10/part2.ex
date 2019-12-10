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
    galaxy =
      puzzle
      |> Part1.asteroid_coordinates()
      |> Enum.group_by(&Part1.angle(station, &1))
      |> Enum.sort(fn {angle1, _}, {angle2, _} -> angle1 <= angle2 end)
      |> Enum.map(fn {_angle, asteroids} ->
        Enum.sort(asteroids, &(distance(station, &1) <= distance(station, &2)))
      end)

    {{x, y}, _, _} =
      0..length(galaxy)
      |> Stream.cycle()
      |> Enum.reduce_while({nil, galaxy, count - 1}, fn i, {last, galaxy, count} ->
        case Enum.at(galaxy, i) do
          [] ->
            {:cont, {last, galaxy, count}}

          [asteroid | tail] ->
            new_acc = {asteroid, List.replace_at(galaxy, i, tail), count - 1}
            if count == 0, do: {:halt, new_acc}, else: {:cont, new_acc}
        end
      end)

    x * 100 + y
  end

  def distance({x1, y1}, {x2, y2}) do
    :math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
  end
end
