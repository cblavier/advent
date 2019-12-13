defmodule Advent.Y2019.Day12.Part1 do
  defmodule Planet do
    defstruct [:id, :x, :y, :z, vel_x: 0, vel_y: 0, vel_z: 0]
  end

  @doc ~S"""
  iex> alias Advent.Y2019.Day12.Part1
  iex> puzzle = ""
  iex> puzzle = puzzle <> "<x=-1, y=0, z=2>\n"
  iex> puzzle = puzzle <> "<x=2, y=-10, z=-7>\n"
  iex> puzzle = puzzle <> "<x=4, y=-8, z=8>\n"
  iex> puzzle = puzzle <> "<x=3, y=5, z=-1>"
  iex> Part1.run(puzzle, 1)
  {%{
    0 => %Advent.Y2019.Day12.Part1.Planet{id: 0, x: 2, y: -1, z: 1,  vel_x: 3,  vel_y: -1, vel_z: -1},
    1 => %Advent.Y2019.Day12.Part1.Planet{id: 1, x: 3, y: -7, z: -4, vel_x: 1,  vel_y: 3,  vel_z: 3},
    2 => %Advent.Y2019.Day12.Part1.Planet{id: 2, x: 1, y: -7, z: 5,  vel_x: -3, vel_y: 1,  vel_z: -3},
    3 => %Advent.Y2019.Day12.Part1.Planet{id: 3, x: 2, y: 2,  z: 0,  vel_x: -1, vel_y: -3, vel_z: 1}
  }, 229}
  iex> Part1.run(puzzle, 10)
  {%{
    0 => %Advent.Y2019.Day12.Part1.Planet{id: 0, x: 2, y: 1,  z: -3, vel_x: -3,  vel_y: -2, vel_z: 1},
    1 => %Advent.Y2019.Day12.Part1.Planet{id: 1, x: 1, y: -8, z: 0,  vel_x: -1, vel_y: 1, vel_z: 3},
    2 => %Advent.Y2019.Day12.Part1.Planet{id: 2, x: 3, y: -6, z: 1,  vel_x: 3,  vel_y: 2, vel_z: -3},
    3 => %Advent.Y2019.Day12.Part1.Planet{id: 3, x: 2, y: 0,  z: 4,  vel_x: 1, vel_y: -1, vel_z: -1}
  }, 179}
  """
  def run(puzzle, steps) do
    planets = planet_map(puzzle)

    planets =
      1..steps
      |> Enum.reduce(planets, fn _i, planets ->
        planets
        |> update_velocity([:x, :y, :z])
        |> apply_movement([:x, :y, :z])
      end)

    {planets, compute_energy(planets)}
  end

  def planet_map(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.map(&parse_planet/1)
    |> Enum.reduce(%{}, fn planet, acc ->
      Map.put(acc, planet.id, planet)
    end)
  end

  def update_velocity(planets, axes) do
    combinations =
      for p1 <- Map.values(planets),
          p2 <- Map.values(planets),
          p1 != p2,
          do: {p1, p2}

    Enum.reduce(combinations, planets, fn {p1, p2}, planets ->
      Enum.reduce(axes, planets, fn axis, planets ->
        accel =
          cond do
            get_in(p1, [Access.key(axis)]) < get_in(p2, [Access.key(axis)]) -> 1
            get_in(p1, [Access.key(axis)]) > get_in(p2, [Access.key(axis)]) -> -1
            true -> 0
          end

        vel_attr = String.to_atom("vel_#{axis}")

        Map.update!(planets, p1.id, fn planet ->
          Map.update!(planet, vel_attr, &(&1 + accel))
        end)
      end)
    end)
  end

  def apply_movement(planets, axes) do
    planets
    |> Map.values()
    |> Enum.reduce(planets, fn p, planets ->
      Enum.reduce(axes, planets, fn axis, planets ->
        Map.update!(planets, p.id, fn planet ->
          velocity = Map.get(planet, String.to_atom("vel_#{axis}"))
          Map.update!(planet, axis, &(&1 + velocity))
        end)
      end)
    end)
  end

  def compute_energy(planets) do
    planets
    |> Map.values()
    |> Enum.map(
      &((abs(&1.x) + abs(&1.y) + abs(&1.z)) *
          (abs(&1.vel_x) + abs(&1.vel_y) + abs(&1.vel_z)))
    )
    |> Enum.sum()
  end

  def parse_planet({planet, i}) do
    regex = ~r/<x=(?<x>[-\d]*), *y=(?<y>[-\d]*), *z=(?<z>[-\d]*)>/

    struct(
      Planet,
      for(
        {key, val} <- Regex.named_captures(regex, planet),
        into: %{id: i},
        do: {String.to_atom(key), String.to_integer(val)}
      )
    )
  end
end
