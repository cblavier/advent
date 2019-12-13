defmodule Advent.Y2019.Day13.Part2 do
  alias Advent.Y2019.Computer

  @paddle_tile 3
  @ball_tile 4

  @left -1
  @center 0
  @right 1

  def run(puzzle) do
    puzzle
    |> play_for_free()
    |> Computer.parse_program()
    |> spawn_game(self())
    |> play_game()
  end

  defp spawn_game(program, parent_pid) do
    spawn(fn ->
      Computer.run_program(program, [], parent_pid)
      send(parent_pid, :halt)
    end)
  end

  def play_game(game) do
    [:x, :y, :tile_or_score]
    |> Stream.cycle()
    |> Enum.reduce_while({0, 0, 0, 0, 0}, fn kind, state = {score, _x, _y, _ball_x, _paddle_x} ->
      receive do
        {:input, input} -> {:cont, handle_input(kind, input, state, game)}
        :halt -> {:halt, score}
      end
    end)
  end

  defp handle_input(:x, input, state, _game), do: put_elem(state, 1, input)
  defp handle_input(:y, input, state, _game), do: put_elem(state, 2, input)

  defp handle_input(:tile_or_score, input, {score, x, y, ball_x, paddle_x}, game) do
    case {x, y} do
      # new score
      {-1, 0} ->
        {input, x, y, ball_x, paddle_x}

      # something to draw
      {x, y} ->
        case input do
          # ball is moving, tilting joystick accordingly
          @ball_tile ->
            cond do
              x == paddle_x -> send(game, {:input, @center})
              x < paddle_x -> send(game, {:input, @left})
              x > paddle_x -> send(game, {:input, @right})
            end

            {score, x, y, x, paddle_x}

          # updating paddle horizontal position
          @paddle_tile ->
            {score, x, y, ball_x, x}

          _ ->
            {score, x, y, ball_x, paddle_x}
        end
    end
  end

  defp play_for_free(puzzle) do
    "2" <> String.slice(puzzle, 1..-1)
  end
end
