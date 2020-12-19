defmodule Advent.Y2020.Day19.Part1 do
  import String, only: [split: 2, split: 3, replace: 3, to_integer: 1]

  def run(puzzle) do
    {rules, messages} = parse_puzzle(puzzle)
    regex = build_regex(rules)
    Enum.count(messages, &Regex.match?(regex, &1))
  end

  def parse_puzzle(puzzle) do
    [rules, messages] = split(puzzle, "\n\n")

    rules =
      for rule <- split(rules, "\n"), into: %{} do
        [key, tail] = split(rule, ":")

        {to_integer(key),
         cond do
           tail =~ ~r/"[ab]+"/ ->
             {:literal, replace(tail, ["\"", " "], "")}

           tail =~ ~r/( \d+)+ \|( \d+)+/ ->
             {:or,
              for expr <- split(tail, " | ") do
                expr |> split(" ", trim: true) |> Enum.map(&to_integer/1)
              end}

           tail =~ ~r/( \d+)+/ ->
             {:redirects, for(expr <- split(tail, " ", trim: true), do: to_integer(expr))}
         end}
      end

    {rules, split(messages, "\n")}
  end

  def build_regex(rules, max_occurences \\ 1) do
    regex = build_regex(rules, 0, %{}, max_occurences)
    Regex.compile!("^#{regex}$")
  end

  def build_regex(rules, index, occurences, max_occurences) do
    case Map.get_and_update(occurences, index, fn
           nil -> {0, 1}
           n -> {n, n + 1}
         end) do
      {^max_occurences, _} ->
        ""

      {_, occurences} ->
        case Map.get(rules, index) do
          {:redirects, redirects} ->
            for i <- redirects, into: "", do: build_regex(rules, i, occurences, max_occurences)

          {:or, [or1, or2]} ->
            or1 = for i <- or1, into: "", do: build_regex(rules, i, occurences, max_occurences)
            or2 = for i <- or2, into: "", do: build_regex(rules, i, occurences, max_occurences)
            "(#{or1}|#{or2})"

          {:literal, lit} ->
            lit
        end
    end
  end
end
