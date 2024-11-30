defmodule Advent.Y2017.Day13.Part2 do
  alias Advent.Y2017.Day13.Part1

  def run(puzzle) do
    firewall = puzzle |> Part1.parse() |> as_list()

    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while(nil, fn delay, _ ->
      if caught?(firewall, delay) do
        {:cont, nil}
      else
        {:halt, delay}
      end
    end)
  end

  defp as_list(firewall) do
    for i <- 0..(firewall |> Map.keys() |> Enum.max()) do
      {firewall |> Map.get(i, %{}) |> Map.get(:depth), i}
    end
  end

  defp caught?(firewall, delay) do
    Enum.reduce_while(firewall, false, fn
      {nil, _i}, _ ->
        {:cont, false}

      {depth, i}, _ ->
        if rem(delay + i, (depth - 1) * 2) == 0 do
          {:halt, true}
        else
          {:cont, false}
        end
    end)
  end
end
