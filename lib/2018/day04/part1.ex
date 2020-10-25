defmodule Advent.Y2018.Day04.Part1 do
  def run(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(&parse_shift_entry/1)
    |> Enum.sort_by(fn {date, _} -> date end)
    |> chunk_by_shift()
    |> group_by_guard()
    |> Enum.map(&shift_asleep_minutes/1)
    |> Enum.max_by(fn {_guard_id, minutes_total, _minutes} -> minutes_total end)
    |> most_asleep_minute()
  end

  defp parse_shift_entry(shift_entry) do
    "[" <>
      <<year::binary-size(4)>> <>
      "-" <>
      <<month::binary-size(2)>> <>
      "-" <>
      <<day::binary-size(2)>> <>
      " " <>
      <<hour::binary-size(2)>> <>
      ":" <>
      <<minute::binary-size(2)>> <>
      "] " <> <<text::binary>> = shift_entry

    date =
      {String.to_integer(year), String.to_integer(month), String.to_integer(day),
       String.to_integer(hour), String.to_integer(minute)}

    shift_entry_details =
      case text do
        "wakes up" ->
          :wakes_up

        "falls asleep" ->
          :falls_asleep

        _ ->
          guard_id =
            text
            |> String.split(" ")
            |> Enum.at(1)
            |> String.replace_prefix("#", "")
            |> String.to_integer()

          {:begins_shift, guard_id}
      end

    {date, shift_entry_details}
  end

  defp chunk_by_shift(shift_entries) do
    Enum.chunk_while(
      shift_entries,
      [],
      fn shift = {_date, shift_entry_details}, acc ->
        case shift_entry_details do
          {:begins_shift, _id} ->
            case acc do
              [] -> {:cont, [shift]}
              _ -> {:cont, Enum.reverse(acc), [shift]}
            end

          _ ->
            {:cont, [shift | acc]}
        end
      end,
      fn acc -> {:cont, Enum.reverse(acc), []} end
    )
  end

  defp group_by_guard(shifts) do
    Enum.reduce(shifts, %{}, fn [{_date, {:begins_shift, guard_id}} | tail], acc ->
      Map.update(acc, guard_id, tail, fn shift_details ->
        shift_details ++ tail
      end)
    end)
  end

  defp shift_asleep_minutes({guard_id, shift_details}) do
    {minutes_total, minutes_acc} =
      shift_details
      |> Enum.chunk_every(2)
      |> Enum.reduce({0, %{}}, fn [
                                    {{_y1, _m1, _d1, _h1, start_minute}, :falls_asleep},
                                    {{_y2, _m2, _d2, _h2, end_minute}, :wakes_up}
                                  ],
                                  {total, minutes_acc} ->
        minutes_acc =
          Enum.reduce(start_minute..(end_minute - 1), minutes_acc, fn minute, minutes_acc ->
            Map.update(minutes_acc, minute, 1, &(&1 + 1))
          end)

        {total + end_minute - start_minute, minutes_acc}
      end)

    {guard_id, minutes_total, minutes_acc}
  end

  defp most_asleep_minute({guard_id, _minutes_total, minutes}) do
    {minute, _} = Enum.max_by(minutes, fn {_minute, count} -> count end)
    {guard_id, minute}
  end
end
