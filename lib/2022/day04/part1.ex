defmodule Advent.Y2022.Day04.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split()
    |> Enum.count(fn pair ->
      [p11, p12, p21, p22] = pair |> String.split(["-", ","]) |> Enum.map(&String.to_integer/1)
      {pair1, pair2} = {{p11, p12}, {p21, p22}}
      within_pair?(pair1, pair2) || within_pair?(pair2, pair1)
    end)
  end

  defp within_pair?({p11, p12}, {p21, p22}) do
    p11 >= p21 && p21 <= p22 && p12 >= p21 && p12 <= p22
  end
end
