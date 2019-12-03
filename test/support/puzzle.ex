defmodule Advent.Puzzle do
  def path(year, day, name \\ "puzzle.txt") do
    Path.expand("../fixtures/#{year}/day#{day}/#{name}", __DIR__)
  end
end
