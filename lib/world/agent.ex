defmodule World.Agent do
  alias World.World

  def new(name, rovers) do
    {_, agent} = Agent.start_link(fn -> World.new(name, rovers) end)
    agent
  end

  def place_rover(agent, rover) do
    Agent.update(agent, &World.place_rover(&1, rover))
    agent
  end

  def get(agent, position) do
    Agent.get(agent, &World.get(&1, position))
  end

  def empty?(agent, position) do
    Agent.get(agent, &World.empty?(&1, position))
  end

end
