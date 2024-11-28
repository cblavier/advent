defmodule Advent.Y2017.Day09.Part1 do
  def run(puzzle) do
    puzzle |> String.graphemes() |> score()
  end

  def score(stream, acc \\ %{garbage: false, ignore: false, depth: 0, score: 0})
  def score([], %{score: score}), do: score

  def score([head | stream], acc) do
    case {acc, head} do
      {%{ignore: true}, _} ->
        score(stream, %{acc | ignore: false})

      {acc, "!"} ->
        score(stream, %{acc | ignore: true})

      {_, "<"} ->
        score(stream, %{acc | garbage: true})

      {_, ">"} ->
        score(stream, %{acc | garbage: false})

      {%{garbage: true}, _} ->
        score(stream, acc)

      {%{depth: depth}, "{"} ->
        score(stream, %{acc | depth: depth + 1})

      {%{depth: depth, score: score}, "}"} ->
        score(stream, %{acc | depth: depth - 1, score: depth + score})

      _ ->
        score(stream, acc)
    end
  end
end
