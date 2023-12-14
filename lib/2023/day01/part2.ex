defmodule Advent.Y2023.Day01.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(fn line ->
      digits()
      |> Enum.reduce(line, fn {d, index}, line ->
        String.replace(line, to_string(d), to_string(index))
      end)
      |> String.to_charlist()
      |> Enum.filter(&Enum.member?(?0..?9, &1))
      |> then(&[Enum.at(&1, 0), Enum.at(&1, -1)])
      |> to_string()
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  defp digits do
    [
      eightwo: 82,
      eighthree: 83,
      oneight: 18,
      fiveight: 58,
      threeight: 38,
      nineeight: 98,
      twone: 21,
      one: 1,
      two: 2,
      three: 3,
      four: 4,
      five: 5,
      six: 6,
      seven: 7,
      eight: 8,
      nine: 9
    ]
  end
end
