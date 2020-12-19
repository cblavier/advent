defmodule Advent.Y2020.Day19.Part2 do
  alias Advent.Y2020.Day19.Part1

  @overwritten_rules %{
    8 => {:or, [[42], [42, 8]]},
    11 => {:or, [[42, 31], [42, 11, 31]]}
  }

  @max_depth 5

  def run(puzzle) do
    {rules, messages} = Part1.parse_puzzle(puzzle)
    rules = Map.merge(rules, @overwritten_rules)
    regex = Part1.build_regex(rules, @max_depth)
    Enum.count(messages, &Regex.match?(regex, &1))
  end
end
