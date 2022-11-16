defmodule MarsRover.Rover do
  alias MarsRover.Directions

  @enforce_keys [:position, :orientation]
  defstruct [:position, :orientation]

  def new(position, orientation) do
    { position, orientation }
  end

  def execute(rover, commands) do
    { _, updated_rover } = commands
                           |> Enum.reduce_while({ :ok, rover }, fn command, { last_execution_result, updated_rover } ->
      case last_execution_result do
        :ok -> { :cont, execute_command(command, updated_rover) }
        :invalid_command -> { :halt, { last_execution_result, updated_rover } }
      end
    end)
    updated_rover
  end

  def execute_command(:f, { { x, y }, orientation }) do
    { delta_x, delta_y } = Directions.delta(orientation)
    { :ok, { { x + delta_x, y + delta_y }, orientation } }
  end

  def execute_command(:b, { { x, y }, orientation }) do
    { delta_x, delta_y } = Directions.delta(orientation)
    { :ok, { { x + delta_x * -1, y + delta_y * -1 }, orientation } }
  end

  def execute_command(:l, { position, orientation }) do
    { :ok, { position, Directions.prev(orientation) } }
  end

  def execute_command(:r, { position, orientation }) do
    { :ok, { position, Directions.next(orientation) } }
  end

  def execute_command(_, rover) do
    { :invalid_command, rover }
  end

  def position({ position, _ }) do
    position
  end

  def orientation({ _, orientation }) do
    orientation
  end
  
end
