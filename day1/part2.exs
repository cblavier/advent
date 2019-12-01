defmodule Part2 do
  def fuel(weight), do: div(weight, 3) - 2

  def total_weight(weights) do
    added_weight = weights |> hd |> fuel()

    if added_weight > 0 do
      total_weight([added_weight] ++ weights)
    else
      Enum.sum(weights)
    end
  end
end

"day1/puzzle.txt"
|> File.read!()
|> String.split("\n")
|> Enum.map(&String.to_integer/1)
|> Enum.map(&Part2.fuel/1)
|> Enum.map(&Part2.total_weight([&1]))
|> Enum.sum()
|> IO.puts()
