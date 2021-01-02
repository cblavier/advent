defmodule Advent.Y2020.Day25.Part1 do
  @subject_number 7
  @divider 20_201_227

  def run(puzzle) do
    [card_public_key, door_public_key] = parse(puzzle)
    card_loop_size = guess_loop_size(@subject_number, card_public_key)
    encryption_key(door_public_key, card_loop_size)
  end

  def parse(puzzle) do
    puzzle |> String.split("\n") |> Enum.map(&String.to_integer/1)
  end

  def guess_loop_size(subject_number, public_key, val \\ 1, loop \\ 1)
  def guess_loop_size(_subject_number, same, same, loop), do: loop - 1

  def guess_loop_size(subject_number, public_key, val, loop) do
    val = transform(val, subject_number)
    guess_loop_size(subject_number, public_key, val, loop + 1)
  end

  def encryption_key(subject_number, loops, val \\ 1)
  def encryption_key(_subject_number, 0, val), do: val

  def encryption_key(subject_number, loops, val) do
    val = transform(val, subject_number)
    encryption_key(subject_number, loops - 1, val)
  end

  def transform(val, subject_number), do: rem(val * subject_number, @divider)
end
