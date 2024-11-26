defmodule Advent.Y2017.Day03.Part1 do
  def run(puzzle) do
    puzzle = String.to_integer(puzzle)

    n =
      Stream.iterate(0, &(&1 + 1))
      |> Stream.filter(fn i -> puzzle <= surface(i) end)
      |> Enum.at(0)

    surface = surface(n)
    perimeter = 8 * n
    singulars = for i <- 0..3, do: surface - n - i * perimeter / 4
    pos = singulars |> Enum.map(&abs(puzzle - &1)) |> Enum.min()
    round(pos + n)
  end

  defp surface(n), do: :math.pow(2 * n + 1, 2)
end
