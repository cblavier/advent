defmodule Advent.Y2015.Day12.Part2 do
  def run(puzzle) do
    puzzle
    |> String.replace(~s|"red"|, to_string([?🔴]))
    |> String.to_charlist()
    |> Enum.reduce({[], 0, 1}, fn
      ?[, {scopes, _nb, _sign} -> {[new_scope(:array) | scopes], 0, 1}
      ?{, {scopes, _nb, _sign} -> {[new_scope(:object) | scopes], 0, 1}
      c, {scopes, nb, sign} when c in [?], ?}] -> {scopes |> add(nb * sign) |> close(), 0, 1}
      c, {scopes, nb, sign} when c in ?0..?9 -> {scopes, nb * 10 + (c - ?0), sign}
      ?-, {scopes, _nb, _sign} -> {scopes, 0, -1}
      ?🔴, {[scope | tail], _nb, _sign} -> {[%{scope | red: true} | tail], 0, 1}
      _, {scopes, nb, sign} -> {add(scopes, nb * sign), 0, 1}
    end)
    |> elem(0)
  end

  defp new_scope(type), do: %{type: type, red: false, numbers: []}

  defp add(scopes, 0), do: scopes
  defp add([scope = %{numbers: nbs} | tail], n), do: [%{scope | numbers: [n | nbs]} | tail]

  defp close([last_scope]), do: sum(last_scope)
  defp close([scope1, scope2 | tail]), do: add([scope2 | tail], sum(scope1))

  defp sum(%{type: :object, red: true}), do: 0
  defp sum(%{numbers: numbers}), do: Enum.sum(numbers)
end
