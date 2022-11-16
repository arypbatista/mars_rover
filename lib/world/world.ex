defmodule World.World do
  alias World.World

  @enforce_keys [:name, :rovers]
  defstruct [:name, :rovers]

  @type rover :: MarsRover.Rover.t()
  @type rovers :: [rover]
  @type position :: {integer, integer}
  @type world :: %{rovers: rovers}

  @spec new(atom) :: world
  def new(name, rovers \\ []) do
    %World{name: name, rovers: rovers}
  end

  @spec place_rover(world, rover) :: world
  def place_rover(%World{rovers: rovers} = world, rover) do
    %World{world | rovers: [rover | rovers]}
  end

  @spec get(world, position) :: rover
  def get(%World{rovers: rovers}, position) do
    Enum.find(rovers, &(MarsRover.position(&1) == position))
  end

  @spec empty?(world, position) :: boolean
  def empty?(world, position) do
    get(world, position) == nil
  end
end
