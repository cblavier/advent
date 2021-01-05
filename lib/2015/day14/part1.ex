defmodule Advent.Y2015.Day14.Part1 do
  def run(puzzle) do
    puzzle
    |> parse()
    |> Enum.map(&run(&1, 2503))
    |> Enum.max()
  end

  @regex ~r/[^\d]+(?<speed>\d+)[^\d]+(?<run_time>\d+)[^\d]+(?<rest_time>\d+)/
  def parse(puzzle) do
    for line <- String.split(puzzle, "\n") do
      %{"speed" => speed, "run_time" => run_time, "rest_time" => rest_time} =
        Regex.named_captures(@regex, line)

      {String.to_integer(speed), String.to_integer(run_time), String.to_integer(rest_time)}
    end
  end

  def run({speed, run_time, rest_time}, duration) do
    distance = div(duration, run_time + rest_time) * run_time * speed
    last_run = min(rem(duration, run_time + rest_time), run_time) * speed
    distance + last_run
  end
end
