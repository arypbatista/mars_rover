defmodule MarsRover.Rover do
  alias MarsRover.Directions
  alias MarsRover.Rover

  @enforce_keys [:position, :orientation]
  defstruct [:position, :orientation, :world]

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
          :aborted -> {:halt, {last_execution_result, updated_rover}}
        end
      end)

    updated_rover
  end

  def execute_command(:f, %Rover{orientation: orientation} = rover) do
    execute_move(rover, orientation)
  end

  def execute_command(:b, %Rover{orientation: orientation} = rover) do
    execute_move(rover, Directions.opposite(orientation))
  end

  def execute_command(:l, %Rover{orientation: orientation} = rover) do
    {:ok, %Rover{rover | orientation: Directions.prev(orientation)}}
  end

  def execute_command(:r, %Rover{orientation: orientation} = rover) do
    {:ok, %Rover{rover | orientation: Directions.next(orientation)}}
  end

  def execute_command(_, rover) do
    {:invalid_command, rover}
  end

  def execute_move(%Rover{position: {x, y}, world: world} = rover, direction) do
    {delta_x, delta_y} = Directions.delta(direction)

    if is_nil(world) do
      {:ok, %Rover{rover | position: {x + delta_x, y + delta_y}}}
    else
      if World.empty?(world, {x, y}) do
        {:ok, %Rover{rover | position: {x + delta_x, y + delta_y}}}
      else
        {:aborted, rover}
      end
    end
  end

  def position(%Rover{position: position}) do
    position
  end

  def orientation(%Rover{orientation: orientation}) do
    orientation
  end

  def added_to_world(rover, world) do
    %Rover{rover | world: world}
  end
end
