defmodule Advent.Y2024.Day13.Part1 do
  defmodule Machine do
    defstruct [:x, :y, :a, :b, :x1, :x2, :y1, :y2, :prize]
  end

  def run(puzzle) do
    puzzle
    |> parse()
    |> Enum.map(&solve/1)
    |> Enum.map(& &1.prize)
    |> Enum.sum()
  end

  def parse(puzzle, error \\ 0) do
    puzzle
    |> String.split("\n\n")
    |> Enum.map(fn machine ->
      [a_btn, b_btn, prize] = String.split(machine, "\n")
      [[_, x1, y1]] = Regex.scan(~r/Button A: X\+(\d+), Y\+(\d+)/, a_btn)
      [[_, x2, y2]] = Regex.scan(~r/Button B: X\+(\d+), Y\+(\d+)/, b_btn)
      [[_, x, y]] = Regex.scan(~r/Prize: X=(\d+), Y=(\d+)/, prize)

      %Machine{
        x: String.to_integer(x) + error,
        y: String.to_integer(y) + error,
        x1: String.to_integer(x1),
        x2: String.to_integer(x2),
        y1: String.to_integer(y1),
        y2: String.to_integer(y2)
      }
    end)
  end

  def solve(m = %Machine{x: x, y: y, x1: x1, x2: x2, y1: y1, y2: y2}) do
    a = (y - y2 / x2 * x) / (y1 - y2 * x1 / x2)
    b = (x - a * x1) / x2

    if Float.round(a, 3) == round(a) and Float.round(b, 3) == round(b) do
      %Machine{m | a: round(a), b: round(b), prize: round(3 * a + b)}
    else
      %Machine{m | prize: 0}
    end
  end
end
