defmodule MarsRover.Directions do
  @directions [:north, :east, :south, :west]

  @direction_delta %{
    north: {0, 1},
    east: {1, 0},
    south: {0, -1},
    west: {-1, 0}
  }

  def next(direction, directions \\ @directions) do
    directions
    |> Enum.drop_while(&(&1 != direction))
    |> case do
      [_, second | _] -> second
      _ -> hd(directions)
    end
  end

  def prev(direction) do
    next(direction, Enum.reverse(@directions))
  end

  def delta(direction) do
    Map.get(@direction_delta, direction)
  end

  def opposite(direction) do
    direction
    |> next
    |> next
  end
end
