defmodule Advent.Y2020.Day22.Part2 do
  alias Advent.Y2020.Day22.Part1

  def run(puzzle) do
    puzzle |> Part1.build_decks() |> play() |> Part1.score()
  end

  def play(decks, memory \\ MapSet.new())
  def play([[], deck1], _memory), do: {1, deck1}
  def play([deck0, []], _memory), do: {0, deck0}

  def play([deck0, deck1], memory) do
    if MapSet.member?(memory, deck0) do
      {0, deck0}
    else
      memory = MapSet.put(memory, deck0)
      {[card0 | deck0], [card1 | deck1]} = {deck0, deck1}

      new_decks =
        if card0 <= length(deck0) && card1 <= length(deck1) do
          case play([Enum.take(deck0, card0), Enum.take(deck1, card1)]) do
            {0, _} -> [deck0 ++ [card0, card1], deck1]
            {1, _} -> [deck0, deck1 ++ [card1, card0]]
          end
        else
          if card0 > card1 do
            [deck0 ++ [card0, card1], deck1]
          else
            [deck0, deck1 ++ [card1, card0]]
          end
        end

      play(new_decks, memory)
    end
  end
end
