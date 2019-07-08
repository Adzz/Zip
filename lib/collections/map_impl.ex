defimpl Zip, for: Map do
  def apply(a, b, %{calculate: calculate}) do
    overlapping_map = Map.take(b, Map.keys(a))

    Enum.reduce(a, %{}, fn {key, value}, acc ->
      Map.put(acc, key, calculate.(value, Map.fetch!(overlapping_map, key)))
    end)
  end

  # Falls back to a function call if passed a function and not a type we defined
  def apply(a, b, fun) when is_function(fun) do
    overlapping_map = Map.take(b, Map.keys(a))

    Enum.reduce(a, %{}, fn {key, value}, acc ->
      Map.put(acc, key, fun.(value, Map.fetch!(overlapping_map, key)))
    end)
  end
end

defimpl Zip, for: PID do
  def apply(a, b, %{calculate: calculate}) when is_pid(b) do
    node_1_state = Agent.get(a, fn x -> x end)
    node_2_state = Agent.get(b, fn y -> y end)

    # This seems dangerous
    Agent.start_link(fn -> calculate.(node_1_state, node_2_state) end)
  end

  def apply(a, b, fun) when is_pid(b) and is_function(fun) do
    node_1_state = Agent.get(a, fn x -> x end)
    node_2_state = Agent.get(b, fn y -> y end)

    # This seems dangerous
    Agent.start_link(fn -> fun.(node_1_state, node_2_state) end)
  end
end

# update the state in each PID by calling the fn

# Zip for CRDTs

# impl zip for PID

# {:ok, pid_1} = Agent.start_link(fn -> 0 end)
# {:ok, pid_2} = Agent.start_link(fn -> 0 end)

# Zip.apply(node_1, node_2, &CVRDT.join/2)

# defimpl Zip, for: CVRDT do
# end
