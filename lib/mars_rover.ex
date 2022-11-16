defmodule MarsRover do
  alias MarsRover.Agent

  @type orientation :: :north | :south | :west | :east

  @type command :: :f | :b | :l | :r
  @type commands :: [command]

  @type position :: {integer, integer}
  @spec new(position, orientation) :: pid
  def new(position \\ {0, 0}, orientation \\ :north)
  defdelegate new(position, orientation), to: Agent

  defdelegate execute(rover, commands), to: Agent
  defdelegate position(rover), to: Agent
  defdelegate orientation(rover), to: Agent
  defdelegate state(rover), to: Agent
end
