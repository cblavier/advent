defmodule Advent.Y2017.Day07.Part1 do
  defmodule Program do
    defstruct [:name, :weight, parents: []]
  end

  def run(puzzle) do
    puzzle |> parse() |> find_root()
  end

  def parse(puzzle) do
    puzzle
    |> String.split("\n")
    |> Enum.map(fn line ->
      case String.split(line, " -> ") do
        [program_header, parents] ->
          {name, weight} = parse_program_header(program_header)
          %Program{name: name, weight: weight, parents: String.split(parents, ", ")}

        [program_header] ->
          {name, weight} = parse_program_header(program_header)
          %Program{name: name, weight: weight}
      end
    end)
  end

  defp parse_program_header(program) do
    [[_, name, weight]] = Regex.scan(~r/(\w+) \((\d+)\)/, program)
    {name, String.to_integer(weight)}
  end

  def find_root(programs) do
    program_names = Enum.map(programs, & &1.name)
    parents = programs |> Enum.flat_map(& &1.parents) |> Enum.uniq()
    hd(program_names -- parents)
  end
end
