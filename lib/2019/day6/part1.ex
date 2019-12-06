defmodule Advent.Y2019.Day6.Part1 do
  def run(path) do
    path |> File.read!() |> String.split() |> compute_orbits()
  end

  @doc ~S"""
  iex> orbits = ["COM)B", "B)C", "C)D", "E)F", "D)E", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L"]
  iex> Advent.Y2019.Day6.Part1.compute_orbits(orbits)
  42
  """
  def compute_orbits(orbits) do
    orbits
    |> parse_orbits()
    |> count_all_orbits()
  end

  def parse_orbits(orbits) do
    for(
      orbit <- orbits,
      [planet1, planet2] = String.split(orbit, ")"),
      into: %{},
      do: {planet2, planet1}
    )
  end

  defp count_all_orbits(orbits) do
    orbits
    |> Map.keys()
    |> Enum.map(&count_orbits(orbits, &1))
    |> Enum.sum()
  end

  defp count_orbits(orbits, planet, count \\ 0) do
    case Map.get(orbits, planet) do
      nil -> count
      orbited -> count_orbits(orbits, orbited, count + 1)
    end
  end
end
