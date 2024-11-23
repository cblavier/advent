defmodule Advent.Y2020.Day20.Part2 do
  alias Advent.Y2020.Day20.Part1

  @max_xy 11
  @monster_regexes [
    ~r/(?=(..................#.))/,
    ~r/(?=(#....##....##....###))/,
    ~r/(?=(.#..#..#..#..#..#...))/
  ]
  @monster_size 15

  def run(puzzle) do
    sorted_tiles = puzzle |> Part1.parse_puzzle() |> Part1.tiles_by_matching_borders_count()

    for(
      index <- 0..3,
      rotation <- 0..3,
      flip <- [false, true],
      do: {index, rotation, flip}
    )
    |> Task.async_stream(fn {index, rotation, flip} ->
      sorted_tiles
      |> align_tiles(index, rotation, flip)
      |> build_map()
      |> count_monsters()
      |> sea_roughness()
    end)
    |> Stream.map(&elem(&1, 1))
    |> Stream.reject(&is_nil/1)
    |> Enum.at(0)
  end

  ### Align Tiles

  def align_tiles(sorted_tiles, corner_index, corner_rotation, corner_flip) do
    pos = {0, 0}
    tile = sorted_tiles |> Map.get(2) |> Enum.at(corner_index)
    tile = tile |> transform(:rotation, corner_rotation) |> transform(:flip, corner_flip)
    map = %{pos => {tile, corner_rotation, corner_flip}}
    sorted_tiles = remove_from_tile_groups(sorted_tiles, 2, tile)
    align_tiles(sorted_tiles, map, next_pos(pos))
  end

  def align_tiles(_, map, {_x, y}) when y > @max_xy, do: map

  def align_tiles(sorted_tiles, map, pos) do
    neighbor_borders =
      pos
      |> previous_neighbors()
      |> find_in_map(map)
      |> take_neighbor_borders(pos)

    neighbour_count = neighbour_count(pos)
    candidate_tiles = Map.get(sorted_tiles, neighbour_count)

    case find_matching_tile(candidate_tiles, neighbor_borders) do
      [] ->
        nil

      [{tile, rotation, flip}] ->
        map = Map.put(map, pos, {tile, rotation, flip})
        sorted_tiles = remove_from_tile_groups(sorted_tiles, neighbour_count, tile)
        align_tiles(sorted_tiles, map, next_pos(pos))
    end
  end

  def previous_neighbors({x, y}) do
    for nx <- [x - 1, x],
        ny <- [y - 1, y],
        {nx, ny} != {x, y},
        nx == x || ny == y,
        nx >= 0 and ny >= 0,
        do: {nx, ny}
  end

  def neighbour_count({x, y}) when x in [0, @max_xy] and y in [0, @max_xy], do: 2
  def neighbour_count({x, _}) when x in [0, @max_xy], do: 3
  def neighbour_count({_, y}) when y in [0, @max_xy], do: 3
  def neighbour_count(_), do: 4

  def find_in_map(positions, map), do: for(pos <- positions, do: {pos, Map.get(map, pos)})

  def take_neighbor_borders(neighbors_with_pos, {x, y}) do
    Enum.map(neighbors_with_pos, fn
      {{^x, _}, {%{borders: borders}, _, _}} -> {:bottom, Enum.at(borders, 2)}
      {{_, ^y}, {%{borders: borders}, _, _}} -> {:right, Enum.at(borders, 1)}
    end)
  end

  def find_matching_tile(tiles, neighbor_borders) do
    tiles
    |> Enum.flat_map(&for orient <- 0..3, flip <- [true, false], do: {&1, orient, flip})
    |> Enum.map(fn {t, orient, flip} -> {transform(t, :rotation, orient), orient, flip} end)
    |> Enum.map(fn {t, orient, flip} -> {transform(t, :flip, flip), orient, flip} end)
    |> Enum.filter(fn {t, _, _} -> matching_borders?(t.borders, neighbor_borders) end)
    |> Enum.take(1)
  end

  def matching_borders?(tile_borders, neighbor_borders) do
    Enum.all?(neighbor_borders, fn
      {:bottom, border} -> Enum.at(tile_borders, 0) == border
      {:right, border} -> Enum.at(tile_borders, 3) == border
    end)
  end

  def transform(t, :rotation, 0), do: t

  def transform(t = %{borders: [b1, {b21, b22}, b3, {b41, b42}]}, :rotation, 1) do
    %{t | borders: [{b42, b41}, b1, {b22, b21}, b3]}
  end

  def transform(t = %{borders: [{b11, b12}, {b21, b22}, {b31, b32}, {b41, b42}]}, :rotation, 2) do
    %{t | borders: [{b32, b31}, {b42, b41}, {b12, b11}, {b22, b21}]}
  end

  def transform(t = %{borders: [{b11, b12}, b2, {b31, b32}, b4]}, :rotation, 3) do
    %{t | borders: [b2, {b32, b31}, b4, {b12, b11}]}
  end

  def transform(t, :flip, false), do: t

  def transform(t = %{borders: [b1, {b21, b22}, b3, {b41, b42}]}, :flip, true) do
    %{t | borders: [b3, {b22, b21}, b1, {b42, b41}]}
  end

  def remove_from_tile_groups(group, count, tile) do
    Map.update!(group, count, fn tiles -> Enum.reject(tiles, &(&1.id == tile.id)) end)
  end

  def next_pos({@max_xy, y}), do: {0, y + 1}
  def next_pos({x, y}), do: {x + 1, y}

  ### Build Map

  def build_map(nil), do: nil

  def build_map(tiles) do
    tiles
    |> Enum.map(fn {pos, {tile, rotation, flip}} ->
      rows = tile.rows |> remove_borders() |> rotate_rows(rotation) |> flip_rows(flip)
      {pos, %{tile | rows: rows}}
    end)
    |> Enum.group_by(fn {{_x, y}, _} -> y end)
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.flat_map(fn {_y, tiles} ->
      tiles
      |> Enum.sort_by(fn {{x, _y}, _} -> x end)
      |> Enum.map(&(&1 |> elem(1) |> Map.get(:rows)))
      |> Enum.zip()
      |> Enum.map(&(&1 |> Tuple.to_list() |> Enum.join()))
    end)
  end

  def rotate_rows(rows, 0), do: rows

  def rotate_rows(rows, 1) do
    rows = rows |> Enum.reverse() |> Enum.map(&String.graphemes/1)

    rows
    |> Enum.with_index()
    |> Enum.map(fn {_, i} -> rows |> Enum.map(&Enum.at(&1, i)) |> Enum.join() end)
  end

  def rotate_rows(rows, 2) do
    rows |> Enum.reverse() |> Enum.map(&String.reverse/1)
  end

  def rotate_rows(rows, 3) do
    rows = Enum.map(rows, &String.graphemes/1)

    rows
    |> Enum.with_index()
    |> Enum.map(fn {_, i} -> rows |> Enum.map(&Enum.at(&1, -i - 1)) |> Enum.join() end)
  end

  def flip_rows(rows, false), do: rows
  def flip_rows(rows, true), do: Enum.reverse(rows)

  def remove_borders(rows) do
    rows |> Enum.slice(1..-2//1) |> Enum.map(&String.slice(&1, 1..-2//1))
  end

  ### Search for monsters

  def count_monsters(nil), do: nil

  def count_monsters(map) do
    {
      map,
      map
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.map(fn rows ->
        [r1, r2, r3] =
          rows
          |> Enum.zip(@monster_regexes)
          |> Enum.map(fn {row, regex} -> Regex.scan(regex, row, return: :index) end)

        Enum.count(r1 -- r1 -- r2 -- r2 -- r3)
      end)
      |> Enum.sum()
    }
  end

  def sea_roughness(nil), do: nil
  def sea_roughness({_map, 0}), do: nil

  def sea_roughness({map, monster_count}) do
    sharp_count =
      map
      |> Enum.map(fn row -> row |> String.to_charlist() |> Enum.count(&(&1 == ?#)) end)
      |> Enum.sum()

    sharp_count - monster_count * @monster_size
  end
end
