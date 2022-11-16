defmodule MarsRoverTest do
  use ExUnit.Case
  doctest MarsRover

  use ExUnit.Case, async: true

  test "Move forward, given a rover pointing to north" do
    position =
      MarsRover.new({0, 0}, :north)
      |> MarsRover.execute([:f])
      |> MarsRover.position()

    assert {0, 1} = position
  end

  test "Move forward, given a rover pointing to south" do
    position =
      MarsRover.new({0, 0}, :south)
      |> MarsRover.execute([:f])
      |> MarsRover.position()

    assert {0, -1} = position
  end

  test "Move forward, given a rover pointing to west" do
    position =
      MarsRover.new({0, 0}, :west)
      |> MarsRover.execute([:f])
      |> MarsRover.position()

    assert {-1, 0} = position
  end

  test "Move forward, given a rover pointing to east" do
    position =
      MarsRover.new({0, 0}, :east)
      |> MarsRover.execute([:f])
      |> MarsRover.position()

    assert {1, 0} = position
  end

  test "Move forward two times, given a rover pointing to north" do
    position =
      MarsRover.new({0, 0}, :north)
      |> MarsRover.execute([:f, :f])
      |> MarsRover.position()

    assert {0, 2} = position
  end

  test "Move backwards, given a rover pointing to north" do
    position =
      MarsRover.new({0, 0}, :north)
      |> MarsRover.execute([:b])
      |> MarsRover.position()

    assert {0, -1} = position
  end

  test "Rotate 5 times left, given a rover pointing to north" do
    orientation =
      MarsRover.new({0, 0}, :north)
      |> MarsRover.execute([:l, :l, :l, :l, :l])
      |> MarsRover.orientation()

    assert :west = orientation
  end

  test "Rotate 5 times right, given a rover pointing to north" do
    orientation =
      MarsRover.new({0, 0}, :north)
      |> MarsRover.execute([:r])
      |> MarsRover.orientation()

    assert :east = orientation
  end

  test "Given a list of commands with an invalid one, stop executing commands after it" do
    %MarsRover.Rover{position: position, orientation: orientation} =
      MarsRover.new({0, 0}, :north)
      |> MarsRover.execute([
        :f,
        :invalid,
        :r,
        :b
      ])

    assert {0, 1} = position
    assert :north = orientation
  end
end
