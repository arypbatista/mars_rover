defmodule MarsRover do

  alias MarsRover.Rover

  @type orientation :: :north | :south | :west | :east

  @type command :: :f | :b | :l | :r
  @type commands :: [ command ]

  @type position :: {integer, integer}
  @spec new(position, orientation) :: { position, orientation }
  def new(position \\ {0,0}, orientation \\ :north)
  defdelegate new(position, orientation), to: Rover

  defdelegate execute(rover, commands), to: Rover
  defdelegate position(rover), to: Rover
  defdelegate orientation(rover), to: Rover

end
