defmodule MarsRover.Rover do
  alias MarsRover.Directions
  alias MarsRover.Rover

  @enforce_keys [:position, :orientation]
  defstruct [:position, :orientation]

  def new(position, orientation) do
    %Rover{position: position, orientation: orientation}
  end

  def execute(rover, commands) do
    {_, updated_rover} =
      commands
      |> Enum.reduce_while({:ok, rover}, fn command, {last_execution_result, updated_rover} ->
        case last_execution_result do
          :ok -> {:cont, execute_command(command, updated_rover)}
          :invalid_command -> {:halt, {last_execution_result, updated_rover}}
        end
      end)

    updated_rover
  end

  def execute_command(:f, %Rover{position: {x, y}, orientation: orientation}) do
    {delta_x, delta_y} = Directions.delta(orientation)
    {:ok, %Rover{position: {x + delta_x, y + delta_y}, orientation: orientation}}
  end

  def execute_command(:b, %Rover{position: {x, y}, orientation: orientation}) do
    {delta_x, delta_y} = Directions.delta(orientation)
    {:ok, %Rover{position: {x + delta_x * -1, y + delta_y * -1}, orientation: orientation}}
  end

  def execute_command(:l, %Rover{position: position, orientation: orientation}) do
    {:ok, %Rover{position: position, orientation: Directions.prev(orientation)}}
  end

  def execute_command(:r, %Rover{position: position, orientation: orientation}) do
    {:ok, %Rover{position: position, orientation: Directions.next(orientation)}}
  end

  def execute_command(_, rover) do
    {:invalid_command, rover}
  end

  def position(%Rover{position: position}) do
    position
  end

  def orientation(%Rover{orientation: orientation}) do
    orientation
  end
end
