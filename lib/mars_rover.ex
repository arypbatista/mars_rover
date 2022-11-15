defmodule MarsRover do

  @type orientation :: :north | :south | :west | :east

  @type command :: :f | :b | :l | :r
  @type commands :: [ command ]

  @type position :: {integer, integer}
  @spec new(position, orientation) :: { position, orientation }
  def new(position, orientation) do
    { position, orientation }
  end

  def execute(rover, commands) do
    { _, updated_rover } = commands
      |> Enum.reduce({ :ok, rover }, fn command, { last_execution_result, updated_rover } ->
        case last_execution_result do
          :ok -> execute_command(command, updated_rover)
          :invalid_command -> { last_execution_result, updated_rover}
        end
      end)
    updated_rover
  end

  def execute_command(:f, { { x, y }, orientation }) do
    updated_rover = case orientation do
      :north -> { { x, y + 1 }, orientation }
      :south -> { { x, y - 1 }, orientation }
      :west -> { { x - 1, y }, orientation }
      :east -> { { x + 1, y }, orientation }
    end
    { :ok, updated_rover }
  end

  def execute_command(:b, { { x, y }, orientation }) do
    updated_rover = case orientation do
      :north -> { { x, y - 1 }, orientation }
      :south -> { { x, y + 1 }, orientation }
      :west -> { { x + 1, y }, orientation }
      :east -> { { x - 1, y }, orientation }
    end
    { :ok, updated_rover }
  end

  def execute_command(:l, { position, orientation }) do
    updated_rover = case orientation do
      :north -> { position, :west }
      :south -> { position, :east }
      :west -> { position, :south }
      :east -> { position, :north }
    end
    { :ok, updated_rover }
  end

  def execute_command(:r, { position, orientation }) do
    updated_rover = case orientation do
      :north -> { position, :east }
      :south -> { position, :west }
      :west -> { position, :north }
      :east -> { position, :south }
    end
    { :ok, updated_rover }
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
