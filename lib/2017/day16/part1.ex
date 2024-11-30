defmodule Advent.Y2017.Day16.Part1 do
  defmodule Spin do
    defstruct [:count]
  end

  defmodule Exchange do
    defstruct [:pos1, :pos2]
  end

  defmodule Partner do
    defstruct [:name1, :name2]
  end

  @length 15

  def run(puzzle) do
    programs = build_program()

    puzzle
    |> parse()
    |> move(programs)
    |> programs_to_string()
  end

  def build_program do
    for i <- 0..@length, into: %{}, do: {i, ?a + i}
  end

  def parse(puzzle) do
    puzzle
    |> String.split(",")
    |> Enum.map(fn
      "s" <> count ->
        %Spin{count: String.to_integer(count)}

      "x" <> positions ->
        [p1, p2] = String.split(positions, "/")
        %Exchange{pos1: String.to_integer(p1), pos2: String.to_integer(p2)}

      "p" <> names ->
        [name1, name2] = names |> String.split("/") |> Enum.flat_map(&String.to_charlist/1)
        %Partner{name1: name1, name2: name2}
    end)
  end

  def move(instructions, programs) do
    Enum.reduce(instructions, programs, fn
      %Spin{count: count}, programs ->
        for {i, p} <- programs, into: %{} do
          {rem(i + count, @length + 1), p}
        end

      %Exchange{pos1: p1, pos2: p2}, programs ->
        %{programs | p1 => Map.get(programs, p2), p2 => Map.get(programs, p1)}

      %Partner{name1: n1, name2: n2}, programs ->
        {p1, v1} = Enum.find(programs, fn {_, v} -> v == n1 end)
        {p2, v2} = Enum.find(programs, fn {_, v} -> v == n2 end)
        %{programs | p1 => v2, p2 => v1}
    end)
  end

  def programs_to_string(programs) do
    programs
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map_join(&[elem(&1, 1)])
  end
end
