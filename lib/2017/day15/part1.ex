defmodule Advent.Y2017.Day15.Part1 do
  import Bitwise

  def run(a, b) do
    {{_a, _b}, count} =
      for _i <- 1..40_000_000, reduce: {{a, b}, 0} do
        {{a, b}, count} ->
          a = rem(a * 16807, 2_147_483_647)
          b = rem(b * 48271, 2_147_483_647)

          if match16?(a, b) do
            {{a, b}, count + 1}
          else
            {{a, b}, count}
          end
      end

    count
  end

  defp match16?(a, b) do
    (a &&& 0xFFFF) == (b &&& 0xFFFF)
  end
end
