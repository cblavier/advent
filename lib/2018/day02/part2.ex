defmodule Advent.Y2018.Day02.Part2 do
  def run(puzzle) do
    puzzle
    |> String.split()
    |> similar()
  end

  @doc ~S"""
  iex> alias Advent.Y2018.Day02.Part2
  iex> box_ids = ~w(abcde fghij klmno pqrst fguij axcye wvxyz)
  iex> Part2.similar(box_ids)
  "fgij"
  """
  def similar(box_ids) do
    for box_id_1 <- box_ids, box_id_2 <- box_ids do
      case differences(box_id_1, box_id_2) do
        {1, similar} -> throw(similar)
        _ -> :ok
      end
    end
  catch
    similar -> similar
  end

  @doc ~S"""
  iex> alias Advent.Y2018.Day02.Part2
  iex> Part2.differences("abcde", "fghij")
  {5, ""}
  iex> Part2.differences("abcde", "axcye")
  {2, "ace"}
  iex> Part2.differences("fghij", "fguij")
  {1, "fgij"}
  """
  def differences(box_id_1, box_id_2) do
    chars_1 = String.graphemes(box_id_1)
    chars_2 = String.graphemes(box_id_2)
    length = Enum.count(chars_1) - 1

    Enum.reduce(0..length, {0, ""}, fn i, {count, similar} ->
      {char1, char2} = {Enum.at(chars_1, i), Enum.at(chars_2, i)}

      if char1 == char2 do
        {count, similar <> char1}
      else
        {count + 1, similar}
      end
    end)
  end
end
