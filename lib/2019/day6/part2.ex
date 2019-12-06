defmodule Advent.Y2019.Day6.Part2 do
  alias Advent.Y2019.Day6.Part1

  def run(path) do
    path |> File.read!() |> String.split() |> shortest_path("YOU", "SAN")
  end

  @doc ~S"""
  iex> orbits = ["COM)B", "B)C", "C)D", "E)F", "D)E", "B)G", "G)H"]
  iex> orbits = orbits ++ ["D)I", "E)J", "J)K", "K)L", "K)YOU", "I)SAN"]
  iex> Advent.Y2019.Day6.Part2.shortest_path(orbits, "YOU", "SAN")
  4
  """
  def shortest_path(orbits, edge1, edge2) do
    orbits = Part1.parse_orbits(orbits)
    edge1_path = orbits_path(orbits, edge1)
    edge2_path = orbits_path(orbits, edge2)
    intersection = edge1_path -- edge1_path -- edge2_path

    for(
      planet <- intersection,
      distance =
        Enum.find_index(edge1_path, &(&1 == planet)) +
          Enum.find_index(edge2_path, &(&1 == planet)),
      do: distance
    )
    |> Enum.min()
  end

  defp orbits_path(orbits, planet, path \\ []) do
    case Map.get(orbits, planet) do
      nil -> path
      orbited -> orbits_path(orbits, orbited, path ++ [orbited])
    end
  end
end
