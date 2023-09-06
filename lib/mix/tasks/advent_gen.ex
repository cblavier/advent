defmodule Mix.Tasks.Advent.Gen do
  use Mix.Task

  def run([year, day]) do
    day_with_padding = String.pad_leading(day, 2, "0")
    create_libs(year, day_with_padding)
    create_tests(year, day_with_padding)

    case download_puzzle(year, day) do
      nil -> IO.puts("could not download puzzle")
      puzzle -> create_fixtures(year, day_with_padding, puzzle)
    end
  end

  def run(_) do
    today = Date.utc_today()
    run([to_string(today.year), to_string(today.day)])
  end

  defp create_libs(year, day) do
    directory = "lib/#{year}/day#{day}"
    Mix.Generator.create_directory(directory)

    for part <- 1..2 do
      Mix.Generator.copy_template(
        "priv/templates/part.ex.eex",
        "#{directory}/part#{part}.ex",
        year: year,
        day: day,
        part: part
      )
    end
  end

  defp create_tests(year, day) do
    directory = "test/lib/#{year}"
    Mix.Generator.create_directory(directory)

    Mix.Generator.copy_template(
      "priv/templates/test.exs.eex",
      "#{directory}/day#{day}_test.exs",
      year: year,
      day: day
    )
  end

  defp create_fixtures(year, day, puzzle) do
    directory = "test/fixtures/#{year}/day#{day}"
    Mix.Generator.create_directory(directory)
    Mix.Generator.create_file("#{directory}/puzzle.txt", String.trim(puzzle))
  end

  defp download_puzzle(year, day) do
    :inets.start()
    :ssl.start()

    headers = [{~c"cookie", String.to_charlist("session=" <> System.get_env("SESSION_COOKIE"))}]
    url = ~c"https://adventofcode.com/#{year}/day/#{day}/input"

    case :httpc.request(:get, {url, headers}, [], []) do
      {:ok, {{~c"HTTP/1.1", 200, ~c"OK"}, _, puzzle}} ->
        to_string(puzzle)

      _ ->
        nil
    end
  end
end
