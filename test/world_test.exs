defmodule WorldTest do
  use ExUnit.Case

  test "Place a rover in a world" do
    rover =
      World.new(:mars)
      |> World.place_rover(MarsRover.new({0, 0}, :north))
      |> World.get({0, 0})
      |> MarsRover.state()

    assert %MarsRover.Rover{position: {0, 0}, orientation: :north} = rover
  end

  test "Place a rover in a world and execute some commands" do
    rover = MarsRover.new({0, 0}, :north)

    world =
      World.new(:mars)
      |> World.place_rover(rover)

    rover
    |> MarsRover.execute([:f, :r, :f])

    rover =
      world
      |> World.get({1, 1})
      |> MarsRover.state()

    assert %MarsRover.Rover{position: {1, 1}, orientation: :east} = rover
  end
end
