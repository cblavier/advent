"day1/puzzle.txt"
|> File.read!()
|> String.split("\n")
|> Enum.map(&String.to_integer/1)
|> Enum.map(&(div(&1, 3) - 2))
|> Enum.sum()
|> IO.puts()
