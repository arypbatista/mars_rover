defmodule World do
  alias World.Agent

  def new(name, rovers \\ [])
  defdelegate new(name, rovers), to: Agent

  def place_rover(world, rover) do
    %MarsRover.Rover{position: position} = rover |> MarsRover.state()
    true = Agent.empty?(world, position)
    Agent.place_rover(world, rover)
    MarsRover.added_to_world(rover, world)
    world
  end

  defdelegate get(world, position), to: Agent

  defdelegate empty?(world, position), to: Agent
end
