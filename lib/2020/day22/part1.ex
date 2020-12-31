defmodule Advent.Y2020.Day22.Part1 do
  def run(puzzle) do
    puzzle |> build_decks() |> play() |> score()
  end

  def play([[], deck1]), do: {1, deck1}
  def play([deck0, []]), do: {0, deck0}

  def play([[card0 | deck0], [card1 | deck1]]) when card0 > card1,
    do: play([deck0 ++ [card0, card1], deck1])

  def play([[card0 | deck0], [card1 | deck1]]),
    do: play([deck0, deck1 ++ [card1, card0]])

  def build_decks(puzzle) do
    for deck <- String.split(puzzle, "\n\n") do
      for(card <- deck |> String.split("\n") |> tl(), do: String.to_integer(card))
    end
  end

  def score({_player_number, deck}) do
    deck
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {card, index} -> card * (index + 1) end)
    |> Enum.sum()
  end
end
