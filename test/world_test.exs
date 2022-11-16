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

  test "Place many rovers in a world" do
    world = World.new(:mars)

    world =
      Enum.reduce(1..10, world, fn i, world ->
        world
        |> World.place_rover(MarsRover.new({0, i}, :north))
      end)

    for i <- 1..10 do
      rover =
        world
        |> World.get({0, i})
        |> MarsRover.state()

      assert %MarsRover.Rover{position: {0, ^i}, orientation: :north} = rover
    end
  end

  test "A rover aborts a command that will cause a collision" do
    world = World.new(:mars)
      |> World.place_rover(MarsRover.new({0, 0}, :north))
      |> World.place_rover(MarsRover.new({0, 1}, :north))

    rover_state = World.get(world, {0, 0})
      |> MarsRover.execute([:f])
      |> MarsRover.state()

    assert %MarsRover.Rover{position: {0, 0}, orientation: :north} = rover_state
  end
end
