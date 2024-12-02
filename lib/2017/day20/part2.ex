defmodule Advent.Y2017.Day20.Part2 do
  alias Advent.Y2017.Day20.Part1

  def run(puzzle) do
    particles = puzzle |> Part1.parse() |> particles_as_map()

    Enum.reduce(1..100, particles, fn _i, particles ->
      particles
      |> Enum.flat_map(&elem(&1, 1))
      |> Enum.map(&evolve/1)
      |> particles_as_map()
      |> remove_duplicates()
    end)
    |> Enum.flat_map(&elem(&1, 1))
    |> length()
  end

  def particles_as_map(particles) do
    for p <- particles, reduce: %{} do
      acc -> Map.update(acc, {p.x, p.y, p.z}, [p], fn ps -> [p | ps] end)
    end
  end

  def evolve(p) do
    {vx, vy, vz} = {p.vx + p.ax, p.vy + p.ay, p.vz + p.az}
    {x, y, z} = {p.x + vx, p.y + vy, p.z + vz}
    %{p | vx: vx, vy: vy, vz: vz, x: x, y: y, z: z}
  end

  def remove_duplicates(particles_map) do
    for {_, [p]} <- particles_map,
        into: %{},
        do: {{p.x, p.y, p.z}, [p]}
  end
end
