defmodule Advent.Y2017.Day13.Part2 do
  alias Advent.Y2017.Day13.Part1

  def run(puzzle) do
    firewall = Part1.parse(puzzle)
    firewall_size = firewall |> Map.keys() |> Enum.max()

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while(firewall, fn delay, firewall ->
      if caught?(firewall, firewall_size, delay) do
        {:cont, firewall}
      else
        {:halt, delay}
      end
    end)
  end

  defp caught?(firewall, firewall_size, delay) do
    Enum.reduce_while(0..firewall_size, false, fn i, _caught ->
      case Map.get(firewall, i) do
        nil ->
          {:cont, false}

        %{depth: depth} ->
          if rem(delay + i, (depth - 1) * 2) == 0 do
            {:halt, true}
          else
            {:cont, false}
          end
      end
    end)
  end
end
