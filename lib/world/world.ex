defmodule World.World do
  @enforce_keys [:name, :rovers]
  defstruct [:name, :rovers]

  @type rover :: MarsRover.Rover.t()
  @type rovers :: [rover]
  @type position :: {integer, integer}
  @type world :: %{rovers: rovers}

  @spec new(atom) :: world
  def new(name) do
    %World.World{name: name, rovers: []}
  end

  @spec place_rover(world, rover) :: world
  def place_rover(%World.World{rovers: rovers} = world, rover) do
    %World.World{world | rovers: [rover | rovers]}
  end

  @spec get(world, position) :: rover
  def get(%World.World{rovers: rovers}, position) do
    Enum.find(rovers, &(MarsRover.position(&1) == position))
  end
end
