defmodule MarsRover.Agent do
  alias MarsRover.Rover

  def new(position, orientation) do
    {_, agent} = Agent.start_link(fn -> Rover.new(position, orientation) end)
    agent
  end

  def execute(agent, commands) do
    Agent.update(agent, &Rover.execute(&1, commands))
    agent
  end

  def position(agent) do
    Agent.get(agent, &Rover.position/1)
  end

  def orientation(agent) do
    Agent.get(agent, &Rover.orientation/1)
  end

  def state(agent) do
    Agent.get(agent, & &1)
  end
end
