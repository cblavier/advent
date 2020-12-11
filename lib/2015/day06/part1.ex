defmodule Advent.Y2015.Day06.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, &apply_instruction(&1, &2))
    |> Enum.count(fn {_, status} -> status end)
  end

  @regex Regex.compile!(~S/(?<instr>.*) (?<x1>\d+),(?<y1>\d+) through (?<x2>\d+),(?<y2>\d+)/)
  def parse_line(line) do
    %{"instr" => instruction, "x1" => x1, "y1" => y1, "x2" => x2, "y2" => y2} =
      Regex.named_captures(@regex, line)

    {instruction, {String.to_integer(x1), String.to_integer(y1)},
     {String.to_integer(x2), String.to_integer(y2)}}
  end

  def apply_instruction({instruction, {x1, y1}, {x2, y2}}, grid) do
    all_positions = for x <- x1..x2, y <- y1..y2, into: [], do: {x, y}

    Enum.reduce(all_positions, grid, fn {x, y}, grid ->
      case instruction do
        "turn on" -> Map.put(grid, {x, y}, true)
        "turn off" -> Map.put(grid, {x, y}, false)
        "toggle" -> Map.update(grid, {x, y}, true, &(!&1))
      end
    end)
  end
end
