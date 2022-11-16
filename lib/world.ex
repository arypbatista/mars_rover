defmodule World do
  
  defdelegate new(name), to: World.World
  defdelegate place_rover(world, rover), to: World.World
  defdelegate get(world, position), to: World.World

end
