defmodule Advent.Y2017.Day09.Part2 do
  def run(puzzle) do
    puzzle |> String.graphemes() |> score()
  end

  def score(stream, acc \\ %{garbage: false, ignore: false, score: 0})
  def score([], %{score: score}), do: score

  def score([head | stream], acc) do
    case {acc, head} do
      {%{ignore: true}, _} ->
        score(stream, %{acc | ignore: false})

      {_, "!"} ->
        score(stream, %{acc | ignore: true})

      {%{garbage: false}, "<"} ->
        score(stream, %{acc | garbage: true})

      {_, ">"} ->
        score(stream, %{acc | garbage: false})

      {%{garbage: true, score: score}, _} ->
        score(stream, %{acc | score: score + 1})

      _ ->
        score(stream, acc)
    end
  end
end
