defmodule Advent.Y2019.Day6.Part1 do
  def run(path) do
    path |> File.read!() |> String.split() |> cumulated_path_length()
  end

  @doc ~S"""
  iex> orbits = ["COM)B", "B)C", "C)D", "E)F", "D)E", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L"]
  iex> Advent.Y2019.Day6.Part1.cumulated_path_length(orbits)
  42
  """
  def cumulated_path_length(orbits) do
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
    |> Enum.map(&(orbits |> orbits_path(&1) |> length))
    |> Enum.sum()
  end

  def orbits_path(orbits, planet, path \\ []) do
    case Map.get(orbits, planet) do
      nil -> path
      orbited -> orbits_path(orbits, orbited, path ++ [orbited])
    end
  end
end
