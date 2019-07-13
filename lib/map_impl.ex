defimpl Zip, for: Map do
  def apply(a, b, mod, fun, args) do
    overlapping_map = Map.take(b, Map.keys(a))

    Enum.reduce(a, %{}, fn {key, value}, acc ->
      Map.put(acc, key, Kernel.apply(mod, fun, [value, Map.fetch!(overlapping_map, key)] ++ args))
    end)
  end

  def apply(a, b, mod, fun) do
    overlapping_map = Map.take(b, Map.keys(a))

    Enum.reduce(a, %{}, fn {key, value}, acc ->
      Map.put(acc, key, Kernel.apply(mod, fun, [value, Map.fetch!(overlapping_map, key)]))
    end)
  end

  def apply(a, b, fun) when is_function(fun) do
    overlapping_map = Map.take(b, Map.keys(a))

    Enum.reduce(a, %{}, fn {key, value}, acc ->
      Map.put(acc, key, fun.(value, Map.fetch!(overlapping_map, key)))
    end)
  end
end
