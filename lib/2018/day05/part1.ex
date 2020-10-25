defmodule Advent.Y2018.Day05.Part1 do
  def run(puzzle, chunk_size: chunk_size) do
    puzzle
    |> String.graphemes()
    |> parallel_resolve(chunk_size: chunk_size)
    |> Enum.count()
  end

  @doc ~S"""
  iex> alias Advent.Y2018.Day05.Part1
  iex> puzzle = String.graphemes("dabAcCaCBAcCcaDA")
  iex> puzzle |> Part1.parallel_resolve(chunk_size: 3) |> Enum.join()
  "dabCBAcaDA"
  """
  def parallel_resolve(puzzle, chunk_size: chunk_size) when length(puzzle) <= chunk_size do
    resolve(puzzle)
  end

  def parallel_resolve(puzzle, chunk_size: chunk_size) do
    puzzle
    |> Enum.chunk_every(chunk_size)
    |> Task.async_stream(&parallel_resolve(&1, chunk_size: chunk_size))
    |> Enum.map(&elem(&1, 1))
    |> Enum.concat()
    |> resolve()
  end

  @doc ~S"""
  iex> alias Advent.Y2018.Day05.Part1
  iex> "dabAcCaCBAcCcaDA" |> String.graphemes() |> Part1.resolve() |> Enum.join()
  "dabCBAcaDA"
  iex> "da" |> String.graphemes() |> Part1.resolve() |> Enum.join()
  "da"
  iex> "cC" |> String.graphemes() |> Part1.resolve() |> Enum.join()
  ""
  iex> "dacC" |> String.graphemes() |> Part1.resolve() |> Enum.join()
  "da"
  """
  def resolve(puzzle) do
    case find_reaction_index(puzzle) do
      nil ->
        puzzle

      index ->
        first_slice =
          case index do
            0 -> []
            _ -> Enum.slice(puzzle, 0..(index - 1))
          end

        last_slice = Enum.slice(puzzle, (index + 2)..length(puzzle))
        resolve(first_slice ++ last_slice)
    end
  end

  defp find_reaction_index(puzzle) do
    puzzle
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.with_index()
    |> Stream.filter(fn {[a, b], _index} ->
      String.upcase(a) == String.upcase(b) && a != b
    end)
    |> Enum.at(0, {0, nil})
    |> elem(1)
  end
end
