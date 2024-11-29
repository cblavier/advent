defmodule Advent.Y2017.Day13.Part1 do
  def run(puzzle) do
    puzzle
    |> parse()
    |> severity()
  end

  def parse(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.reduce(%{}, fn line, acc ->
      [layer, depth] = String.split(line, ": ")

      Map.put(acc, String.to_integer(layer), %{
        depth: String.to_integer(depth),
        direction: :down,
        position: 0
      })
    end)
  end

  def severity(firewall) do
    firewall_size = firewall |> Map.keys() |> Enum.max()

    {_firewall, severity} =
      Enum.reduce(0..firewall_size, {firewall, 0}, fn i, {firewall, severity} ->
        case Map.get(firewall, i) do
          %{position: 0, depth: depth} ->
            {progress(firewall), severity + i * depth}

          _ ->
            {progress(firewall), severity}
        end
      end)

    severity
  end

  def progress(firewall) do
    Enum.reduce(
      firewall,
      firewall,
      fn {i, layer = %{depth: depth, position: pos, direction: dir}}, firewall ->
        layer =
          case {pos, dir} do
            {0, _} -> %{layer | position: 1, direction: :down}
            {pos, _} when pos == depth - 1 -> %{layer | position: pos - 1, direction: :up}
            {pos, :up} -> %{layer | position: pos - 1}
            {pos, :down} -> %{layer | position: pos + 1}
          end

        Map.put(firewall, i, layer)
      end
    )
  end
end
