defmodule Advent.Y2017.Day15.Part2 do
  import Bitwise

  def run(a, b) do
    {{_a, _b}, count} =
      for _i <- 1..5_000_000, reduce: {{a, b}, 0} do
        {{a, b}, count} ->
          a = iterate(a, 16807, 2_147_483_647, 4)
          b = iterate(b, 48271, 2_147_483_647, 8)

          if match16?(a, b) do
            {{a, b}, count + 1}
          else
            {{a, b}, count}
          end
      end

    count
  end

  defp iterate(n, factor, remainder, multiple) do
    Stream.iterate(0, & &1)
    |> Enum.reduce_while(n, fn _, n ->
      n = rem(n * factor, remainder)

      if rem(n, multiple) == 0 do
        {:halt, n}
      else
        {:cont, n}
      end
    end)
  end

  defp match16?(a, b) do
    (a &&& 0xFFFF) == (b &&& 0xFFFF)
  end
end
