defmodule Advent.Y2024.Day08.Part2 do
  @grid_size 49

  alias Advent.Y2024.Day08.Part1

  def run(puzzle) do
    puzzle
    |> Part1.parse()
    |> Part1.find_antinodes(&antinodes/2)
    |> Enum.count()
  end

  defp antinodes({x1, y1}, {x2, y2}) do
    dx = abs(x1 - x2)
    dy = abs(y1 - y2)

    [{x1, y1}, {x2, y2}] ++
      in_direction({x1, y1}, {if(x1 > x2, do: dx, else: -dx), if(y1 > y2, do: dy, else: -dy)}) ++
      in_direction({x2, y2}, {if(x2 > x1, do: dx, else: -dx), if(y2 > y1, do: dy, else: -dy)})
  end

  defp in_direction({x, y}, {dx, dy}, acc \\ []) do
    {nx, ny} = {x + dx, y + dy}

    if nx in 0..@grid_size and ny in 0..@grid_size do
      in_direction({nx, ny}, {dx, dy}, [{nx, ny} | acc])
    else
      acc
    end
  end
end
