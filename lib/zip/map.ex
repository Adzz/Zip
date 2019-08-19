defimpl Zip, for: Map do
  def apply(a, b, %{zip: zip}) do
    overlapping_map = Map.take(b, Map.keys(a))

    Enum.reduce(a, %{}, fn {key, value}, acc ->
      Map.put(acc, key, zip.(value, Map.fetch!(overlapping_map, key)))
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
