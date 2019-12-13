defmodule Advent.Y2019.Day12.Part1 do
  @doc ~S"""
  iex> alias Advent.Y2019.Day12.Part1
  iex> puzzle = ""
  iex> puzzle = puzzle <> "<x=-1, y=0, z=2>\n"
  iex> puzzle = puzzle <> "<x=2, y=-10, z=-7>\n"
  iex> puzzle = puzzle <> "<x=4, y=-8, z=8>\n"
  iex> puzzle = puzzle <> "<x=3, y=5, z=-1>"
  iex> Part1.run(puzzle, 1)
  {[
    {{2, -1, 1}, {3, -1, -1}},
    {{3, -7, -4}, {1, 3, 3}},
    {{1, -7, 5}, {-3, 1, -3}},
    {{2, 2, 0 }, {-1, -3, 1}}
  ], 229}
  iex> Part1.run(puzzle, 10)
  {[
   {{2, 1, -3}, { -3, -2, 1}},
   {{1, -8, 0 }, { -1, 1, 3}},
   {{3, -6, 1 }, { 3, 2, -3}},
   {{2, 0, 4 }, { 1, -1, -1}}
  ], 179}
  """
  def run(puzzle, steps) do
    planets = puzzle |> String.split("\n") |> Enum.map(&parse_planet/1)

    planets =
      1..steps
      |> Enum.reduce(planets, fn _i, planets ->
        planets
        |> update_velocity(0..2)
        |> apply_movement(0..2)
      end)

    {planets, compute_energy(planets)}
  end

  def update_velocity(planets, axes) do
    Enum.map(planets, fn p1 ->
      Enum.reduce(planets, p1, fn {pos2, _}, p1 ->
        Enum.reduce(axes, p1, fn axis, {pos1, velocity} ->
          accel =
            cond do
              elem(pos1, axis) < elem(pos2, axis) -> 1
              elem(pos1, axis) > elem(pos2, axis) -> -1
              true -> 0
            end

          {pos1, put_elem(velocity, axis, elem(velocity, axis) + accel)}
        end)
      end)
    end)
  end

  def apply_movement(planets, axes) do
    Enum.map(planets, fn planet ->
      Enum.reduce(axes, planet, fn axis, {pos, velocity} ->
        new_pos = put_elem(pos, axis, elem(pos, axis) + elem(velocity, axis))
        {new_pos, velocity}
      end)
    end)
  end

  def compute_energy(planets) do
    planets
    |> Enum.map(fn {{x, y, z}, {vel_x, vel_y, vel_z}} ->
      (abs(x) + abs(y) + abs(z)) * (abs(vel_x) + abs(vel_y) + abs(vel_z))
    end)
    |> Enum.sum()
  end

  def parse_planet(planet) do
    regex = ~r/<x=(?<x>[-\d]*), *y=(?<y>[-\d]*), *z=(?<z>[-\d]*)>/
    %{"x" => x, "y" => y, "z" => z} = Regex.named_captures(regex, planet)

    {
      {String.to_integer(x), String.to_integer(y), String.to_integer(z)},
      {0, 0, 0}
    }
  end
end
