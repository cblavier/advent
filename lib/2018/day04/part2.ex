defmodule Advent.Y2018.Day04.Part2 do
  alias Advent.Y2018.Day04.Part1

  def run(puzzle) do
    {guard_id, {minute, _count}} =
      puzzle
      |> Part1.parse_all_shifts()
      |> Enum.map(fn {guard_id, _minute_total, minutes} ->
        {guard_id, minutes |> Enum.to_list() |> most_asleep_minute()}
      end)
      |> Enum.max_by(fn {_guard_id, {_minute, count}} -> count end)

    {guard_id, minute}
  end

  defp most_asleep_minute([]), do: {0, 0}

  defp most_asleep_minute(minutes) do
    Enum.max_by(minutes, fn {_minute, count} -> count end)
  end
end
